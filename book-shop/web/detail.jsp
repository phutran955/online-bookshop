

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Detail</title>
        <jsp:include page="components/link.jsp" />
        <link rel="stylesheet" href="assets/css02/detail.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    </head>

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">
        <jsp:include page="components/header.jsp" />

        <section class="product-detail-container py-4">
            <div class="container">
                <div class="row">

                    <!-- Image -->
                    <div class="col-md-5 d-flex flex-column align-items-center">
                        <div class="card p-3 w-100 mb-3 text-center">
                            <div style="width: 214px; height: 320px; margin: 0 auto;">
                                <img src="${p.image}" alt="${p.productName}" class="img-fluid h-100 w-100 object-fit-cover rounded">
                            </div>
                        </div>

                        <!-- Add to Cart -->
                        <div class="d-flex justify-content-center gap-3 w-100">                          
                            <form id="add-to-cart-form" method="post">
                                <input type="hidden" name="action" value="addToCart">
                                <input type="hidden" name="id" value="${p.productId}">
                                <button type="submit" class="btn btn-success w-100">ADD TO CART</button>
                            </form>
                        </div>
                    </div>

                    <!-- Info -->
                    <div class="col-md-7 d-flex flex-column gap-3">

                        <!-- Product Name + Price -->
                        <div class="card p-3">
                            <h2 class="product-title mb-2">${p.productName}</h2>
                            <figcaption>
                                <c:choose>
                                    <c:when test="${p.discount > 0}">
                                        <div style="display: flex; gap: 0.5rem; flex-wrap: wrap; margin-top: 5px;">
                                            <span style="color: #888; text-decoration: line-through; font-size: 1rem;">
                                                <fmt:formatNumber value="${p.unitPrice}" type="number" minFractionDigits="0" /> đ
                                            </span>
                                            <span style="color: #d60000; font-size: 1.2rem; font-weight: bold;">
                                                <fmt:formatNumber value="${p.salePrice}" type="number" minFractionDigits="0" /> đ
                                            </span>
                                            <span style="background-color: #d60000; color: #fff; font-size: 0.9rem; padding: 2px 6px; border-radius: 4px; font-weight: bold;">
                                                -<fmt:formatNumber value="${p.discount}" type="number" maxFractionDigits="0" />%
                                            </span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="margin-top: 5px;">
                                            <span style="color: #000; font-size: 1.2rem; font-weight: bold;">
                                                <fmt:formatNumber value="${p.unitPrice}" type="number" minFractionDigits="0" /> đ
                                            </span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </figcaption>
                        </div>

                        <!-- Quantity Input -->
                        <div class="card p-3">
                            <h5 class="mb-2">Quantity:</h5>
                            <input type="number" id="product-qty" name="quantity" class="form-control" value="1" min="1" style="width: 120px;">
                        </div>

                        <!-- Product Info -->
                        <div class="card p-3">
                            <h5>Info</h5>
                            <table class="table table-bordered table-sm mt-3">
                                <tbody>
                                    <tr><th scope="row">Id</th><td>${p.productId}</td></tr>
                                    <tr><th scope="row">Author</th><td>${p.author}</td></tr>
                                    <tr>
                                        <th scope="row">Release Date</th>
                                        <td><fmt:formatDate value="${p.releaseDate}" pattern="dd/MM/yyyy" /></td>
                                    </tr>
                                    <tr><th scope="row">In Stock</th><td>${p.unitsInStock}</td></tr>
                                    <tr><th scope="row">Quantity Sold</th><td>${p.quantitySold}</td></tr>
                                    <tr><th scope="row">Supplier</th><td>${s.companyName}</td></tr>
                                    <tr><th scope="row">Country</th><td>${s.country}</td></tr>
                                    <tr><th scope="row">Contact Name</th><td>${s.contactName}</td></tr>
                                    <tr><th scope="row">Phone</th><td>${s.phone}</td></tr>
                                    <tr><th scope="row">Home Page</th><td>${s.homePage}</td></tr>

                                </tbody>
                            </table>
                        </div>

                        <!-- Description -->
                        <div class="card p-3">
                            <h5>Description:</h5>
                            <p>${p.description}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("add-to-cart-form");
                const qtyInput = document.getElementById("product-qty");

                form.addEventListener("submit", function (e) {
                    e.preventDefault(); // Ngăn reload trang

                    const productId = form.querySelector("input[name='id']").value;
                    const qty = parseInt(qtyInput.value);

                    if (isNaN(qty) || qty < 1) {
                        alert("Invalid quantity!");
                        return;
                    }

                    $.post("MainController", {
                        action: "addToCart",
                        id: productId,
                        qty: qty
                    }, function (response) {
                        alert("Added " + qty + " products to cart");
                        // Có thể cập nhật badge giỏ hàng ở header tại đây nếu muốn
                    });
                });
            });
        </script>

    </body>
</html>
