<%-- 
    Document   : manageSuppliers
    Created on : Jul 12, 2025, 4:48:43 PM
    Author     : trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />
<c:set var="keyword" value="${requestScope.keyword}" />

<c:set var="supplierList" value="${requestScope.list}" />
<c:set var="hasKeyword" value="${not empty keyword}" />
<c:set var="hasSuppliers" value="${not empty supplierList}" />
<c:set var="supplierCount" value="${fn:length(supplierList)}" />
<c:set var="keywordParam" value="${hasKeyword ? keyword : ''}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Supplier Management</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${isLoggedIn and isAdmin}">
                <div class="content-header">
                    <h1 class="page-title">Manage Suppliers</h1>
                    <div class="header-controls">
                        <div class="search-container">
                            <form data-controller="SupplierController" method="post"
                                  data-success-action="viewSuppliers" style="display: flex; align-items: center; gap: 10px;">
                                <input type="hidden" name="action" value="searchSupplier"/>
                                <input type="text" name="keyword" value="${keyword}" 
                                       placeholder="Search supplier name" class="search-input"/>
                                <button type="submit" class="search-btn"></button>
                            </form>

                        </div>
                        <a href="#" class="add-product-btn action-link"
                           data-controller="SupplierController" 
                           data-action="addSupplier">+</a>
                    </div>
                </div>


                <div class="main-content">
                    <c:choose>
                        <c:when test="${hasSuppliers and supplierCount == 0}">
                            <div>
                                No suppliers have names that match the keyword!
                            </div>
                        </c:when>
                        <c:when test="${hasSuppliers and supplierCount > 0}">
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Company Name</th>
                                            <th>Contact Name</th>
                                            <th>Country</th>
                                            <th>Phone</th>
                                            <th>HomePage</th>               
                                            <th>Action</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="s" items="${supplierList}">
                                            <tr>
                                                <td>${s.supplierId}</td>
                                                <td>${s.companyName}</td>
                                                <td>${s.contactName}</td>
                                                <td>${s.country}</td>
                                                <td>${s.phone}</td>
                                                <td>${s.homePage}</td>

                                                <td>
                                                    <div class="action-buttons">
                                                        <!-- Form Edit -->
                                                        <form class="ajax-action-form" data-controller="SupplierController" data-success-action="viewSuppliers" method="post">
                                                            <input type="hidden" name="action" value="editSupplier" />
                                                            <input type="hidden" name="supplierId" value="${s.supplierId}" />
                                                            <input type="hidden" name="keyword" value="${keyword}" />
                                                            <input type="submit" value="Edit" class="edit-btn" />
                                                        </form>                                   
                                                    </div>

                                                </td>   
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div class="header">
                    <h1>ACCESS DENIED</h1>
                </div>
                <div class="access-denied">
                    🚫 You do not have permission to access this page.
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>
