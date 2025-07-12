/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.SupplierDAO;
import model.SupplierDTO;
import utils.AuthUtils;

@WebServlet(name = "SupplierController", urlPatterns = {"/SupplierController"})
public class SupplierController extends HttpServlet {

    SupplierDAO sdao = new SupplierDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";

        try {
            String action = request.getParameter("action");
            if (action.equals("viewSuppliers")) {
                url = handleViewSuppliers(request, response);

            } else if (action.equals("searchSupplier")) {
                url = handleSearchSupplier(request, response);

            } else if (action.equals("addSupplier")) {
                url = handleAddSupplier(request, response);

            } else if (action.equals("editSupplier")) {
                url = handleEditSupplier(request, response);

            } else if (action.equals("updateSupplier")) {
                url = handleUpdateSupplier(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }
//admin, check

    private String handleViewSuppliers(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            List<SupplierDTO> listS = sdao.getAllSuppliers();
            request.setAttribute("list", listS);
        }
        return "manageSuppliers.jsp";
    }

    private String handleSearchSupplier(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String keyword = request.getParameter("keyword");
            List<SupplierDTO> listbyName = sdao.getSuppliersByName(keyword);
            request.setAttribute("list", listbyName);
            request.setAttribute("keyword", keyword);
        }
        return "manageSuppliers.jsp";
    }

    private String handleAddSupplier(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            if (request.getMethod().equalsIgnoreCase("GET")) {
                request.setAttribute("supplier", new SupplierDTO());
                request.setAttribute("isEdit", false);
                return "supplierForm.jsp";
            }

            String checkError = "";
            String message = "";
            String name = request.getParameter("companyName");
            String contact = request.getParameter("contactName");
            String country = request.getParameter("country");
            String phone = request.getParameter("phone");
            String homepage = request.getParameter("homePage");

            if (name == null || name.trim().isEmpty()) {
                checkError += "Company Name is required.<br/>";
            }
            if (contact == null || contact.trim().isEmpty()) {
                checkError += "Contact Name is required.<br/>";
            }
            if (country == null || country.trim().isEmpty()) {
                checkError += "Country is required.<br/>";
            }
            if (phone == null || phone.trim().isEmpty()) {
                checkError += "Phone is required.<br/>";
            }

            SupplierDTO supplier = new SupplierDTO(name, contact, country, phone, homepage);

            if (checkError.isEmpty()) {
                if (sdao.create(supplier)) {
                    message = "Supplier added successfully.";
                    request.setAttribute("message", message);
                    request.setAttribute("supplier", supplier);
                    request.setAttribute("isEdit", false);
                    return "supplierForm.jsp";
                } else {
                    checkError = "Failed to add supplier to the database.";
                }
            }

            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
            request.setAttribute("supplier", supplier);
            request.setAttribute("isEdit", false);
        }
        return "supplierForm.jsp";
    }

    private String handleEditSupplier(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            int id = Integer.parseInt(request.getParameter("supplierId"));
            SupplierDTO supplier = sdao.getSupplierByID(id);
            request.setAttribute("supplier", supplier);
            request.setAttribute("isEdit", true);
        }
        return "supplierForm.jsp";
    }

    private String handleUpdateSupplier(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String checkError = "";
            String message = "";

            int id = Integer.parseInt(request.getParameter("supplierId"));
            String name = request.getParameter("companyName");
            String contact = request.getParameter("contactName");
            String country = request.getParameter("country");
            String phone = request.getParameter("phone");
            String homepage = request.getParameter("homePage");

            if (name == null || name.trim().isEmpty()) {
                checkError += "Company Name is required.<br/>";
            }
            if (contact == null || contact.trim().isEmpty()) {
                checkError += "Contact Name is required.<br/>";
            }
            if (country == null || country.trim().isEmpty()) {
                checkError += "Country is required.<br/>";
            }
            if (phone == null || phone.trim().isEmpty()) {
                checkError += "Phone is required.<br/>";
            }

            SupplierDTO supplier = new SupplierDTO(id, name, contact, country, phone, homepage);

            if (checkError.isEmpty()) {
                if (sdao.update(supplier)) {
                    message = "Supplier updated successfully.";
                    request.setAttribute("supplier", supplier);
                    request.setAttribute("message", message);
                    request.setAttribute("isEdit", true);
                    return "supplierForm.jsp";
                } else {
                    checkError = "Failed to update supplier to the database.";
                }
            }

            request.setAttribute("supplier", supplier);
            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);

            request.setAttribute("isEdit", true);
        }
        return "supplierForm.jsp";
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
