<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="checkError" value="${requestScope.checkError}" />
<c:set var="message" value="${requestScope.message}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register User</title>
</head>
<body>

    <div class="header">
        <a href="login.jsp" class="back-link">← Back to login page</a>
        <h1>REGISTER USER</h1>
    </div>

    <div class="form-container">
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="register"/>

            <div class="form-group">
                <label for="userName">User Name <span class="required">*</span></label>
                <input type="text" id="userName" name="userName" required value="${user.userName}" />
            </div>

            <div class="form-group">
                <label for="fullName">Full Name <span class="required">*</span></label>
                <input type="text" id="fullName" name="fullName" required value="${user.fullName}" />
            </div>

            <div class="form-group">
                <label for="password">Password <span class="required">*</span></label>
                <input type="password" id="password" name="password" required value="${user.password}" />
            </div>

            <div class="form-group">
                <label for="email">Email <span class="required">*</span></label>
                <input type="email" id="email" name="email" required value="${user.email}" />
            </div>

            <div class="form-group">
                <label for="birthDay">BirthDay</label>
                <input type="date" id="birthDay" name="birthDay" value="${user.birthDay}" />
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="${user.address}" />
            </div>

            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" id="phone" name="phone" value="${user.phone}" />
            </div>

            <div class="button-group">
                <input type="submit" value="Create Account"/>
                <input type="reset" value="Reset"/>
            </div>
        </form>

        <c:if test="${not empty checkError}">
            <div class="error-message">${checkError}</div>
        </c:if>
        <c:if test="${empty checkError && not empty message}">
            <div class="success-message">${message}</div>
        </c:if>
    </div>

</body>
</html>
