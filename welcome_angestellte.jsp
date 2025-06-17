<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Willkommen Mitarbeiter | Schifffahrtsgesellschaft</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #ffffff);
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background-color: #00695c;
        }
        .navbar-brand {
            color: #fff !important;
            font-weight: bold;
        }
        .welcome-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .card {
            background-color: #ffffffcc;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            padding: 2.5rem;
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        .card h2 {
            color: #004d40;
            margin-bottom: 1rem;
        }
        .card p {
            font-size: 1.2rem;
            color: #555;
        }
        .card h4 {
            color: #00796b;
            font-weight: bold;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Schifffahrtsgesellschaft der Gruppe 4</a>
        <div class="ml-auto">
            <a href="logout.jsp" class="btn btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="welcome-container">
    <div class="card">
        <h2>Willkommen, Mitarbeiter!</h2>
        <p class="lead">Ihre Angestelltennummer lautet:</p>
        <h4><c:out value="${sessionScope.angestellten_nr}" /></h4>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
