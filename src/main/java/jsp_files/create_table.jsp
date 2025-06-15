<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Datenquelle definieren -->
<sql:setDataSource
    driver="oracle.jdbc.driver.OracleDriver"
    url="jdbc:oracle:thin:@localhost:1521/xepdb1"
    user="csdc26vz_04"
    password="noo2toh5Ot"
    var="ds"
/>

<!-- Tabelle PERSON erstellen -->
<sql:update dataSource="${ds}">
    CREATE TABLE Person (
        SVNR VARCHAR2(11) PRIMARY KEY,
        Vorname VARCHAR2(50) NOT NULL,
        Nachname VARCHAR2(50) NOT NULL,
        Ort VARCHAR2(100),
        Strasse VARCHAR2(100),
        Postleitzahl VARCHAR2(10),
        Hausnummer VARCHAR2(10)
    )
</sql:update>


<p>CREATE TABLE successful!</p>