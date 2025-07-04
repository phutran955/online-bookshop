
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="utils.AuthUtils" %>
<%@page import="model.UserDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Displaying</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/icomoon/icomoon.css">
        <link rel="stylesheet" href="assets/css/vendor.css">
        <link rel="stylesheet" href="assets/css/style.css">
    </head>

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">

        <jsp:include page = "top.jsp"></jsp:include>

            <!-- Main Content -->
            <section id="all-products" class="bookshelf py-5 my-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="product-list">
                                <div class="row">

                                <c:if test="${not empty listP}">                                   
                                    <c:forEach var="p" items="${listP}">
                                        <div class="col-md-3 mb-4">
                                            <div class="product-item">
                                                <figure class="product-style">

                                                    <a href="MainController?action=viewProduct&id=${p.productId}">
                                                        <img src="${p.image}" alt="${p.productName}" class="product-item">
                                                    </a>

                                                    <form action="MainController" method="get">
                                                        <input type="hidden" name="action" value="addToCart">
                                                        <input type="hidden" name="id" value="${p.productId}">
                                                        <input type="hidden" name="qty" value="1">
                                                        <button type="submit" class="add-to-cart">Add to Cart</button>
                                                    </form>
                                                </figure>

                                                <figcaption>
                                                    <h3>${p.productName}</h3>
                                                    <div class="item-price">
                                                        <fmt:formatNumber value="${p.unitPrice}" type="number" minFractionDigits="0"/>VND
                                                    </div>
                                                </figcaption>
                                            </div>
                                        </div>
                                    </c:forEach>                                 
                                </c:if>

                                <c:if test="${empty listP}">
                                    <div class="col-md-12">
                                        <div class="alert alert-info">No products available at this time.</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Pagination (static for now) -->
                        <div class="row">
                            <div class="col-md-12">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page = "footer.jsp"></jsp:include>   
    </body>
</html>
