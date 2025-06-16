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
    INSERT INTO Person (SV_Nr, Vorname, Nachname, Ort, Strasse, Postleitzahl, Hausnummer)
    VALUES ('12345678901', 'Max', 'Mustermann', 'Berlin', 'Musterstraße', '10115', '12A')
</sql:update>

<sql:update dataSource="${ds}">
    INSERT INTO Person (SV_Nr, Vorname, Nachname, Ort, Strasse, Postleitzahl, Hausnummer)
    VALUES ('23456789012', 'Anna', 'Müller', 'München', 'Bahnhofstraße', '80331', '7')
</sql:update>

<sql:update dataSource="${ds}">
    INSERT INTO Person (SV_Nr, Vorname, Nachname, Ort, Strasse, Postleitzahl, Hausnummer)
    VALUES ('34567890123', 'Peter', 'Schmidt', 'Hamburg', 'Hauptstraße', '20095', '10')
</sql:update>

<!-- Beispiel-Daten in Bank einfügen -->
<sql:update dataSource="${ds}">
    INSERT INTO Bank (Bankleitzahl, Bankname)
    VALUES (10020030, 'Deutsche Bank')
</sql:update>

<sql:update dataSource="${ds}">
    INSERT INTO Bank (Bankleitzahl, Bankname)
    VALUES (20030040, 'Commerzbank')
</sql:update>

<!-- Beispiel-Daten in Angestellter einfügen -->
<sql:update dataSource="${ds}">
    INSERT INTO Angestellter (SV_Nr, Angestellten_Nr, Konto_Nr, Bankleitzahl, Kontostand)
    VALUES ('12345678901', 1, 987654321, 10020030, 4500.50)
</sql:update>

<sql:update dataSource="${ds}">
    INSERT INTO Angestellter (SV_Nr, Angestellten_Nr, Konto_Nr, Bankleitzahl, Kontostand)
    VALUES ('23456789012', 2, 123456789, 20030040, 3200.75)
</sql:update>

<!-- Max Mustermann zum Kapitän machen -->
<sql:update dataSource="${ds}">
    INSERT INTO Kapitaen (SV_Nr, Kapitaenspatent, Seemeilen)
    VALUES ('12345678901', 'KPT001', 12000)
</sql:update>

<!-- Beispiel: Hersteller hinzufügen -->
<sql:update dataSource="${ds}">
    INSERT INTO Hersteller (Herstellername) VALUES ('Maersk Shipyards')
</sql:update>

<!-- Beispiel: Schiffstyp hinzufügen -->
<sql:update dataSource="${ds}">
    INSERT INTO Schiff_Typ (Typennummer, Typenbezeichnung, Bruttoregistertonnen, Besatzungsstaerke, Hersteller)
    VALUES (101, 'Containerschiff', 50000, 20, 'Maersk Shipyards')
</sql:update>

<p>FILL TABLE successful!</p>
