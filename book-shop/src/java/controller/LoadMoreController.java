/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ProductDAO;
import model.ProductDTO;

/**
 *
 * @author trang
 */
@WebServlet(name = "loadMore", urlPatterns = {"/loadMore"})
public class LoadMoreController extends HttpServlet {

    ProductDAO pdao = new ProductDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String lastIdRaw = request.getParameter("lastId");
        int lastId = Integer.parseInt(lastIdRaw);

        List<ProductDTO> listP = pdao.getNext4NewestProducts(lastId);
        PrintWriter out = response.getWriter();

        for (ProductDTO p : listP) {
            double salePrice = p.getSalePrice();
            double unitPrice = p.getUnitPrice();
            double discount = p.getDiscount();

            out.println("<div class=\"col-md-3\">");
            out.println("  <div class=\"product-item\">");
            out.println("    <figure class=\"product-style\">");
            out.println("      <a href=\"MainController?action=viewProduct&id=" + p.getProductId() + "\">");
            out.println("        <img src=\"" + p.getImage() + "\" alt=\"" + p.getProductName() + "\" class=\"product-item\">");
            out.println("      </a>");
            out.println("      <form action=\"MainController\" method=\"post\">");
            out.println("        <input type=\"hidden\" name=\"action\" value=\"addToCart\">");
            out.println("        <input type=\"hidden\" name=\"id\" value=\"" + p.getProductId() + "\">");
            out.println("        <input type=\"hidden\" name=\"qty\" value=\"1\">");
            out.println("        <button type=\"submit\" class=\"add-to-cart\">Add to Cart</button>");
            out.println("      </form>");
            out.println("    </figure>");
            out.println("    <figcaption style=\"text-align: center;\">");
            out.println("      <h3>" + p.getProductName() + "</h3>");

            if (discount > 0) {
                out.println("      <div style=\"display: flex; justify-content: center; align-items: center; gap: 0.5rem; flex-wrap: wrap; margin-top: 5px;\">");
                out.println("        <span style=\"color: #888; text-decoration: line-through; font-size: 1rem;\">");
                out.println("          " + formatPrice(unitPrice) + " đ");
                out.println("        </span>");
                out.println("        <span style=\"color: #d60000; font-size: 1.2rem; font-weight: bold;\">");
                out.println("          " + formatPrice(salePrice) + " đ");
                out.println("        </span>");
                out.println("        <span style=\"background-color: #d60000; color: #fff; font-size: 0.9rem; padding: 2px 6px; border-radius: 4px; font-weight: bold;\">");
                out.println("          -" + Math.round(discount) + "%");
                out.println("        </span>");
                out.println("      </div>");
            } else {
                out.println("      <div style=\"margin-top: 5px;\">");
                out.println("        <span style=\"color: #000; font-size: 1.2rem; font-weight: bold;\">");
                out.println("          " + formatPrice(unitPrice) + " đ");
                out.println("        </span>");
                out.println("      </div>");
            }

            out.println("    </figcaption>");
            out.println("  </div>");
            out.println("</div>");
        }

    }

    private String formatPrice(double price) {
        return String.format("%,.0f", price);
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
