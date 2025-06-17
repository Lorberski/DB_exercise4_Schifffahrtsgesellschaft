<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Registrierung | Schifffahrtsgesellschaft</title>
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
        .register-container {
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
            max-width: 600px;
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

    <script>
        function validateForm() {
            const letterPattern = /^[a-zA-ZäöüÄÖÜß]+$/;
            const numberPattern = /^[0-9]+$/;
            const alphanumericPattern = /^[0-9A-Za-z]+$/;

            const fields = {
                svnr: { pattern: numberPattern, message: "SVNR darf nur Zahlen enthalten." },
                vorname: { pattern: letterPattern, message: "Vorname darf nur Buchstaben enthalten." },
                nachname: { pattern: letterPattern, message: "Nachname darf nur Buchstaben enthalten." },
                ort: { pattern: letterPattern, message: "Ort darf nur Buchstaben enthalten." },
                strasse: { pattern: letterPattern, message: "Straße darf nur Buchstaben enthalten." },
                postleitzahl: { pattern: numberPattern, message: "Postleitzahl darf nur Zahlen enthalten." },
                hausnummer: { pattern: alphanumericPattern, message: "Hausnummer darf nur Zahlen und Buchstaben enthalten." }
            };

            for (const [id, rule] of Object.entries(fields)) {
                const value = document.getElementById(id).value.trim();
                if (!rule.pattern.test(value)) {
                    alert(rule.message);
                    return false;
                }
            }

            return true;
        }
    </script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Schifffahrtsgesellschaft der Gruppe 4</a>
    </div>
</nav>

<div class="register-container">
    <div class="card">
        <h2 class="card-title">Registrierung</h2>
        <form action="validate_register_personen_und_passagier.jsp" method="post" onsubmit="return validateForm();">
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="svnr">SVNR</label>
                    <input type="text" class="form-control" id="svnr" name="svnr" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="hausnummer">Hausnummer</label>
                    <input type="text" class="form-control" id="hausnummer" name="hausnummer" required>
                </div>
            </div>
            <div class="form-group">
                <label for="vorname">Vorname</label>
                <input type="text" class="form-control" id="vorname" name="vorname" required>
            </div>
            <div class="form-group">
                <label for="nachname">Nachname</label>
                <input type="text" class="form-control" id="nachname" name="nachname" required>
            </div>
            <div class="form-group">
                <label for="ort">Ort</label>
                <input type="text" class="form-control" id="ort" name="ort" required>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label for="strasse">Straße</label>
                    <input type="text" class="form-control" id="strasse" name="strasse" required>
                </div>
                <div class="form-group col-md-4">
                    <label for="postleitzahl">PLZ</label>
                    <input type="text" class="form-control" id="postleitzahl" name="postleitzahl" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Registrieren</button>
        </form>

        <c:if test="${param.error != null}">
            <p class="text-danger text-center">Registrierung fehlgeschlagen. Bitte erneut versuchen.</p>
        </c:if>
    </div>
</div>

<!-- Erfolgreiche Registrierung &#8594; Weiterleitung -->
<c:if test="${not empty param.successPassagiernummer}">
    <script>
        alert("Ihre Passagiernummer lautet: ${param.successPassagiernummer}");
        window.location.href = 'login_passagiere.jsp';
    </script>
</c:if>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
