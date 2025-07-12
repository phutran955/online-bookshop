<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="checkError" value="${requestScope.checkError}" />
<c:set var="message" value="${requestScope.message}" />
<c:set var="product" value="${requestScope.product}" />
<c:set var="isEdit" value="${requestScope.isEdit}" />
<c:set var="keyword" value="${requestScope.keyword}" />

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Form</title>
    </head>
    <body>
        <div class="container">
            <c:choose>
                <c:when test="${sessionScope.user != null && sessionScope.user.roleID == 'AD'}">
                    <div class="form-container">
                        <form id="productForm"
                              method="post"
                              data-controller="ProductController">

                            <input type="hidden" name="action" value="${isEdit ? 'updateProduct' : 'addProduct'}" />

                            <c:if test="${isEdit}">
                                <div class="form-group">
                                    <label for="id">ID <span class="required">*</span></label>
                                    <input type="text" id="id" name="id" readonly value="${product.productId}" />
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label for="name">Name <span class="required">*</span></label>
                                <input type="text" id="name" name="name" required autocomplete="off"
                                       value="${product.productName != null ? product.productName : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="image">Image URL</label>
                                <input type="text" id="image" name="image" autocomplete="off"
                                       value="${product.image != null ? product.image : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea id="description" name="description" autocomplete="off"
                                          placeholder="Enter product description...">${product.description != null ? product.description : ''}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="price">Price <span class="required">*</span></label>
                                <input type="number" id="price" name="price" required min="0" step="0.01"
                                       value="${product.unitPrice}" />
                            </div>

                            <div class="form-group">
                                <label for="catID">Category ID <span class="required">*</span></label>
                                <input type="number" id="catID" name="catID" required min="1"
                                       value="${product.category != null ? product.category.categoryId : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="supplierID">Supplier ID <span class="required">*</span></label>
                                <input type="number" id="supplierID" name="supplierID" required min="1"
                                       value="${product.supplier != null ? product.supplier.supplierId : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="author">Author <span class="required">*</span></label>
                                <input type="text" id="author" name="author" required autocomplete="off"
                                       value="${product.author != null ? product.author : ''}" />
                            </div>

                            <div class="form-group">
                                <label for="unitsInStock">Units In Stock <span class="required">*</span></label>
                                <input type="number" id="unitsInStock" name="unitsInStock" required min="0"
                                       value="${product.unitsInStock}" />
                            </div>

                            <div class="form-group">
                                <label for="discount">Discount (%)</label>
                                <input type="number" id="discount" name="discount" min="0" max="100" step="0.01"
                                       value="${product.discount}" />
                            </div>

                            <div class="form-group">
                                <label for="releaseDate">Release Date</label>
                                <fmt:formatDate value="${product.releaseDate}" pattern="yyyy-MM-dd" var="formattedDate" />
                                <input type="date" id="releaseDate" name="releaseDate" value="${formattedDate}" />
                            </div>

                            <div class="form-group checkbox-group">
                                <input type="hidden" name="status" value="true" />
                                <input type="checkbox" id="status" value="true" checked disabled />
                                <label for="status">Active Product</label>
                            </div>


                            <div class="button-group">
                                <input type="hidden" name="keyword" value="${keyword}" />
                                <input type="submit" value="${isEdit ? 'Update Product' : 'Add Product'}" />
                                <input type="reset" value="Reset" />
                            </div>
                        </form>

                        <!-- Error or success messages -->
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
