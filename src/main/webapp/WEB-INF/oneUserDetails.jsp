<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date" %>
    <!-- Here we have to import the Date class. -->
    <!-- You will put the import in the first line of the jsp tag. Use the import attribute -->

    <!-- c:out ; c:forEach ; c:if -->
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!-- Formatting (like dates) -->
        <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!-- form:form -->
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!-- for rendering errors on PUT routes -->
                <%@ page isErrorPage="true" %>

                    <!DOCTYPE html>

                    <html>

                    <head>
                        <meta charset="UTF-8" />
                        <title>Craig Burke - Plant Keeper - User Details</title>
                        <!-- Bootstrap -->
                        <!-- CSS only -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
                            rel="stylesheet"
                            integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
                            crossorigin="anonymous" />
                        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
                            integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
                            crossorigin="anonymous"></script>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
                            integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
                            crossorigin="anonymous"></script>
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
                        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
                        <link rel="stylesheet" type="text/css" href="/css/style.css">
                    </head>

                    <body>

                        <!--  Nav START -->
                        <nav class="navbar navbar-expand-xl navbar-light bg-light">
                            <div class="container">

                                <!-- Landing button -->
                                <a class="navbar-brand" href="/">Plant Keeper</a>

                                <!-- Toggler for mobile/small screen -->
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#navbarWithDropdown" aria-controls="navbarWithDropdown"
                                    aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>

                                <!-- Collapsable nav bar -->
                                <div class="collapse navbar-collapse show" id="navbarWithDropdown">
                                    <ul class="navbar-nav">

                                        <!-- Home/Index button -->
                                        <!-- <li class="nav-item">
                                            <a class="nav-link active" aria-current="page" href="/home">Home</a>
                                        </li> -->

                                        <!-- Login/Registration button -->
                                        <!-- <li class="nav-item">
                                            <a class="nav-link" href="/login">Login</a>
                                        </li> -->

                                        <!-- Dashboard button -->
                                        <li class="nav-item">
                                            <a class="nav-link" href="/dashboard">Dashboard</a>
                                        </li>

                                        <!-- Dropdown buttons -->
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                == Select ==
                                            </a>
                                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                                <li><a class="dropdown-item" href="/login">Login</a></li>
                                                <li><a class="dropdown-item" href="/createNewPlant">Create Plant</a>
                                                </li>
                                                <li><a class="dropdown-item" href="/logout">Logout</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <!-- <div class="container float-end">
                                        <form class="d-flex float-end">
                                            <input class="form-control me-2" type="search" placeholder="Search"
                                                aria-label="Search">
                                            <button class="btn btn-outline-success" type="submit">Search</button>
                                        </form>
                                    </div> -->
                                </div>
                            </div>
                        </nav>
                        <!--  Nav END -->

                        <!-- Main container START -->
                        <div class="container text-center">

                            <!-- Page Title / start button START -->
                            <div>
                                <h1 class="bg-dark text-light ps-5">Welcome to Plant Keeper</h1>
                                <!-- <a class="btn btn-primary mt-4" href="/">Start Doing Something!</a> -->
                            </div>
                            <!-- Page Title END -->

                            <p class="w-100"></p>

                            <!-- show user name on page START -->
                            <div>
                                <h1 class="bg-primary text-light ps-5">Welcome <span
                                        class="text-primary ">${LoggedUser.firstName}</span>, to the Plant Keeper User
                                    Details
                                    Page</h1>
                            </div>
                            <!-- show user name on page END -->

                            <p class="w-100"></p>


                            <!-- Show All Plants -->

                            <!-- Show All BaseProject START -->
                            <!-- SCROLLING Table FROM BOOTSTRAP -->
                            <div>
                                <div>
                                    <h1 class="bg-primary text-success ps-5">These Plants are owned by:
                                        ${user.firstName} ${user.lastName}</h1>
                                </div>
                                <p class="w-100"></p>
                                <nav id="navbar-scrollspy" class="navbar navbar-light bg-light px-1">
                                    <table class="table table-striped p-2 border border-2">
                                        <thead>
                                            <tr>
                                                <!-- Table Headers -->
                                                <th scope="col" class="h4">Plant Name</th>
                                                <th scope="col" class="h4">Water Schedule</th>
                                                <th scope="col" class="h4">Description</th>
                                                <th scope="col" class="h4">Actions</th>

                                            </tr>
                                        </thead>
                                    </table>
                                </nav>
                                <div data-bs-spy=" scroll" data-bs-target="#navbar-scrollspy" data-bs-offset="0"
                                    tabindex="0" class="scrollspy-example">
                                    <table class="table table-striped p-2 border border-2">
                                        <tbody>
                                            <!-- Loop through items and display each of them -->
                                            <c:forEach var="plant" items="${user.plants}">
                                                <tr>
                                                    <td scope="row">
                                                        <!-- A link over one of the items attribute -->
                                                        <a href="/onePlantDetails/${plant.id}">
                                                            <c:out value="${plant.plantName}"></c:out>
                                                        </a>
                                                    </td>
                                                    <td scope="row">
                                                        <p class="text-center">
                                                            <c:out value="${plant.waterSchedule}"></c:out>
                                                        </p>
                                                    </td>
                                                    <td scope="row">
                                                        <p class="text-center">
                                                            <c:out value="${plant.description}"></c:out>
                                                        </p>
                                                    </td>
                                                    <td scope="row">
                                                        <p class="text-center">
                                                            <!-- Action links -->
                                                            <a href="/onePlantDetails/${plant.id}">view</a>

                                                            <c:choose>
                                                                <c:when test="${plant.user.id == LoggedUser.id}">
                                                                    <!-- <span> | </span>
                                                                    <a href="/updatePlant/${plant.id}">edit</a>
                                                                    <span> | </span>
                                                                    <a href="/deletePlant/${plant.id}">delete</a> -->
                                                                    <span> | </span>
                                                                    <a href="/updatePlant/${plant.id}">edit</a>
                                                                    <span> | </span>
                                                                    <a href="/deletePlant/${plant.id}">delete</a>
                                                                </c:when>
                                                                <c:otherwise>

                                                                </c:otherwise>

                                                            </c:choose>



                                                        </p>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- end of scrolling table -->
                            <!-- Show All BaseProject END -->



                            <p class="w-100"></p>

                            <!-- Main container END -->
                        </div>

                        <script src="/js/app.js"></script>
                    </body>

                    </html>