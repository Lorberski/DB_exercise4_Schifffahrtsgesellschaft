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

<sql:query dataSource="${ds}" var="tableList">
    SELECT table_name FROM user_tables ORDER BY table_name
</sql:query>

<h2>Vorhandene Tabellen:</h2>
<ul>
    <c:forEach var="row" items="${tableList.rows}">
        <li>${row.table_name}</li>
    </c:forEach>
</ul>
