<%-- 
    Document   : supplierForm
    Created on : Jul 12, 2025, 4:51:44 PM
    Author     : trang
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="checkError" value="${requestScope.checkError}" />
<c:set var="message" value="${requestScope.message}" />
<c:set var="s" value="${requestScope.supplier}" />
<c:set var="isEdit" value="${requestScope.isEdit}" />
<c:set var="keyword" value="${requestScope.keyword}" />

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Supplier Form</title>
    </head>
    <body>
        <div class="container">
            <c:choose>
                <c:when test="${sessionScope.user != null && sessionScope.user.roleID == 'AD'}">
                    <div class="form-container">
                        <form id="supplierForm"
                              action="SupplierController"
                              method="post"
                              data-controller="SupplierController">

                            <input type="hidden" name="action" value="${isEdit ? 'updateSupplier' : 'addSupplier'}" />

                            <c:if test="${isEdit}">
                                <div class="form-group">
                                    <label for="supplierId">ID <span class="required">*</span></label>
                                    <input type="text" id="supplierId" name="supplierId" readonly value="${s.supplierId}" />
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label for="companyName">Company Name <span class="required">*</span></label>
                                <input type="text" id="companyName" name="companyName" required autocomplete="off"
                                       value="${s.companyName != null ? s.companyName : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="contactName">Contact Name <span class="required">*</span></label>
                                <input type="text" id="contactName" name="contactName" required autocomplete="off"
                                       value="${s.contactName != null ? s.contactName : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="country">Country <span class="required">*</span></label>
                                <input type="text" id="country" name="country" required autocomplete="off"
                                       value="${s.country != null ? s.country : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone <span class="required">*</span></label>
                                <input type="text" id="phone" name="phone" required autocomplete="off"
                                       value="${s.phone != null ? s.phone : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="homePage">HomePage <span class="required">*</span></label>
                                <input type="text" id="homePage" name="homePage" required autocomplete="off"
                                       value="${s.homePage != null ? s.homePage : ''}" />
                            </div>

                            <div class="button-group">
                                <input type="hidden" name="keyword" value="${keyword}" />
                                <input type="submit" value="${isEdit ? 'Update Supplier' : 'Add Supplier'}" />
                                <input type="reset" value="Reset" />
                            </div>
                        </form>

                        <c:if test="${not empty checkError}">
                            <div class="error-message">${checkError}</div>
                        </c:if>
                        <c:if test="${empty checkError && not empty message}">
                            <div class="success-message">${message}</div>
                        </c:if>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="header">
                        <h1>ACCESS DENIED</h1>
                    </div>
                    <div class="access-denied">
                        🚫 You do not have permission to access this page.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
