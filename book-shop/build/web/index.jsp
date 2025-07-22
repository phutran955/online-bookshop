<%-- 
    Document   : index
    Created on : May 29, 2025, 10:21:32 PM
    Author     : trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${empty listP}">
    <c:redirect url="MainController?action=home" />
</c:if>

<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />


<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Book</title>
        <jsp:include page = "components/link.jsp"></jsp:include>
            <link rel="stylesheet" href="assets/css02/index.css">
        </head>

        <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">
        <jsp:include page = "components/header.jsp"></jsp:include>
            <!-- Banner -->
            <section id="promo-banner">
                <div class="banner-wrapper">
                    <a href="#special-offer">
                        <img src="assets/images/Blue Green Summer Super Sale Banner.png"
                             alt="Big Sale Banner"
                             class="banner-image">
                    </a>
                </div>
            </section>



            <!-- New Arrivals -->
            <section id="featured-books" class="py-5 my-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="section-header align-center">
                                <div class="title"><span>Some quality items</span></div>
                                <h2 class="section-title">New Arrivals</h2>
                            </div>

                            <div class="product-list" data-aos="fade-up" data-section="new-arrivals">
                                <div class="row" id="product-container">
                                <c:choose>
                                    <c:when test="${not empty listP}">
                                        <c:forEach var="p" items="${listP}">
                                            <div class="col-md-3">
                                                <div class="product-item">
                                                    <figure class="product-style">
                                                        <a href="MainController?action=viewProduct&idP=${p.productId}&idS=${p.supplier.supplierId}">
                                                            <img src="${p.image}" alt="${p.productName}" class="product-item">
                                                        </a>
                                                        <form action="MainController" method="post">
                                                            <input type="hidden" name="action" value="addToCart">
                                                            <input type="hidden" name="id" value="${p.productId}">
                                                            <input type="hidden" name="qty" value="1">
                                                            <button type="submit" class="add-to-cart">Add to Cart</button>
                                                        </form>
                                                    </figure>
                                                    <figcaption style="text-align: center;">
                                                        <h3>${p.productName}</h3>
                                                        <c:choose>
                                                            <c:when test="${p.discount > 0}">
                                                                <div style="display: flex; justify-content: center; align-items: center; gap: 0.5rem; flex-wrap: wrap; margin-top: 5px;">
                                                                    <span style="color: #888; text-decoration: line-through; font-size: 1rem;">
                                                                        <fmt:formatNumber value="${p.unitPrice}" type="number" minFractionDigits="0" /> đ
                                                                    </span>
                                                                    <span style="color: #d60000; font-size: 1.2rem; font-weight: bold;">
                                                                        <fmt:formatNumber value="${p.salePrice}" type="number" minFractionDigits="0" /> đ
                                                                    </span>
                                                                    <span style="background-color: #d60000; color: #fff; font-size: 0.9rem; padding: 2px 6px; border-radius: 4px; font-weight: bold;">
                                                                        -<fmt:formatNumber value="${p.discount*100}" type="number" maxFractionDigits="0" />%
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
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-md-12">
                                            <p>No featured products available.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="btn-wrap align-right">
                            <a id="loadMoreBtn" href="javascript:void(0)" class="btn-accent-arrow">
                                View More <i class="icon icon-ns-arrow-right"></i>
                            </a>

                            <a id="viewAllBtn" href="MainController?action=allProducts" class="btn-accent-arrow" style="display: none;">
                                View all products <i class="icon icon-ns-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Offer -->
        <section id="special-offer" class="bookshelf pb-5 mb-5">
            <div class="section-header align-center">
                <div class="title">
                    <span>Grab your opportunity</span>
                </div>
                <h2 class="section-title">Books with offer</h2>
            </div>

            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="product-list" data-aos="fade-up">
                            <div class="row" id="product-container">
                                <c:choose>
                                    <c:when test="${not empty listAll}">
                                        <c:forEach var="d" items="${listAll}">
                                            <div class="col-md-3">
                                                <div class="product-item">
                                                    <figure class="product-style">
                                                        <a href="MainController?action=viewProduct&idP=${d.productId}&idS=${d.supplier.supplierId}">
                                                            <img src="${d.image}" alt="${d.productName}" class="product-item">
                                                        </a>
                                                        <form action="MainController" method="post">
                                                            <input type="hidden" name="action" value="addToCart">
                                                            <input type="hidden" name="id" value="${d.productId}">
                                                            <input type="hidden" name="qty" value="1">
                                                            <button type="submit" class="add-to-cart">Add to Cart</button>
                                                        </form>
                                                    </figure>
                                                    <figcaption style="text-align: center;">
                                                        <h3>${d.productName}</h3>
                                                        <c:choose>
                                                            <c:when test="${d.discount > 0}">
                                                                <div style="display: flex; justify-content: center; align-items: center; gap: 0.5rem; flex-wrap: wrap; margin-top: 5px;">
                                                                    <span style="color: #888; text-decoration: line-through; font-size: 1rem;">
                                                                        <fmt:formatNumber value="${d.unitPrice}" type="number" minFractionDigits="0" /> đ
                                                                    </span>
                                                                    <span style="color: #d60000; font-size: 1.2rem; font-weight: bold;">
                                                                        <fmt:formatNumber value="${d.salePrice}" type="number" minFractionDigits="0" /> đ
                                                                    </span>
                                                                    <span style="background-color: #d60000; color: #fff; font-size: 0.9rem; padding: 2px 6px; border-radius: 4px; font-weight: bold;">
                                                                        -<fmt:formatNumber value="${d.discount*100}" type="number" maxFractionDigits="0" />%
                                                                    </span>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div style="margin-top: 5px;">
                                                                    <span style="color: #000; font-size: 1.2rem; font-weight: bold;">
                                                                        <fmt:formatNumber value="${d.unitPrice}" type="number" minFractionDigits="0" /> đ
                                                                    </span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </figcaption>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>                               
                                    <c:otherwise>
                                        <div class="col-md-12">
                                            <p>No featured products available.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="btn-wrap align-right">
                            <a href="MainController?action=allDiscounts" class="btn-accent-arrow">See More Special Offers<i
                                    class="icon icon-ns-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Supplier -->
        <section id="client-holder" data-aos="fade-up">
            <div class="section-header align-center">
                <h2 class="section-title">Our Suppliers</h2>
            </div>

            <div class="container">
                <div class="row">
                    <div class="inner-content">
                        <div class="logo-wrap">                          
                            <a href="#"><img src="assets/images/nha-nam.jpg" alt="client"></a>
                            <a href="#"><img src="assets/images/1684228751504-302190308_518846693577459_8520505824099127948_n.jpg" alt="client"></a>
                            <a href="#"><img src="assets/images/OIP.jpg" alt="client"></a>
                            <a href="#"><img src="assets/images/82_1598518883.jpg" alt="client"></a>                     
                            <a href="#"><img src="assets/images/logo_mascot_200px.jpg" alt="client"></a>
                            <a href="#"><img src="assets/images/nha-xuat-ban-kim-dong-115204.jpg" alt="client"></a>                                                     
                            <a href="#"><img src="assets/images/1702888891128-Logo-chính-xác.jpg" alt="client"></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page = "components/footer.jsp"></jsp:include>
        <script src="assets/js02/index.js" type="text/javascript"></script>
    </body>
</html>