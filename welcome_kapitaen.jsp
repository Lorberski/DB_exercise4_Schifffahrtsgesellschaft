<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521/xepdb1"
        user="csdc26vz_04"
        password="noo2toh5Ot"
        var="ds"
/>

<sql:query var="angestellterInfo" dataSource="${ds}">
    SELECT p.vorname, p.nachname, a.sv_nr
    FROM Angestellter a
    JOIN Person p ON a.sv_nr = p.sv_nr
    WHERE a.angestellten_nr = ?
    <sql:param value="${sessionScope.angestellten_nr}" />
</sql:query>

<c:if test="${not empty param.delete_id}">
    <sql:update dataSource="${ds}" var="delFahren">
        DELETE FROM FAHREN WHERE PASSAGEN_NR = ?
        <sql:param value="${param.delete_id}" />
    </sql:update>
    <sql:update dataSource="${ds}" var="delPassage">
        DELETE FROM PASSAGE WHERE PASSAGEN_NR = ?
        <sql:param value="${param.delete_id}" />
    </sql:update>
    <c:redirect url="welcome_kapitaen.jsp" />
</c:if>

<sql:query dataSource="${ds}" var="kapitaenPassagen">
    SELECT pa.PASSAGEN_NR, pa.ABFAHRTSHAFEN, pa.ZIELHAFEN,
    TO_CHAR(pa.ABFAHRTSZEIT, 'YYYY-MM-DD HH24:MI:SS') AS ABFAHRTSZEIT,
    TO_CHAR(pa.ANKUNFTSZEIT, 'YYYY-MM-DD HH24:MI:SS') AS ANKUNFTSZEIT,
    f.TYPENNUMMER
    FROM PASSAGE pa
    JOIN FAHREN f ON pa.PASSAGEN_NR = f.PASSAGEN_NR
    WHERE f.SV_NR = ?
    <sql:param value="${angestellterInfo.rows[0].sv_nr}" />
</sql:query>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Willkommen Kapitän | Schifffahrtsgesellschaft</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #ffffff);
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background-color: #00695c;
        }
        .navbar-brand, .navbar-text {
            color: #fff !important;
            font-weight: bold;
        }
        .container {
            margin-top: 2rem;
            margin-bottom: 3rem;
        }
        .form-section, .table-section {
            background-color: #ffffffcc;
            border-radius: 1rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .btn-primary {
            background-color: #00796b;
            border: none;
        }
        .btn-primary:hover {
            background-color: #004d40;
        }
        .btn-danger {
            background-color: #c62828;
            border: none;
        }
        .btn-danger:hover {
            background-color: #8e0000;
        }
        .message {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 0.5rem;
        }
        .success {
            background: #c8e6c9;
            color: #2e7d32;
        }
        .error {
            background: #ffcdd2;
            color: #c62828;
        }
        thead.custom-header {
            background-color: #00695c;
            color: #fff;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Schifffahrtsgesellschaft der Gruppe 4</a>
        <div class="ml-auto">
            <span class="navbar-text mr-3">
                ${angestellterInfo.rows[0].vorname} ${angestellterInfo.rows[0].nachname} &ndash;
                Nr: ${sessionScope.angestellten_nr}
            </span>
            <a href="logout.jsp" class="btn btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <!-- Passage erstellen -->
    <div class="form-section">
        <h3>Neue Passage erstellen</h3>
        <form action="welcome_kapitaen.jsp" method="post">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label>Passagennummer</label>
                    <input type="text" name="passagennummer" class="form-control" required />
                </div>
                <div class="form-group col-md-4">
                    <label>Abfahrtshafen</label>
                    <input type="text" name="abfahrtshafen" class="form-control" required />
                </div>
                <div class="form-group col-md-4">
                    <label>Zielhafen</label>
                    <input type="text" name="zielhafen" class="form-control" required />
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label>Abfahrtszeit</label>
                    <input type="datetime-local" name="abfahrtszeit" class="form-control" required />
                </div>
                <div class="form-group col-md-6">
                    <label>Ankunftszeit</label>
                    <input type="datetime-local" name="ankunftszeit" class="form-control" required />
                </div>
            </div>
            <div class="form-group">
                <label>Schiffstyp-Nummer</label>
                <input type="text" name="typennummer" class="form-control" required />
            </div>
            <button type="submit" class="btn btn-primary">Passage speichern</button>
        </form>

        <!-- Insert SQL -->
        <c:if test="${not empty param.passagennummer and not empty param.abfahrtshafen and not empty param.zielhafen and not empty param.abfahrtszeit and not empty param.ankunftszeit and not empty param.typennummer}">
            <sql:update dataSource="${ds}" var="updatePassage">
                INSERT INTO PASSAGE (PASSAGEN_NR, ABFAHRTSHAFEN, ZIELHAFEN, ABFAHRTSZEIT, ANKUNFTSZEIT)
                VALUES (?, ?, ?, TO_DATE(REPLACE(?, 'T', ' '), 'YYYY-MM-DD HH24:MI:SS'),
                TO_DATE(REPLACE(?, 'T', ' '), 'YYYY-MM-DD HH24:MI:SS'))
                <sql:param value="${param.passagennummer}" />
                <sql:param value="${param.abfahrtshafen}" />
                <sql:param value="${param.zielhafen}" />
                <sql:param value="${param.abfahrtszeit}" />
                <sql:param value="${param.ankunftszeit}" />
            </sql:update>

            <c:choose>
                <c:when test="${updatePassage >= 1}">
                    <sql:update dataSource="${ds}" var="updateFahren">
                        INSERT INTO FAHREN (SV_NR, PASSAGEN_NR, TYPENNUMMER)
                        VALUES (?, ?, ?)
                        <sql:param value="${angestellterInfo.rows[0].sv_nr}" />
                        <sql:param value="${param.passagennummer}" />
                        <sql:param value="${param.typennummer}" />
                    </sql:update>

                    <c:choose>
                        <c:when test="${updateFahren >= 1}">
                            <c:redirect url="welcome_kapitaen.jsp" />
                        </c:when>
                        <c:otherwise>
                            <div class="message error">Fehler beim Einfügen in FAHREN.</div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="message error">Fehler beim Einfügen in PASSAGE.</div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>

    <!-- Passage-Tabelle -->
    <div class="table-section">
        <h3>Meine Passagen</h3>
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="custom-header">
                <tr>
                    <th>Passagennr</th>
                    <th>Abfahrtshafen</th>
                    <th>Zielhafen</th>
                    <th>Abfahrtszeit</th>
                    <th>Ankunftszeit</th>
                    <th>Schiffstyp</th>
                    <th>Aktion</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="row" items="${kapitaenPassagen.rows}">
                    <tr>
                        <td><c:out value="${row.PASSAGEN_NR}" /></td>
                        <td><c:out value="${row.ABFAHRTSHAFEN}" /></td>
                        <td><c:out value="${row.ZIELHAFEN}" /></td>
                        <td><c:out value="${row.ABFAHRTSZEIT}" /></td>
                        <td><c:out value="${row.ANKUNFTSZEIT}" /></td>
                        <td><c:out value="${row.TYPENNUMMER}" /></td>
                        <td>
                            <form method="post" action="welcome_kapitaen.jsp" onsubmit="return confirm('Wirklich löschen?');">
                                <input type="hidden" name="delete_id" value="${row.PASSAGEN_NR}" />
                                <button type="submit" class="btn btn-sm btn-danger">Löschen</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
