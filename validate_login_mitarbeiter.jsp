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

<!-- 1. Prüfen, ob der Angestellte existiert -->
<sql:query dataSource="${ds}" var="angestellterResult">
    SELECT * FROM ANGESTELLTER
    WHERE SV_NR = ? AND ANGESTELLTEN_NR = ?
    <sql:param value="${param.sv_nr}" />
    <sql:param value="${param.angestellten_nr}" />
</sql:query>

<c:choose>
    <c:when test="${not empty angestellterResult.rows}">
        <!-- Speichern in Session -->
        <c:set var="angestellten_nr" value="${param.angestellten_nr}" scope="session" />
        <c:set var="sv_nr" value="${param.sv_nr}" scope="session" />

        <!-- 2. Prüfen, ob der SV_NR auch Kapitän ist -->
        <sql:query dataSource="${ds}" var="kapitaenResult">
            SELECT * FROM KAPITAEN WHERE SV_NR = ?
            <sql:param value="${param.sv_nr}" />
        </sql:query>

        <c:choose>
            <c:when test="${not empty kapitaenResult.rows}">
                <!-- SV_NR ist Kapitän -->
                <c:redirect url="welcome_kapitaen.jsp" />
            </c:when>
            <c:otherwise>
                <!-- SV_NR ist Angestellter, aber kein Kapitän -->
                <c:redirect url="welcome_angestellte.jsp" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <!-- Kein Angestellter mit dieser SV_NR und ANGESTELLTEN_NR -->
        <c:redirect url="login_mitarbeiter.jsp?error=true" />
    </c:otherwise>
</c:choose>
