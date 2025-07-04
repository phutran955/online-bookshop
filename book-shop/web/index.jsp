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
        <title>BookSaw</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/normalize.css">
        <link rel="stylesheet" type="text/css" href="assets/icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="assets/css/vendor.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    </head>

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">

        <jsp:include page = "top.jsp"></jsp:include>

            <!-- Billboard -->
            <section id="billboard">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">

                            <button class="prev slick-arrow">
                                <i class="icon icon-arrow-left"></i>
                            </button>

                            <div class="main-slider pattern-overlay">
                                <div class="slider-item">
                                    <div class="banner-content">
                                        <h2 class="banner-title">Life of the Wild</h2>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu feugiat amet, libero
                                            ipsum enim pharetra hac. Urna commodo, lacus ut magna velit eleifend. Amet, quis
                                            urna, a eu.</p>
                                        <div class="btn-wrap">
                                            <a href="#" class="btn btn-outline-accent btn-accent-arrow">Read More<i
                                                    class="icon icon-ns-arrow-right"></i></a>
                                        </div>
                                    </div><!--banner-content-->
                                    <img src="assets/images/main-banner1.jpg" alt="banner" class="banner-image">
                                </div>
                            </div>

                            <button class="next slick-arrow">
                                <i class="icon icon-arrow-right"></i>
                            </button>

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
                        <div class="inner-content">
                            <div class="product-list" data-aos="fade-up">
                                <div class="grid product-grid">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="assets/images/product-item5.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>Simple way of piece life</h3>
                                            <span>Armor Ramsey</span>
                                            <div class="item-price">
                                                <span class="prev-price">$ 50.00</span>$ 40.00
                                            </div>
                                        </figcaption>
                                    </div>


                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="assets/images/product-item6.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>Great travel at desert</h3>
                                            <span>Sanchit Howdy</span>
                                            <div class="item-price">
                                                <span class="prev-price">$ 30.00</span>$ 38.00
                                            </div>
                                        </figcaption>
                                    </div>

                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="assets/images/product-item7.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>The lady beauty Scarlett</h3>
                                            <span>Arthur Doyle</span>
                                            <div class="item-price">
                                                <span class="prev-price">$ 35.00</span>$ 45.00
                                            </div>
                                    </div>
                                    </figcaption>

                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="assets/images/product-item8.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>Once upon a time</h3>
                                            <span>Klien Marry</span>
                                            <div class="item-price">
                                                <span class="prev-price">$ 25.00</span>$ 35.00
                                            </div>
                                    </div>
                                    </figcaption>

                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="assets/images/product-item2.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>Simple way of piece life</h3>
                                            <span>Armor Ramsey</span>
                                            <div class="item-price">$ 40.00</div>
                                        </figcaption>
                                    </div>
                                </div><!--grid-->
                            </div>
                        </div><!--inner-content-->
                    </div>
                </div>
            </section>


            <!-- Featured Books -->
            <section id="featured-books" class="py-5 my-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            
                            <div class="section-header align-center">
                                <div class="title"><span>Some quality items</span></div>
                                <h2 class="section-title">New Arrivals</h2>
                            </div>
                            
                            <div class="product-list" data-aos="fade-up">
                                <div class="row">
                                <c:choose>
                                    <c:when test="${not empty listP}">
                                        <c:forEach var="p" items="${listP}">
                                            <div class="col-md-3">
                                                <div class="product-item">
                                                    <figure class="product-style">
                                                        <img src="${p.image}" alt="${p.productName}" class="product-item">
                                                        <button type="button" class="add-to-cart">Add to Cart</button>
                                                    </figure>
                                                    <figcaption>
                                                        <h3>${p.productName}</h3>
                                                        <div class="item-price">
                                                            $<fmt:formatNumber value="${p.unitPrice}" type="number" maxFractionDigits="2"/>
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

                <div class="row">
                    <div class="col-md-12">
                        <div class="btn-wrap align-right">
                            <a href="MainController?action=viewAllProducts" class="btn-accent-arrow">
                                View all products <i class="icon icon-ns-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page = "footer.jsp"></jsp:include>
    </body>
</html>