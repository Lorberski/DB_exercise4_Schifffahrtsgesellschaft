<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Willkommen Passagier</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        header {
            background: #333;
            color: #fff;
            padding-top: 30px;
            min-height: 70px;
            border-bottom: #77A6F7 3px solid;
        }
        header a {
            color: #fff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
        }
        header ul {
            padding: 0;
            list-style: none;
            margin: 0;
        }
        header li {
            float: left;
            display: inline;
            padding: 0 20px;
        }
        header #branding {
            float: left;
        }
        header #branding h1 {
            margin: 0;
        }
        header nav {
            float: right;
            margin-top: 10px;
        }
        .welcome-card {
            margin-top: 100px;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .welcome-card h2 {
            font-size: 2rem;
        }
    </style>
</head>
<body>
<header>
    <div class="container clearfix">
        <div id="branding">
            <h1>Willkommen Passagier</h1>
        </div>
        <nav>
            <ul>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </div>
</header>

<div class="container d-flex justify-content-center">
    <div class="welcome-card bg-white text-center col-md-6">
        <h2 class="mb-4">Willkommen, Passagier!</h2>
        <p class="lead">Ihre Passagiernummer ist:</p>
        <h4><c:out value="${sessionScope.passagiernummer}" /></h4>
    </div>
</div>
</body>
</html>
