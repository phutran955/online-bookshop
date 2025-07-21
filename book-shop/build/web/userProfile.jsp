<%-- 
    Document   : userProfile
    Created on : Jul 13, 2025, 8:33:21 PM
    Author     : pc
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link href="assets/profile/userProfile.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
        <style>

        </style>
    </head>
    <body>
        <div class="container">
            <!-- Header with Home Icon -->
            <div class="header">

                <div class="logo">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </div>
                <a href="index.jsp" class="home-icon" title="Go Home">
                    <i class="fas fa-home"></i>
                </a>
            </div>

            <div class="main-content">
                <!-- Left Sidebar -->
                <div class="sidebar">
                    <!-- Avatar Section -->
                    <div class="profile-section">
                        <h3>
                            <i class="fas fa-user"></i>
                            ${user.userName}
                        </h3>
                        <div class="avatar-container">
                            <img src="https://phanmemmkt.vn/wp-content/uploads/2024/09/Hinh-anh-dai-dien-mac-dinh-Facebook.jpg" alt="Avatar"/>
                        </div>
                    </div>

                    <!-- Wallet Section -->
                    <div class="wallet-section">
                        <h3>
                            <i class="fas fa-wallet"></i>
                            Wallet
                        </h3>
                        <div class="balance">
                            Balance amount: 
                            <strong> 
                                <fmt:formatNumber value="${wallet.balance}" type="number" minFractionDigits="0" />đ
                            </strong>
                        </div>
                    </div>
                </div>

                <!-- Main Profile Form -->
                <div class="profile-form">
                    <h2>
                        <i class="fas fa-cog"></i>
                        Profile
                    </h2>

                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="updateProfile"/>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-user"></i>
                                Username
                            </label>
                            <input type="text" name="userName" value="${user.userName}" readonly/>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-id-card"></i>
                                Full name
                            </label>
                            <input type="text" name="fullName" value="${user.fullName}" required/>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-map-marker-alt"></i>
                                Address
                            </label>
                            <input type="text" name="address" value="${user.address}"/>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-envelope"></i>
                                Email address
                            </label>
                            <input type="email" name="email" value="${user.email}" required/>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-phone"></i>
                                    Phone number
                                </label>
                                <input type="text" name="phone" value="${user.phone}" required/>
                            </div>
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-calendar"></i>
                                    Birth date
                                </label>
                                <input type="date" name="birthDay" value="${user.birthDay}"/>
                            </div>
                        </div>

                        <button type="submit" class="submit-btn">
                            <i class="fas fa-save"></i>
                            Update Profile
                        </button>
                    </form>

                    <!-- Messages -->
                    <c:if test="${not empty message}">
                        <div class="message">
                            <i class="fas fa-check-circle"></i>
                            ${message}
                        </div>
                    </c:if>
                    <c:if test="${not empty checkError}">
                        <div class="error">
                            <i class="fas fa-exclamation-circle"></i>
                            ${checkError}          
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>