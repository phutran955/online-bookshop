<%-- 
    Document   : cart
    Created on : Jul 3, 2025, 2:09:18 PM
    Author     : trang
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Cart</title>
        <jsp:include page = "components/link.jsp"></jsp:include>
    </head>
    
    <body>
        <jsp:include page="components/header.jsp" />

        <div class="container my-5">
            <h2 class="mb-4">🛒 Your Shopping Cart</h2>

            <c:choose>
                <c:when test="${not isLoggedIn}">
                    <c:redirect url="login.jsp"/>
                </c:when>

                <c:when test="${not empty cartItems}">
                    <table class="table table-bordered text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Image</th>
                                <th>Book Title</th>
                                <th>Unit Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                            <c:set var="totalAmount" value="0" />
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td><img src="${item.product.image}" style="width: 80px;" alt="${item.product.name}"/></td>
                                    <td>${item.product.name}</td>
                                    <td>$<fmt:formatNumber value="${item.product.price}" type="number" maxFractionDigits="2"/></td>
                                    <td>${item.quantity}</td>
                                    <td>
                                        <c:set var="lineTotal" value="${item.product.price * item.quantity}" />
                                        $<fmt:formatNumber value="${lineTotal}" type="number" maxFractionDigits="2"/>
                                        <c:set var="totalAmount" value="${totalAmount + lineTotal}" />
                                    </td>
                                    <td>
                                        <form action="CartController" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="remove" />
                                            <input type="hidden" name="id" value="${item.product.id}" />
                                            <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr class="table-warning fw-bold">
                                <td colspan="4" class="text-end">Total:</td>
                                <td colspan="2">$<fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="2"/></td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="text-end">
                        <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout</a>
                        <a href="MainController?action=viewAllProducts" class="btn btn-secondary">Continue Shopping</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="alert alert-info text-center">
                        Your cart is currently empty.
                    </div>
                    <div class="text-center">
                        <a href="MainController?action=viewAllProducts" class="btn btn-primary">Browse Books</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="components/footer.jsp" />
    </body>
</html>
