<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Your Cart</title>
        <jsp:include page="components/link.jsp"/>
        <link href="assets/css02/cart.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="components/header.jsp"/>

        <div class="container my-5">
            <h2 class="mb-4">🛒 Cart</h2>
            <div class="cart-container">

                <!-- Left: Cart Items -->
                <div class="cart-items">
                    <table class="table table-bordered text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th class="text-start">Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <c:set var="unitPrice" value="${item.product.getSalePrice()}" />
                                <c:set var="lineTotal" value="${unitPrice * item.quantity}" />

                                <tr>
                                    <td class="text-start">
                                        <div class="product-info">
                                            <img src="${item.product.image}" style="width: 60px;" alt="${item.product.productName}" />
                                            <div>${item.product.productName}</div>
                                        </div>
                                    </td>
                                    <td><fmt:formatNumber value="${unitPrice}" type="number" maxFractionDigits="0"/> đ</td>
                                    <td>
                                        <input type="number" name="qty" value="${item.quantity}" min="1"
                                               class="form-control form-control-sm qty-input"
                                               data-id="${item.product.productId}"
                                               data-price="${unitPrice}"
                                               data-discount="${item.product.discount}"
                                               style="width: 60px;" />
                                    </td>
                                    <td class="line-total">
                                        <fmt:formatNumber value="${lineTotal}" type="number" maxFractionDigits="0"/> đ
                                    </td>
                                    <td>
                                        <form action="MainController" method="post">
                                            <input type="hidden" name="action" value="removeCart" />
                                            <input type="hidden" name="id" value="${item.product.productId}" />
                                            <button type="submit" class="btn btn-sm btn-dark" title="Remove item">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>


                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Right: Summary -->
                <div class="cart-summary">
                    <c:set var="subtotal" value="0" />
                    <c:set var="totalDiscount" value="0" />

                    <c:forEach var="item" items="${cartItems}">
                        <c:set var="price" value="${item.product.getSalePrice()}" />
                        <c:set var="qty" value="${item.quantity}" />
                        <c:set var="discountPerItem" value="${price * qty * item.product.discount}" />
                        <c:set var="lineTotal" value="${price * qty}" />

                        <c:set var="subtotal" value="${subtotal + lineTotal}" />
                        <c:set var="totalDiscount" value="${totalDiscount + discountPerItem}" />
                    </c:forEach>

                    <div class="totals">
                        <div><span>Subtotal</span><span><fmt:formatNumber value="${subtotal}" type="number" maxFractionDigits="0"/> đ</span></div>
                        <div><span>Discount</span><span><fmt:formatNumber value="${totalDiscount}" type="number" maxFractionDigits="0"/> đ</span></div>
                        <div class="total">
                            <span>Total</span>
                            <span><fmt:formatNumber value="${subtotal - totalDiscount}" type="number" maxFractionDigits="0"/> đ</span>
                        </div>
                    </div>

                    <a href="MainController?action=checkOut" class="btn btn-dark w-100 mt-3">CHECKOUT</a>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js02/cart.js" type="text/javascript"></script>
    </body>
</html>
