<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Products</title>
        <jsp:include page="components/link.jsp" />
        <link rel="stylesheet" href="assets/css02/display.css">
    </head>
    <jsp:include page="components/header.jsp" />

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">
        <section class="main-wrapper my-5">

            <!-- Left: Category List + Price Filter -->
            <div class="category-box">
                <ul>
                    <c:if test="${not empty listC}">
                        <c:forEach var="c" items="${listC}">
                            <li>
                                <a href="MainController?action=viewCat&catID=${c.categoryId}">
                                    ${c.categoryName}
                                </a>
                            </li>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>

            <!-- Product List -->
            <div class="product-box">
                <div class="row">
                    <c:if test="${not empty listP}">
                        <c:forEach var="p" items="${listP}">
                            <div class="col-md-3 mb-4">
                                <div class="product-item">
                                    <figure class="product-style">
                                        <a href="MainController?action=viewProduct&id=${p.productId}">
                                            <img src="${p.image}" alt="${p.productName}" class="product-item">
                                        </a>
                                        <form action="MainController" method="post">
                                            <input type="hidden" name="action" value="addToCart">
                                            <input type="hidden" name="id" value="${p.productId}">
                                            <input type="hidden" name="qty" value="1">
                                            <button type="submit" class="add-to-cart">Add to Cart</button>
                                        </form>
                                    </figure>
                                    <figcaption>
                                        <h3>${p.productName}</h3>
                                        <div class="item-price">
                                            <fmt:formatNumber value="${p.unitPrice}" type="number" minFractionDigits="0"/> đ
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

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="row">
                        <div class="col-md-12">
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center mt-4">
                                    <!-- Previous -->
                                    <c:choose>
                                        <c:when test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="MainController?action=pagingProduct&page=${currentPage - 1}">Previous</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item disabled">
                                                <a class="page-link" href="#">Previous</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Page numbers -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <c:choose>
                                            <c:when test="${i == currentPage}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="#">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="MainController?action=pagingProduct&page=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <!-- Next -->
                                    <c:choose>
                                        <c:when test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="MainController?action=pagingProduct&page=${currentPage + 1}">Next</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item disabled">
                                                <a class="page-link" href="#">Next</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>
        <jsp:include page="components/footer.jsp" />
    </body>
</html>
