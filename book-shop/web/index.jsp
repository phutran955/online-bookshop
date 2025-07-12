<%-- 
    Document   : index
    Created on : May 29, 2025, 10:21:32 PM
    Author     : trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />


<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Book</title>
        <jsp:include page = "components/link.jsp"></jsp:include>
            <link rel="stylesheet" href="assets/css02/index.css">
        </head>
    <jsp:include page = "components/header.jsp"></jsp:include>

        <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">

            <!-- Banner -->
            <section id="promo-banner">
                <div class="banner-wrapper">
                    <img src="assets/images/Blue Green Summer Super Sale Banner.png"
                         alt="Big Sale Banner"
                         class="banner-image">
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

                            <a id="viewAllBtn" href="MainController?action=pagingProduct" class="btn-accent-arrow" style="display: none;">
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
                                        <c:forEach var="a" items="${listAll}">
                                            <div class="col-md-3">
                                                <div class="product-item">
                                                    <figure class="product-style">
                                                        <a href="MainController?action=viewProduct&id=${a.productId}">
                                                            <img src="${a.image}" alt="${a.productName}" class="product-item">
                                                        </a>
                                                        <form action="MainController" method="post">
                                                            <input type="hidden" name="action" value="addToCart">
                                                            <input type="hidden" name="id" value="${a.productId}">
                                                            <input type="hidden" name="qty" value="1">
                                                            <button type="submit" class="add-to-cart">Add to Cart</button>
                                                        </form>
                                                    </figure>
                                                    <figcaption>
                                                        <h3>${a.productName}</h3>
                                                        <div class="item-price">
                                                            <fmt:formatNumber value="${a.unitPrice}" type="number" minFractionDigits="0"/> đ
                                                        </div>
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
            </div>
        </section>

        <!-- Supplier -->
        <section id="client-holder" data-aos="fade-up">
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
    </body>
    <jsp:include page = "components/footer.jsp"></jsp:include>
    <script>
        let loadCount = 0;

        function getLastProductId() {
            const newArrivals = document.querySelector('[data-section="new-arrivals"] #product-container');
            const inputs = newArrivals.querySelectorAll('input[name="id"]');
            if (inputs.length === 0)
                return 0;
            return inputs[inputs.length - 1].value;
        }

        document.getElementById("loadMoreBtn").addEventListener("click", function () {
            const lastId = getLastProductId();

            fetch("loadMore?lastId=" + lastId)
                    .then(response => response.text())
                    .then(html => {
                        const newArrivals = document.querySelector('[data-section="new-arrivals"] #product-container');
                        newArrivals.insertAdjacentHTML("beforeend", html);

                        loadCount++;
                        if (loadCount >= 2) {
                            document.getElementById("loadMoreBtn").style.display = "none";
                            document.getElementById("viewAllBtn").style.display = "inline-block";
                        }
                    })
                    .catch(err => console.error("Load more failed:", err));
        });
    </script>
</html>