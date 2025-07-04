<%-- 
    Document   : login
    Created on : May 29, 2025, 10:28:07 PM
    Author     : trang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
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
        <link rel="stylesheet" type="text/css" href="assets/css02/login.css">
    </head>

    <body>
        <jsp:include page = "top.jsp"></jsp:include>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:redirect url="index.jsp"/>
            </c:when>
            <c:otherwise>
                <h1>Login</h1>
                <section class = "login-form">
                    <div class = "container">
                        <form action="MainController" method="post">
                            <input type="hidden" name="action" value="login"/>
                            <div>
                                <label for="strUserName">Username</label>
                                <input type="text" name="strUserName" id="strUserName" />
                            </div>
                            <div>
                                <label for="strPassword">Password</label>
                                <input type="password" name="strPassword" id="strPassword" />
                            </div>
                            <div>
                                <input type="submit" value="Login"/>
                            </div>
                        </form>
                        <c:if test="${not empty requestScope.message}">
                            <div>${requestScope.message}</div>
                        </c:if>
                    </div>
                </section>
            </c:otherwise>
        </c:choose>

        <jsp:include page = "footer.jsp"></jsp:include>

    </body>
</html>
