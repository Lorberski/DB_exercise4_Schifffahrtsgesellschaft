<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Debug-Ausgabe --%>
<p>passagier_nr: ${param.passagier_nr}</p>
<p>sv_nr: ${param.sv_nr}</p>

<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521/xepdb1"
        user="csdc26vz_04"
        password="noo2toh5Ot"
        var="ds"
/>

<sql:query dataSource="${ds}" var="result">
    SELECT * FROM Passagier WHERE PASSAGIER_NR = ? AND SV_NR = ?
    <sql:param value="${param.passagier_nr}" />
    <sql:param value="${param.sv_nr}" />
</sql:query>

<c:choose>
    <c:when test="${not empty result.rows}">
        <%-- Session setzen (Java-Code, falls nötig) --%>
        <%
            String passagierNr = request.getParameter("passagier_nr");
            session.setAttribute("passagiernummer", passagierNr);
        %>
        <c:redirect url="welcome_passagier.jsp" />
    </c:when>
    <c:otherwise>
        <c:redirect url="login_passagiere.jsp?error=true" />
    </c:otherwise>
</c:choose>
