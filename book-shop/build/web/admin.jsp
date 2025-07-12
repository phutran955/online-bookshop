
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link href="assets/css02/admin.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <div class="container">

            <!-- LEFT MENU -->
            <div class="left-box">
                <a href="MainController?action=home" class="back-to-home" id="backToHome" title="Back to Home">
                    <span class="home-icon"></span>
                    Home
                </a>

                <ul class="category-list">
                    <li><a href="#" class="action-link default active" data-controller="UserController" data-action="viewUsers">Users</a></li>
                    <li><a href="#" class="action-link" data-controller="WalletController" data-action="viewWallets">Wallets</a></li>
                    <li><a href="#" class="action-link" data-controller="ProductController"data-action="viewProducts">Products</a></li>
                    <li><a href="#" class="action-link" data-controller="CartController" data-action="viewAllOrders">Orders</a></li>
                    <li><a href="#" class="action-link" data-controller="SupplierController" data-action="viewSuppliers">Suppliers</a></li>
                </ul>
            </div>

            <!-- RIGHT CONTENT -->
            <div class="right-box" id="rightContent">
                <div class="content-section active" id="defaultContent">
                    <div id="formMessage" style="display:none; padding:10px; margin-bottom:10px;"></div>
                    <div class="default-content">
                        <h2>Admin Dashboard</h2>
                        <p>Select a category from the menu to get started</p>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js02/admin.js" type="text/javascript"></script>
    </body>
</html>
