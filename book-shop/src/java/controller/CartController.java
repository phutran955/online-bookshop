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

        // 5. Trừ tiền ví
        boolean balanceUpdated = wdao.updateBalanceByCheckOut(user.getUserName(), wallet.getBalance() - totalAmount);
        if (!balanceUpdated) {
            request.setAttribute("message", "Failed to update wallet balance.");
            return "cart.jsp";
        }

        // 6. Place the order
        boolean orderPlaced = odao.addOrder(user, cart);
        if (!orderPlaced) {
            request.setAttribute("message", "Failed to place order.");
            return "cart.jsp";
        }

        // 🔥 LẤY orderID mới nhất để gửi email
        int orderId = odao.getLatestOrderIdByUsername(user.getUserName()); // bạn cần tạo hàm này trong DAO
        if (orderId > 0) {
            OrderDTO order = odao.getOrderById(orderId); // đã bao gồm UserDTO

            // 🔥 Tạo email và gửi
            String html = EmailUtlils.generateCheckoutConfirmationEmail(order.getUser(), order);
            EmailUtlils.sendEmail(order.getUser().getEmail(), "Xác nhận đơn hàng #" + orderId, html);
        }

        // 7. Update stock and quantity sold
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

        // 8. Clear cart
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
        if (AuthUtils.isAdmin(request)) {
            String id = request.getParameter("orderId");
            String keyword = request.getParameter("keyword");
            int id_value = Integer.parseInt(id);

            boolean updated = odao.changeOrderStatus(id_value, true);
            System.out.println("Status update success? " + updated); // ✅ debug log
        }
        return handleOrdesrSearching(request, response);
    }

//Cookie
    private String handleAddToCart(HttpServletRequest request, HttpServletResponse response) {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("qty"));

            // Lấy map từ request
            Map<Integer, Integer> cartMap = CartCookieUtils.getCartMapFromRequest(request);

            // Cập nhật map
            cartMap.put(productId, cartMap.getOrDefault(productId, 0) + quantity);

            // Cập nhật cookie
            CartCookieUtils.updateCartCookie(response, cartMap);

            // Tạo lại CartDTO từ cartMap vừa cập nhật
            CartDTO cart = CartCookieUtils.buildCartFromMap(cartMap);
            request.setAttribute("cartItems", cart.getListItems());

        } catch (Exception e) {
            e.printStackTrace();
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

    /*private String handleCheckout(HttpServletRequest request, HttpServletResponse response) {
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
        double totalAmount = cart.getTotalMoney(); // Assuming this method returns total price of cart

        if (wallet == null) {
            request.setAttribute("message", "Wallet not found.");
            return "cart.jsp";
        }

        if (wallet.getBalance() < totalAmount) {
            request.setAttribute("message", "Not enough balance in wallet.");
            return "cart.jsp";
        }

        // 5. Trừ tiền ví
        boolean balanceUpdated = wdao.updateBalanceByCheckOut(user.getUserName(), wallet.getBalance() - totalAmount);
        if (!balanceUpdated) {
            request.setAttribute("message", "Failed to update wallet balance.");
            return "cart.jsp";
        }

        // 6. Place the order
        boolean orderPlaced = odao.addOrder(user, cart);
        if (!orderPlaced) {
            request.setAttribute("message", "Failed to place order.");
            return "cart.jsp";
        }

        // 7. Update stock and quantity sold
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

        // 8. Clear cart
        CartCookieUtils.clearCartCookie(response);
        request.setAttribute("message", "Order placed successfully! Your wallet has been charged.");
        return "cart.jsp";
    }*/
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
