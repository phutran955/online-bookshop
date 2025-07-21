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
import java.sql.Date;
import java.util.List;
import model.CategoryDAO;
import model.CategoryDTO;
import model.ProductDAO;
import model.ProductDTO;
import model.SupplierDTO;
import model.SupplierDAO;
import utils.AuthUtils;

/**
 *
 * @author trang
 */
@WebServlet(name = "ProductController", urlPatterns = {"/ProductController", "/pc"})
public class ProductController extends HttpServlet {

    ProductDAO pdao = new ProductDAO();
    CategoryDAO cdao = new CategoryDAO();
    SupplierDAO sdao = new SupplierDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");

            if (action.equals("viewProduct")) {
                url = handleViewSingleProduct(request, response);
            } else if (action.equals("searchProduct")) {
                url = handleProductSearching(request, response);
            } else if (action.equals("allProducts")) {
                url = handleShowProductsByPaging(request, response);
            } else if (action.equals("allDiscounts")) {
                url = handlAllDiscountViewing(request, response);

                //Admin
            } else if (action.equals("viewProducts")) {
                url = handleviewActiveProducts(request, response);
            } else if (action.equals("addProduct")) {
                url = handleProductAdding(request, response);
            } else if (action.equals("updateProduct")) {
                url = handleProductUpdating(request, response);
            } else if (action.equals("editProduct")) {
                url = handleProductEditing(request, response);
            } else if (action.equals("changeProductStatus")) {
                url = handleProductStatusChanging(request, response);
            } else if (action.equals("adminSearch")) {
                url = handleAdminProductSearching(request, response);
            } else if (action.equals("home")) {
                url = handleHome(request, response);
            }
        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String handleHome(HttpServletRequest request, HttpServletResponse response) {
        List<ProductDTO> listP = pdao.get8NewestProducts();
        List<ProductDTO> listAll = pdao.getTop8HighDiscountProducts();

        request.setAttribute("listP", listP);
        request.setAttribute("listAll", listAll);
        return "index.jsp";
    }

    private String handleViewSingleProduct(HttpServletRequest request, HttpServletResponse response) {
        int idP = Integer.parseInt(request.getParameter("idP"));
        int idS = Integer.parseInt(request.getParameter("idS"));
        ProductDTO oneP = pdao.getProductByID(idP);
        SupplierDTO oneS = sdao.getSupplierByID(idS);
        request.setAttribute("p", oneP);
        request.setAttribute("s", oneS);
        return "detail.jsp";
    }

    private String handleProductSearching(HttpServletRequest request, HttpServletResponse response) {
        final int PAGE_SIZE = 12;
        int page = 1;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        int totalProducts = pdao.countProductsByName(keyword);
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
        List<ProductDTO> listByName = pdao.getProductsByNameWithPaging(keyword, page, PAGE_SIZE);
        List<CategoryDTO> listC = cdao.getAllCategory();

        request.setAttribute("listP", listByName);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listC", listC);

        return "productsDisplay.jsp";
    }

    private String handlAllDiscountViewing(HttpServletRequest request, HttpServletResponse response) {
        final int PAGE_SIZE = 12;
        int page = 1;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int totalProducts = pdao.countDiscountedProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

        List<ProductDTO> discountedList = pdao.getDiscountedProductsWithPaging(page, PAGE_SIZE);
        List<CategoryDTO> listC = cdao.getAllCategory();

        request.setAttribute("listP", discountedList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listC", listC);
        request.setAttribute("discountFilter", true); // Optional: to indicate this is a discount page

        return "productsDisplay.jsp";
    }

    private String handleShowProductsByPaging(HttpServletRequest request, HttpServletResponse response) {
        final int PAGE_SIZE = 12;
        int page = 1;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        List<ProductDTO> listP = pdao.getProductsByPage(page, PAGE_SIZE);
        int totalProducts = pdao.countAllActiveProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

        List<CategoryDTO> listC = cdao.getAllCategory();
        request.setAttribute("listC", listC);
        request.setAttribute("listP", listP);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        return "productsDisplay.jsp";
    }

    //Admin
    private String handleviewActiveProducts(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            List<ProductDTO> listP = pdao.getAllActiveProducts();
            request.setAttribute("list", listP);
        }
        return "manageProducts.jsp";
    }

    private String handleAdminProductSearching(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String keyword = request.getParameter("keyword");
            List<ProductDTO> listByName = pdao.getProductsByName(keyword);
            request.setAttribute("list", listByName);
            request.setAttribute("keyword", keyword);
        }
        return "manageProducts.jsp";
    }

    private String handleProductStatusChanging(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String productId = request.getParameter("productId");
            String keyword = request.getParameter("keyword");
            int id_value = Integer.parseInt(productId);

            boolean updated = pdao.updateStatus(id_value, false);
            System.out.println("Status update success? " + updated); // ✅ debug log
        }
        return handleAdminProductSearching(request, response);
    }

    private String handleProductEditing(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String productId = request.getParameter("productId");
            String keyword = request.getParameter("keyword");
            int id_value = Integer.parseInt(productId);

            ProductDTO product = pdao.getProductByID(id_value);
            if (product != null) {
                request.setAttribute("keyword", keyword);
                request.setAttribute("product", product);
                request.setAttribute("isEdit", true);
            }
        }
        return "productForm.jsp";
    }

    private String handleProductUpdating(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String checkError = "";
            String message = "";

            // Lấy dữ liệu từ form
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String catID = request.getParameter("catID");
            String author = request.getParameter("author");
            String supplierID = request.getParameter("supplierID");
            String releaseDate = request.getParameter("releaseDate");
            String discount = request.getParameter("discount");
            String unitsInStock = request.getParameter("unitsInStock");
            String status = request.getParameter("status");

            int id_value = Integer.parseInt(id);
            double unitPrice = 0;
            int categoryId = 0;
            int supplierId = 0;
            int stock = 0;
            double discountPercent = 0;
            Date releaseDateValue = null;
            boolean status_value = "true".equals(status);

            // Validation
            if (name == null || name.trim().isEmpty()) {
                checkError += "Product name is required.<br/>";
            }

            if (author == null || author.trim().isEmpty()) {
                checkError += "Author is required.<br/>";
            }

            try {
                unitPrice = Double.parseDouble(price);
                if (unitPrice <= 0) {
                    checkError += "Price must be greater than zero.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid price format.<br/>";
            }

            try {
                categoryId = Integer.parseInt(catID);
                if (categoryId <= 0) {
                    checkError += "Category ID must be positive.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid Category ID.<br/>";
            }

            try {
                supplierId = Integer.parseInt(supplierID);
            } catch (Exception e) {
                checkError += "Invalid Supplier ID.<br/>";
            }

            try {
                if (releaseDate != null && !releaseDate.trim().isEmpty()) {
                    releaseDateValue = Date.valueOf(releaseDate);
                }
            } catch (Exception e) {
                checkError += "Invalid release date format.<br/>";
            }

            try {
                discountPercent = Double.parseDouble(discount);
                if (discountPercent < 0 || discountPercent > 100) {
                    checkError += "Discount must be between 0 and 100.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid discount format.<br/>";
            }

            try {
                stock = Integer.parseInt(unitsInStock);
                if (stock < 0) {
                    checkError += "Units in stock must be zero or positive.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid units in stock format.<br/>";
            }

            // Tạo DTO
            CategoryDTO cat = new CategoryDTO();
            cat.setCategoryId(categoryId);
            SupplierDTO sup = new SupplierDTO();
            sup.setSupplierId(supplierId);

            ProductDTO product = new ProductDTO(id_value, name, author, sup, cat, unitPrice, stock, image, description, releaseDateValue, discountPercent, status_value);

            if (checkError.isEmpty()) {
                if (pdao.update(product)) {
                    message = "Product updated successfully.";
                    request.setAttribute("product", product);
                    request.setAttribute("message", message);
                    request.setAttribute("isEdit", true);
                    return "productForm.jsp";  // ✅ GIỮ NGUYÊN TRANG
                } else {
                    checkError += "Failed to update product.<br/>";
                }
            }

            // Trường hợp có lỗi
            request.setAttribute("product", product);
            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
            request.setAttribute("isEdit", true);
        }

        return "productForm.jsp";
    }

    private String handleProductAdding(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            if (request.getMethod().equalsIgnoreCase("GET")) {
                // Load empty form for adding
                request.setAttribute("product", new ProductDTO());
                request.setAttribute("isEdit", false);
                return "productForm.jsp";
            }

            String checkError = "";
            String message = "";

            String name = request.getParameter("name");
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String catID = request.getParameter("catID");
            String author = request.getParameter("author");
            String supplierID = request.getParameter("supplierID");
            String releaseDate = request.getParameter("releaseDate");
            String discount = request.getParameter("discount");
            String unitsInStock = request.getParameter("unitsInStock");
            String status = request.getParameter("status");

            double unitPrice = 0;
            int categoryId = 0;
            int supplierId = 0;
            int stock = 0;
            double discountPercent = 0;
            Date releaseDateValue = null;
            boolean status_value = "true".equals(status);

            // Validation
            if (name == null || name.trim().isEmpty()) {
                checkError += "Product name is required.<br/>";
            }

            if (author == null || author.trim().isEmpty()) {
                checkError += "Author is required.<br/>";
            }

            try {
                unitPrice = Double.parseDouble(price);
                if (unitPrice <= 0) {
                    checkError += "Price must be greater than zero.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid price format.<br/>";
            }

            try {
                categoryId = Integer.parseInt(catID);
                if (categoryId <= 0) {
                    checkError += "Category ID must be positive.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid Category ID.<br/>";
            }

            try {
                supplierId = Integer.parseInt(supplierID);
            } catch (Exception e) {
                checkError += "Invalid Supplier ID.<br/>";
            }

            try {
                if (releaseDate != null && !releaseDate.trim().isEmpty()) {
                    releaseDateValue = Date.valueOf(releaseDate);
                }
            } catch (Exception e) {
                checkError += "Invalid release date format.<br/>";
            }

            try {
                discountPercent = Double.parseDouble(discount);
                if (discountPercent < 0 || discountPercent > 100) {
                    checkError += "Discount must be between 0 and 100.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid discount format.<br/>";
            }

            try {
                stock = Integer.parseInt(unitsInStock);
                if (stock < 0) {
                    checkError += "Units in stock must be zero or positive.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid units in stock format.<br/>";
            }

            CategoryDTO category = new CategoryDTO();
            category.setCategoryId(categoryId);

            SupplierDTO supplier = new SupplierDTO();
            supplier.setSupplierId(supplierId);

            ProductDTO product = new ProductDTO(name, author, supplier, category, unitPrice, stock, image, description, releaseDateValue, discountPercent, status_value);

            if (checkError.isEmpty()) {
                if (pdao.create(product)) {
                    message = "Product added successfully.";
                    request.setAttribute("message", message);
                    return "productForm.jsp";
                } else {
                    checkError = "Failed to add product to the database.";
                }
            }

            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
            request.setAttribute("product", product);
            request.setAttribute("isEdit", false);
        }

        return "productForm.jsp";
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
