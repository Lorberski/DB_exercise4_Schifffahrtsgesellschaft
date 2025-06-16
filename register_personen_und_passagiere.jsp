<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Schiffahrtsgesellschaft</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            var letterPattern = /^[a-zA-Z]+$/;
            var numberPattern = /^[0-9]+$/;
            var alphanumericPattern = /^[0-9A-Za-z]+$/;

            var svnr = document.getElementById('svnr').value;
            var vorname = document.getElementById('vorname').value;
            var nachname = document.getElementById('nachname').value;
            var ort = document.getElementById('ort').value;
            var strasse = document.getElementById('strasse').value;
            var postleitzahl = document.getElementById('postleitzahl').value;
            var hausnummer = document.getElementById('hausnummer').value;

            if (!numberPattern.test(svnr)) {
                alert("SVNR must contain only numbers.");
                return false;
            }
            if (!letterPattern.test(vorname)) {
                alert("First Name must contain only letters.");
                return false;
            }
            if (!letterPattern.test(nachname)) {
                alert("Last Name must contain only letters.");
                return false;
            }
            if (!letterPattern.test(ort)) {
                alert("City must contain only letters.");
                return false;
            }
            if (!letterPattern.test(strasse)) {
                alert("Street must contain only letters.");
                return false;
            }
            if (!numberPattern.test(postleitzahl)) {
                alert("Postal Code must contain only numbers.");
                return false;
            }
            if (!alphanumericPattern.test(hausnummer)) {
                alert("House Number must contain numbers or letters.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center">Register</h2>
            <form action="validate_register_personen_und_passagier.jsp" method="post" onsubmit="return validateForm();">
                <div class="form-group">
                    <label for="svnr">SVNR</label>
                    <input type="text" class="form-control" id="svnr" name="svnr" required pattern="\d+" title="SVNR must contain only numbers.">
                </div>
                <div class="form-group">
                    <label for="vorname">First Name</label>
                    <input type="text" class="form-control" id="vorname" name="vorname" required pattern="[A-Za-z]+" title="First Name must contain only letters.">
                </div>
                <div class="form-group">
                    <label for="nachname">Last Name</label>
                    <input type="text" class="form-control" id="nachname" name="nachname" required pattern="[A-Za-z]+" title="Last Name must contain only letters.">
                </div>
                <div class="form-group">
                    <label for="ort">City</label>
                    <input type="text" class="form-control" id="ort" name="ort" required pattern="[A-Za-z]+" title="City must contain only letters.">
                </div>
                <div class="form-group">
                    <label for="strasse">Street</label>
                    <input type="text" class="form-control" id="strasse" name="strasse" required pattern="[A-Za-z]+" title="Street must contain only letters.">
                </div>
                <div class="form-group">
                    <label for="postleitzahl">Postal Code</label>
                    <input type="text" class="form-control" id="postleitzahl" name="postleitzahl" required pattern="\d+" title="Postal Code must contain only numbers.">
                </div>
                <div class="form-group">
                    <label for="hausnummer">House Number</label>
                    <input type="text" class="form-control" id="hausnummer" name="hausnummer" required pattern="[0-9A-Za-z]+" title="House Number must contain numbers or letters.">
                </div>
                <button type="submit" class="btn btn-primary btn-block">Register</button>
            </form>
            <c:if test="${param.error != null}">
                <p class="text-danger text-center">Registration failed. Please try again.</p>
            </c:if>
        </div>
    </div>
</div>

<c:if test="${not empty param.successPassagiernummer}">
    <script>
        alert("Your Passagiernummer is: ${param.successPassagiernummer}");
        window.location.href = 'login_passagiere.jsp';
    </script>
</c:if>
</body>
</html>
