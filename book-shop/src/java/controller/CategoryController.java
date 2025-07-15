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
import java.util.List;
import model.ProductDTO;
import model.ProductDAO;
import model.CategoryDTO;
import model.CategoryDAO;

/**
 *
 * @author trang
 */
@WebServlet(name = "CategoryController", urlPatterns = {"/cc", "/CategoryController"})
public class CategoryController extends HttpServlet {

    ProductDAO pdao = new ProductDAO();
    CategoryDAO cdao = new CategoryDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");
            if (action.equals("viewCat")) {
                url = handleViewCat(request, response);
            }
        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String handleViewCat(HttpServletRequest request, HttpServletResponse response) {
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

        String catIDParam = request.getParameter("catID");
        int catID = Integer.parseInt(catIDParam);

        // Get product list by category with paging
        List<ProductDTO> listByCat = cdao.getProductsByCatIDWithPaging(catID, page, PAGE_SIZE);
        int totalProducts = cdao.countProductsByCatID(catID);
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

        // Load all categories for sidebar or filter
        List<CategoryDTO> listC = cdao.getAllCategory();

        request.setAttribute("listP", listByCat);
        request.setAttribute("listC", listC);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("catID", catID); // to preserve category filter in pagination links

        return "productsDisplay.jsp";
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
