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

<!-- Beispiel-Daten in Person einfügen -->
<sql:update dataSource="${ds}">
    INSERT INTO Person (SV_Nummer, Vorname, Nachname, Ort, Strasse, Postleitzahl, Hausnummer)
    VALUES ('12345678901', 'Max', 'Mustermann', 'Berlin', 'Musterstraße', '10115', '12A')
</sql:update>

<sql:update dataSource="${ds}">
    INSERT INTO Person (SV_Nummer, Vorname, Nachname, Ort, Strasse, Postleitzahl, Hausnummer)
    VALUES ('23456789012', 'Anna', 'Müller', 'München', 'Bahnhofstraße', '80331', '7')
</sql:update>

<sql:update dataSource="${ds}">
    INSERT INTO Person (SV_Nummer, Vorname, Nachname, Ort, Strasse, Postleitzahl, Hausnummer)
    VALUES ('34567890123', 'Peter', 'Schmidt', 'Hamburg', 'Hauptstraße', '20095', '10')
</sql:update>


<p>FILL TABLE successful!</p>
