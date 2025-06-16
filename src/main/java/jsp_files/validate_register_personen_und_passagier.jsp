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

<!-- Einfügen in die Tabelle PERSON -->
<sql:update dataSource="${ds}" var="updateCount">
    INSERT INTO Person (SV_Nr, Vorname, Nachname, Ort, Strasse, Postleitzahl, Hausnummer)
    VALUES (?, ?, ?, ?, ?, ?, ?)
    <sql:param value="${param.svnr}" />
    <sql:param value="${param.vorname}" />
    <sql:param value="${param.nachname}" />
    <sql:param value="${param.ort}" />
    <sql:param value="${param.strasse}" />
    <sql:param value="${param.postleitzahl}" />
    <sql:param value="${param.hausnummer}" />
</sql:update>

<c:choose>
    <c:when test="${updateCount >= 1}">
        <!-- Aktuelle höchste Passagiernummer holen -->
        <sql:query dataSource="${ds}" var="maxPassagiernummerQuery">
            SELECT MAX(PASSAGIER_NR) AS maxPassagiernummer FROM PASSAGIER
        </sql:query>

        <!-- Sicherer nächster Wert berechnen -->
        <c:choose>
            <c:when test="${empty maxPassagiernummerQuery.rows[0].maxPassagiernummer}">
                <c:set var="nextPassagiernummer" value="1" />
            </c:when>
            <c:otherwise>
                <c:set var="nextPassagiernummer" value="${maxPassagiernummerQuery.rows[0].maxPassagiernummer + 1}" />
            </c:otherwise>
        </c:choose>

        <!-- In PASSAGIER einfügen -->
        <sql:update dataSource="${ds}" var="updatePassagier">
            INSERT INTO PASSAGIER (SV_Nr, PASSAGIER_NR)
            VALUES (?, ?)
            <sql:param value="${param.svnr}" />
            <sql:param value="${nextPassagiernummer}" />
        </sql:update>

        <c:choose>
            <c:when test="${updatePassagier >= 1}">
                <c:redirect url="register_personen_und_passagiere.jsp">
                    <c:param name="successPassagiernummer" value="${nextPassagiernummer}" />
                </c:redirect>
            </c:when>
            <c:otherwise>
                <p>Fehler beim Einfügen in die Passagier-Tabelle. Bitte kontaktieren Sie den Administrator.</p>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <p>Fehler beim Einfügen in die Person-Tabelle. Bitte erneut versuchen oder den Administrator kontaktieren.</p>
    </c:otherwise>
</c:choose>
