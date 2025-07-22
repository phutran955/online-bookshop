/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.CartDTO;
import model.ItemDTO;
import model.OrderDAO;
import model.OrderDTO;
import model.UserDTO;
import model.ProductDAO;
import model.ProductDTO;
import model.WalletDTO;
import model.WalletDAO;
import utils.EmailUtlils;
import utils.AuthUtils;
import utils.CartCookieUtils;

/**
 *
 * @author trang
 */
@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    OrderDAO odao = new OrderDAO();
    ProductDAO pdao = new ProductDAO();
    WalletDAO wdao = new WalletDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");

            if ("viewAllOrders".equals(action)) {
                url = handleViewAllOrders(request, response);
            } else if ("searchOrders".equals(action)) {
                url = handleOrdesrSearching(request, response);
            } else if ("changeOrderStatus".equals(action)) {
                url = handleChangeOrderStatus(request, response);

                //Cookie
            } else if (action.equals("addToCart")) {
                url = handleAddToCart(request, response);
            } else if (action.equals("updateQuantity")) {
                url = handleUpdateQuantity(request, response);
            } else if (action.equals("removeCart")) {
                url = handleRemoveFromCart(request, response);
            } else if (action.equals("viewCart")) {
                url = handleViewCart(request, response);
            } else if (action.equals("checkOut")) {
                url = handleCheckout(request, response);
            }
        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String handleCheckout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // 1. Require login
        if (user == null) {
            return "login.jsp";
        }

        // 2. Get cart from cookie
        CartDTO cart = CartCookieUtils.getCartFromCookie(request);
        if (cart == null || cart.getListItems().isEmpty()) {
            request.setAttribute("message", "Cart is empty!");
            return "cart.jsp";
        }

        // 3. Check stock availability
        for (ItemDTO item : cart.getListItems()) {
            int productId = item.getProduct().getProductId();
            int quantityInCart = item.getQuantity();

            ProductDTO product = pdao.getProductByID(productId);
            if (product == null) {
                request.setAttribute("message", "Product not found: ID " + productId);
                return "cart.jsp";
            }

            if (quantityInCart > product.getUnitsInStock()) {
                request.setAttribute("message", "Not enough stock for: " + product.getProductName());
                return "cart.jsp";
            }
        }

        // 4. Check wallet balance
        WalletDTO wallet = wdao.getWalletByUserName(user.getUserName());
        double totalAmount = cart.getTotalMoney();

        if (wallet == null) {
            request.setAttribute("message", "Wallet not found.");
            return "cart.jsp";
        }

        if (wallet.getBalance() < totalAmount) {
            request.setAttribute("message", "Not enough balance in wallet.");
            return "cart.jsp";
        }

        // 5. Deduct balance
        boolean balanceUpdated = wdao.updateBalanceByCheckOut(user.getUserName(), wallet.getBalance() - totalAmount);
        if (!balanceUpdated) {
            request.setAttribute("message", "Failed to update wallet balance.");
            return "cart.jsp";
        }

        // 6. Place the order and get the orderId
        int orderId = odao.addOrder(user, cart); // MUST return the generated OrderID
        if (orderId <= 0) {
            request.setAttribute("message", "Failed to place order.");
            return "cart.jsp";
        }

        // 7. Send confirmation email
        OrderDTO order = odao.getOrderById(orderId); 
        if (order != null && order.getUser() != null) {
            String html = EmailUtlils.generateCheckoutConfirmationEmail(order.getUser(), order);
            EmailUtlils.sendEmail(order.getUser().getEmail(), "Xác nhận đơn hàng #" + orderId, html);
        }

        // 8. Update stock and quantity sold
        for (ItemDTO item : cart.getListItems()) {
            int productId = item.getProduct().getProductId();
            int quantity = item.getQuantity();

            ProductDTO product = pdao.getProductByID(productId);
            if (product != null) {
                int newStock = product.getUnitsInStock() - quantity;
                pdao.updateStock(productId, newStock);
                pdao.increaseQuantitySold(productId, quantity);
            }
        }

        // 9. Clear cart
        CartCookieUtils.clearCartCookie(response);
        request.setAttribute("message", "Order placed successfully! Confirmation email sent.");
        return "cart.jsp";
    }

    private String handleViewAllOrders(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            List<OrderDTO> orders = odao.getAllOrders();
            request.setAttribute("list", orders);
        }
        return "manageOrders.jsp";
    }

    private String handleOrdesrSearching(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String keyword = request.getParameter("keyword");
            List<OrderDTO> orderByName = odao.getOrdersByUserName(keyword);
            request.setAttribute("list", orderByName);
            request.setAttribute("keyword", keyword);
        }
        return "userOrders.jsp";
    }

    private String handleChangeOrderStatus(HttpServletRequest request, HttpServletResponse response) {
        if (!AuthUtils.isAdmin(request)) {
            return handleOrdesrSearching(request, response);
        }

        String idParam = request.getParameter("orderId");
        if (idParam == null || idParam.isEmpty()) {
            return handleOrdesrSearching(request, response);
        }

        int orderId;
        try {
            orderId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            return handleOrdesrSearching(request, response);
        }

        boolean updated = odao.changeOrderStatus(orderId, true);
        System.out.println("Status update success? " + updated);

        if (updated) {
            OrderDTO order = odao.getOrderByIdForRep(orderId);

            if (order != null && order.getUser() != null && order.getUser().getEmail() != null) {
                System.out.println("Sending email to: " + order.getUser().getEmail());

                String html = EmailUtlils.generateOrderStatusUpdatedEmail(order.getUser(), order);

                EmailUtlils.sendEmail(
                        order.getUser().getEmail(),
                        "Đơn hàng #" + order.getOrderId() + " đã được xử lý",
                        html
                );
            }
        }

        return handleOrdesrSearching(request, response);
    }

//Cookie
    private String handleAddToCart(HttpServletRequest request, HttpServletResponse response) {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("qty"));

            // Get product from database
            ProductDTO product = pdao.getProductByID(productId);
            if (product == null) {
                request.setAttribute("message", "Product not found.");
                return "cart.jsp";
            }

            // Get current cart from cookie
            Map<Integer, Integer> cartMap = CartCookieUtils.getCartMapFromRequest(request);

            // Calculate total quantity after adding
            int existingQty = cartMap.getOrDefault(productId, 0);
            int newQty = existingQty + quantity;

            // 🔒 Stock check
            if (newQty > product.getUnitsInStock()) {
                request.setAttribute("message", "Not enough stock for: " + product.getProductName());
                return "cart.jsp";
            }

            // Update cart map and cookie
            cartMap.put(productId, newQty);
            CartCookieUtils.updateCartCookie(response, cartMap);

            // Build and display cart
            CartDTO cart = CartCookieUtils.buildCartFromMap(cartMap);
            request.setAttribute("cartItems", cart.getListItems());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error adding to cart.");
        }

        return "cart.jsp";
    }

    private String handleViewCart(HttpServletRequest request, HttpServletResponse response) {
        CartDTO cart = CartCookieUtils.getCartFromCookie(request);
        request.setAttribute("cartItems", cart.getListItems());
        return "cart.jsp";
    }

    private String handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response) {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            Map<Integer, Integer> cartMap = CartCookieUtils.getCartMapFromRequest(request);
            cartMap.remove(productId);
            CartCookieUtils.updateCartCookie(response, cartMap);

            CartDTO cart = CartCookieUtils.buildCartFromMap(cartMap);
            request.setAttribute("cartItems", cart.getListItems());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "cart.jsp";
    }

    private String handleUpdateQuantity(HttpServletRequest request, HttpServletResponse response) {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            int newQty = Integer.parseInt(request.getParameter("qty"));

            Map<Integer, Integer> cartMap = CartCookieUtils.getCartMapFromRequest(request);
            if (newQty <= 0) {
                cartMap.remove(productId);
            } else {
                cartMap.put(productId, newQty);
            }

            CartCookieUtils.updateCartCookie(response, cartMap);
            CartDTO cart = CartCookieUtils.buildCartFromMap(cartMap);
            request.setAttribute("cartItems", cart.getListItems());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "cart.jsp";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
