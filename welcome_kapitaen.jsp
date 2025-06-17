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

<!-- Mitarbeiterinformationen abrufen -->
<sql:query var="angestellterInfo" dataSource="${ds}">
    SELECT p.vorname, p.nachname, a.sv_nr
    FROM Angestellter a
    JOIN Person p ON a.sv_nr = p.sv_nr
    WHERE a.angestellten_nr = ?
    <sql:param value="${sessionScope.angestellten_nr}" />
</sql:query>

<!-- Wenn delete_id gesetzt ist, Passage löschen -->
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

<!-- Alle Passagen dieses Kapitäns abrufen -->
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

<html>
<head>
    <title>Willkommen Kapitän</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .container { width: 80%; margin: auto; overflow: hidden; }
        header { background: #333; color: #fff; padding-top: 30px; min-height: 70px; border-bottom: #77A6F7 3px solid; }
        header a { color: #fff; text-decoration: none; text-transform: uppercase; font-size: 16px; }
        header ul { padding: 0; list-style: none; }
        header li { float: left; display: inline; padding: 0 20px; }
        header #branding { float: left; }
        header #branding h1 { margin: 0; }
        header nav { float: right; margin-top: 10px; }
        form, table { background: #fff; padding: 20px; margin-top: 20px; border: #77A6F7 1px solid; border-radius: 5px; }
        form input[type="text"], form input[type="submit"] { display: block; width: 100%; padding: 10px; margin-bottom: 10px; }
        form input[type="submit"] { background: #333; color: #fff; border: 0; cursor: pointer; }
        form input[type="submit"]:hover { background: #555; }
        .message { padding: 10px; margin-top: 20px; border-radius: 5px; }
        .success { background: #c8e6c9; color: #2e7d32; border: #2e7d32 1px solid; }
        .error { background: #ffcdd2; color: #c62828; border: #c62828 1px solid; }
    </style>
</head>
<body>
<header>
    <div class="container">
        <h1>Willkommen Kapitän</h1>
        <p>Name:
            <strong>
                <c:out value="${angestellterInfo.rows[0].vorname}" />
                <c:out value=" " />
                <c:out value="${angestellterInfo.rows[0].nachname}" />
            </strong>
        </p>
        <p style="color: #fff;">Angemeldet als Mitarbeiter:
            <strong><c:out value="${sessionScope.angestellten_nr}" /></strong>
        </p>
        <nav>
            <ul>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </div>
</header>

<div class="container">
    <h2>Passage erstellen</h2>
    <form action="welcome_kapitaen.jsp" method="post">
        Passagennummer: <input type="text" name="passagennummer" required/>
        Abfahrtshafen: <input type="text" name="abfahrtshafen" required/>
        Zielhafen: <input type="text" name="zielhafen" required/>
        Abfahrtszeit (YYYY-MM-DD HH24:MI:SS): <input type="text" name="abfahrtszeit" required/>
        Ankunftszeit (YYYY-MM-DD HH24:MI:SS): <input type="text" name="ankunftszeit" required/>
        Schiffstyp-Nummer: <input type="text" name="typennummer" required/>
        <input type="submit" value="Passage speichern" />
    </form>

    <!-- Wenn alle Felder gesetzt sind: Passage einfügen -->
    <c:if test="${not empty param.passagennummer and not empty param.abfahrtshafen and not empty param.zielhafen and not empty param.abfahrtszeit and not empty param.ankunftszeit and not empty param.typennummer}">
        <sql:update dataSource="${ds}" var="updatePassage">
            INSERT INTO PASSAGE (PASSAGEN_NR, ABFAHRTSHAFEN, ZIELHAFEN, ABFAHRTSZEIT, ANKUNFTSZEIT)
            VALUES (?, ?, ?, TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS'))
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
                        <div class="message error">Fehler beim Einfügen in die Tabelle FAHREN.</div>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <div class="message error">Fehler beim Einfügen in die Tabelle PASSAGE.</div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <h2>Meine Passagen</h2>
    <table border="1" cellpadding="5" cellspacing="0" style="background: #fff; border-collapse: collapse; width: 100%;">
        <tr style="background: #333; color: #fff;">
            <th>Passagennr</th>
            <th>Abfahrtshafen</th>
            <th>Zielhafen</th>
            <th>Abfahrtszeit</th>
            <th>Ankunftszeit</th>
            <th>Schiffstyp</th>
            <th>Aktion</th>
        </tr>
        <c:forEach var="row" items="${kapitaenPassagen.rows}">
            <tr>
                <td><c:out value="${row.PASSAGEN_NR}" /></td>
                <td><c:out value="${row.ABFAHRTSHAFEN}" /></td>
                <td><c:out value="${row.ZIELHAFEN}" /></td>
                <td><c:out value="${row.ABFAHRTSZEIT}" /></td>
                <td><c:out value="${row.ANKUNFTSZEIT}" /></td>
                <td><c:out value="${row.TYPENNUMMER}" /></td>
                <td>
                    <form method="post" action="welcome_kapitaen.jsp" style="margin:0;">
                        <input type="hidden" name="delete_id" value="${row.PASSAGEN_NR}" />
                        <input type="submit" value="Löschen" onclick="return confirm('Wirklich löschen?');" />
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
