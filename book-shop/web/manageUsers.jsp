<%-- 
    Document   : manageUsers
    Created on : Jul 12, 2025, 2:00:24 PM
    Author     : trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />
<c:set var="keyword" value="${requestScope.keyword}" />

<c:set var="userList" value="${requestScope.list}" />
<c:set var="hasKeyword" value="${not empty keyword}" />
<c:set var="hasUsers" value="${not empty userList}" />
<c:set var="usersCount" value="${fn:length(userList)}" />
<c:set var="keywordParam" value="${hasKeyword ? keyword : ''}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${isLoggedIn and isAdmin}">
                <div class="content-header">
                    <h1 class="page-title">Manage Users</h1>
                    <div class="header-controls">
                        <div class="search-container">
                            <form data-controller="UserController" method="post"
                                  data-success-action="viewUsers" style="display: flex; align-items: center; gap: 10px;">
                                <input type="hidden" name="action" value="searchUsers"/>
                                <input type="text" name="keyword" value="${keyword}" 
                                       placeholder="Search user name" class="search-input"/>
                                <button type="submit" class="search-btn"></button>
                            </form>

                        </div>
                    </div>
                </div>


                <div class="main-content">
                    <c:choose>
                        <c:when test="${hasUsers and usersCount == 0}">
                            <div>
                                No users have names that match the keyword!
                            </div>
                        </c:when>
                        <c:when test="${hasUsers and usersCount > 0}">
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>UserName</th>
                                            <th>Full Name</th>
                                            <th>Role</th>
                                            <th>Email</th>
                                            <th>Birthday</th>
                                            <th>Address</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Action</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="u" items="${userList}">
                                            <tr>
                                                <td>${u.userID}</td>                                      
                                                <td>${u.userName}</td>
                                                <td>${u.fullName}</td>
                                                <td>${u.roleID}</td>
                                                <td>${u.email}</td>
                                                <td>Noooo</td>
                                                <td>${u.address}</td>
                                                <td>${u.phone}</td>
                                                <td class="${u.status ? 'status-active' : 'status-inactive'}">
                                                    ${u.status ? 'Active' : 'Inactive'}
                                                </td>

                                                <td>
                                                    <div class="action-buttons">


                                                        <!-- Form Delete -->
                                                        <form data-controller="UserController" method="post"
                                                              onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                            <input type="hidden" name="action" value="changeUserStatus" />
                                                            <input type="hidden" name="userID" value="${u.userID}" />
                                                            <input type="hidden" name="keyword" value="${keyword}" />
                                                            <input type="submit" value="Delete" class="delete-btn" />
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
