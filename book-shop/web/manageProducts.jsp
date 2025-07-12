<%-- 
    Document   : products
    Created on : Jun 12, 2025, 9:30:40 PM
    Author     : trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />
<c:set var="keyword" value="${requestScope.keyword}" />

<c:set var="productList" value="${requestScope.list}" />
<c:set var="hasKeyword" value="${not empty keyword}" />
<c:set var="hasProducts" value="${not empty productList}" />
<c:set var="productCount" value="${fn:length(productList)}" />
<c:set var="keywordParam" value="${hasKeyword ? keyword : ''}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${isLoggedIn and isAdmin}">
                <div class="content-header">
                    <h1 class="page-title">Manage Products</h1>
                    <div class="header-controls">
                        <div class="search-container">
                            <form data-controller="ProductController" method="post"
                                  data-success-action="viewProducts" style="display: flex; align-items: center; gap: 10px;">
                                <input type="hidden" name="action" value="adminSearch"/>
                                <input type="text" name="keyword" value="${keyword}" 
                                       placeholder="Search product name" class="search-input"/>
                                <button type="submit" class="search-btn"></button>
                            </form>

                        </div>
                        <a href="#" class="add-product-btn action-link"
                           data-controller="ProductController" 
                           data-action="addProduct">+</a>
                    </div>
                </div>


                <div class="main-content">
                    <c:choose>
                        <c:when test="${hasProducts and productCount == 0}">
                            <div>
                                No products have names that match the keyword!
                            </div>
                        </c:when>
                        <c:when test="${hasProducts and productCount > 0}">
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Image</th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Price (VND)</th>
                                            <th>Discount (%)</th>
                                            <th>Author</th>
                                            <th>Stock</th>
                                            <th>Sold</th>
                                            <th>Release Date</th>
                                            <th>Status</th>
                                            <th>Action</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.productId}</td>
                                                <td><img src="${product.image}" style="width: 80px;" alt="${item.product.productName}" /></td>
                                                <td>${product.productName}</td>
                                                <td>${product.description}</td>
                                                <td>VND ${product.unitPrice}</td>
                                                <td>${product.discount * 100}%</td>
                                                <td>${product.author}</td>
                                                <td>${product.unitsInStock}</td>
                                                <td>${product.quantitySold}</td>
                                                <td>${product.releaseDate}</td>
                                                <td class="${product.status ? 'status-active' : 'status-inactive'}">
                                                    ${product.status ? 'Active' : 'Inactive'}
                                                </td>

                                                <td>
                                                    <div class="action-buttons">
                                                        <!-- Form Edit -->
                                                        <form class="ajax-action-form" data-controller="ProductController" data-success-action="viewProducts" method="post">
                                                            <input type="hidden" name="action" value="editProduct" />
                                                            <input type="hidden" name="productId" value="${product.productId}" />
                                                            <input type="hidden" name="keyword" value="${keyword}" />
                                                            <input type="submit" value="Edit" class="edit-btn" />
                                                        </form>

                                                        <!-- Form Delete -->
                                                        <form id="manangeProducts" data-controller="ProductController" method="post"
                                                              onsubmit="return confirm('Are you sure you want to delete this product?');">
                                                            <input type="hidden" name="action" value="changeProductStatus" />
                                                            <input type="hidden" name="productId" value="${product.productId}" />
                                                            <input type="hidden" name="keyword" value="${keyword}" />
                                                            <input type="submit" value="Delete" class="delete-btn" />
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
