<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Mitarbeiter Login | Schifffahrtsgesellschaft</title>
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
        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            padding: 2rem;
            width: 100%;
            max-width: 400px;
            background-color: #ffffffcc;
        }
        .card-title {
            text-align: center;
            color: #004d40;
            margin-bottom: 1.5rem;
        }
        .btn-primary {
            background-color: #00796b;
            border: none;
        }
        .btn-primary:hover {
            background-color: #004d40;
        }
        .text-danger {
            margin-top: 1rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Schifffahrtsgesellschaft der Gruppe 4</a>
    </div>
</nav>

<div class="login-container">
    <div class="card">
        <h2 class="card-title">Login als Mitarbeiter</h2>
        <form action="validate_login_mitarbeiter.jsp" method="post">
            <div class="form-group">
                <label for="angestellten_nr">Angestelltennummer</label>
                <input type="text" class="form-control" name="angestellten_nr" id="angestellten_nr" required>
            </div>
            <div class="form-group">
                <label for="sv_nr">SVNR</label>
                <input type="password" class="form-control" name="sv_nr" id="sv_nr" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Login</button>
        </form>
        <c:if test="${param.error != null}">
            <p class="text-danger text-center">Ungültige Kombination aus Angestelltennummer und SVNR. Bitte versuchen Sie es erneut.</p>
        </c:if>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
