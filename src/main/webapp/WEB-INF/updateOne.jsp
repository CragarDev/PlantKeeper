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
                        <title>Craig Burke - Plant Keeper - Update Plant</title>
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
                                                <li><a class="dropdown-item" href="/onePlantDetails">Show Details</a>
                                                </li>
                                                <!-- <li><a class="dropdown-item" href="/dashboard">ShowMany</a></li>
                                                <li><a class="dropdown-item" href="/createOne">CreateOne</a></li>
                                                <li><a class="dropdown-item" href="/updateOne">UpdateOne</a></li> -->
                                                <li><a class="dropdown-item" href="/deletePlant">DeleteOne</a></li>
                                                <li><a class="dropdown-item" href="/login">Login</a></li>
                                                <li><a class="dropdown-item" href="/createNewPlant">Create Plant</a>
                                                </li>
                                                <li><a class="dropdown-item" href="/logout">Logout</a></li>

                                            </ul>
                                        </li>
                                    </ul>
                                    <div class="container float-end">
                                        <form class="d-flex float-end">
                                            <input class="form-control me-2" type="search" placeholder="Search"
                                                aria-label="Search">
                                            <button class="btn btn-outline-success" type="submit">Search</button>
                                        </form>
                                    </div>
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
                                        class="text-primary ">${user.userName}</span>, to the Plant Keeper Update Plant
                                    Page</h1>
                            </div>
                            <!-- show user name on page END -->

                            <p class="w-100"></p>

                            <!-- BaseProject Create New Form START -->
                            <div
                                class="container bg-secondary text-light rounded-3 w-50 mt-5 border border-info border-5 pb-5 p-3">
                                <form:form action="/updatePlant/${plant.id}" method="post" modelAttribute="plant">
                                    <!-- the next line is for updating -->
                                    <input type="hidden" name="_method" value="put" />

                                    <!-- for attaching the owner to the plant -->
                                    <form:input type="hidden" path="user" class="float-start" value="${user.id}" />

                                    <div class="mb-3">
                                        <p>
                                            <form:label path="plantName" class="float-start">Plant Name</form:label>
                                            <form:errors path="plantName" class="text-danger h5" />
                                            <form:input path="plantName" class="form-control text-dark"
                                                placeholder="plantName" />
                                        </p>
                                    </div>




                                    <div class="mb-3 mt-3">
                                        <p>
                                            <form:label path="waterSchedule" class="float-start me-2">Water Schedule:
                                            </form:label>
                                            <form:errors path="waterSchedule" class="text-danger h5" />
                                            <form:select path="waterSchedule" class="float-start">
                                                <form:option value="Once a week" aria-selected="true">Once a week
                                                </form:option>
                                                <form:option value="Twice a week">Twice a week</form:option>
                                                <form:option value="Three times a week">Three times a week</form:option>
                                                <form:option value="Every Day">Every Day</form:option>
                                                <form:option value="Saturdays">Saturdays</form:option>
                                                <form:option value="Once a Month">Once a Month</form:option>
                                                <form:option value="Every other Thursday">Every other Thursday
                                                </form:option>
                                                <form:option value="Whenever">Whenever</form:option>
                                            </form:select>
                                        </p>
                                    </div>
                                    <br>

                                    <div class="mb-3 mt-3">
                                        <p>
                                            <form:label path="description" class="float-start">Description
                                            </form:label>
                                            <form:errors path="description" class="text-danger h5" />
                                            <form:textarea path="description" class="form-control" cols="30" rows="5"
                                                placeholder="description" />
                                        </p>
                                    </div>


                                    <p class="w-100"></p>

                                    <input type="submit" value="Update Plant" class="btn btn-warning float-start" />
                                    <!-- == Cancel button == -->
                                    <p class="w-100"></p>
                                    <a class="btn btn-info float-end mb-3" href="/dashboard">Cancel</a>
                                    <p class="w-100"></p>

                                </form:form>

                            </div>

                            <!-- BaseProject Create New Form END -->



                            <p class="w-100"></p>

                            <!-- Main container END -->
                        </div>

                        <script src="/js/app.js"></script>
                    </body>

                    </html>