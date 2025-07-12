<%-- 
    Document   : manageOrders
    Created on : Jul 12, 2025, 7:52:30 PM
    Author     : trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />
<c:set var="keyword" value="${requestScope.keyword}" />

<c:set var="orderList" value="${requestScope.list}" />
<c:set var="hasKeyword" value="${not empty keyword}" />
<c:set var="hasOrders" value="${not empty orderList}" />
<c:set var="orderCount" value="${fn:length(orderList)}" />
<c:set var="keywordParam" value="${hasKeyword ? keyword : ''}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Management</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${isLoggedIn and isAdmin}">
                <div class="content-header">
                    <h1 class="page-title">Manage Orders</h1>
                    <div class="header-controls">
                        <div class="search-container">
                            <form data-controller="CartController" method="post"
                                  data-success-action="viewAllOrders" style="display: flex; align-items: center; gap: 10px;">
                                <input type="hidden" name="action" value="searchOrders"/>
                                <input type="text" name="keyword" value="${keyword}" 
                                       placeholder="Search order name" class="search-input"/>
                                <button type="submit" class="search-btn"></button>
                            </form>

                        </div>
                    </div>
                </div>


                <div class="main-content">
                    <c:choose>
                        <c:when test="${hasOrders and orderCount == 0}">
                            <div>
                                No orders have names that match the keyword!
                            </div>
                        </c:when>
                        <c:when test="${hasOrders and orderCount > 0}">
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Date</th>
                                            <th>User Name</th>
                                            <th>Total Money</th>
                                            <th>Status</th>
                                            <th>Action</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${orderList}">
                                            <tr>
                                                <td>${o.orderId}</td>
                                                <td>${o.date}</td>
                                                <td>${o.user.userName}</td>
                                                <td>${o.totalMoney}</td>

                                                <td class="${o.status ? 'status-active' : 'status-inactive'}">
                                                    ${o.status ? 'Handled' : 'Wait'}
                                                </td>

                                                <td>
                                                    <div class="action-buttons">
                                                        <form data-controller="CartController" method="post">
                                                            <input type="hidden" name="action" value="changeOrderStatus" />
                                                            <input type="hidden" name="orderId" value="${o.orderId}" />
                                                            <input type="hidden" name="keyword" value="${keyword}" />
                                                            <input type="submit" value="Arrived" class="delete-btn" />
                                                        </form>
                                                    </div>

                                                </td>   
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                    </c:choose>
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
    </body>
</html>
