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


<sql:update dataSource="${ds}">
    BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Kapitaen';
    EXCEPTION
    WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
    RAISE;
    END IF;
    END;
</sql:update>

<sql:update dataSource="${ds}">
    BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Angestellter';
    EXCEPTION
    WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
    RAISE;
    END IF;
    END;
</sql:update>

<sql:update dataSource="${ds}">
    BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Telefonnummer';
    EXCEPTION
    WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
    RAISE;
    END IF;
    END;
</sql:update>

<sql:update dataSource="${ds}">
    BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Passagier';
    EXCEPTION
    WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
    RAISE;
    END IF;
    END;
</sql:update>

<sql:update dataSource="${ds}">
    BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Person';
    EXCEPTION
    WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
    RAISE;
    END IF;
    END;
</sql:update>

<sql:update dataSource="${ds}">
    BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Bank';
    EXCEPTION
    WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
    RAISE;
    END IF;
    END;
</sql:update>

<p>DROP TABLE successful!</p>
