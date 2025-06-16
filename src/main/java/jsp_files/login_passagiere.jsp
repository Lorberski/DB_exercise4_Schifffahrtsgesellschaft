<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Mitarbeiter - Schiffahrtsgesellschaft</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <h2 class="text-center">Login als Mitarbeiter</h2>
            <form action="validate_login_mitarbeiter.jsp" method="post">
                <div class="form-group">
                    <label for="nachname">ANGESTELLTEN_NR</label>
                    <input type="text" name="angestellten_nr" id="angestellten_nr" required>
                </div>
                <div class="form-group">
                    <label for="svnr">SVNR</label>
                    <input type="password" name="sv_nr" id="sv_nr" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Login</button>
            </form>
            <c:if test="${param.error != null}">
                <p class="text-danger text-center">Invalid Last Name or SVNR. Please try again.</p>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>