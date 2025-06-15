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

<!-- Tabelle Person erstellen -->
<sql:update dataSource="${ds}">
    CREATE TABLE Person (
    SV_Nummer VARCHAR2(11) PRIMARY KEY,
    Vorname VARCHAR2(50) NOT NULL,
    Nachname VARCHAR2(50) NOT NULL,
    Ort VARCHAR2(100),
    Strasse VARCHAR2(100),
    Postleitzahl VARCHAR2(10),
    Hausnummer VARCHAR2(10)
    )
</sql:update>

<!-- Tabelle Telefonnummer erstellen -->
<sql:update dataSource="${ds}">
    CREATE TABLE Telefonnummer (
    SV_Nummer     VARCHAR2(11) NOT NULL,
    Telefonnummer VARCHAR2(30) NOT NULL,

    PRIMARY KEY (SV_Nummer, Telefonnummer),
    FOREIGN KEY (SV_Nummer) REFERENCES Person(SV_Nummer)
    )
</sql:update>

<!-- Tabelle Passagier erstellen -->
<sql:update dataSource="${ds}">
    CREATE TABLE Passagier (
    SV_Nummer VARCHAR2(11) PRIMARY KEY,
    Passagier_Nummer INT NOT NULL,

    FOREIGN KEY (SV_Nummer) REFERENCES Person(SV_Nummer)
    )
</sql:update>


<!-- Tabelle Bank erstellen -->
<sql:update dataSource="${ds}">
    CREATE TABLE Bank (
    Bankleitzahl INT PRIMARY KEY,
    Bankname VARCHAR2(30) NOT NULL
    )
</sql:update>

<!-- Tabelle Angestellter erstellen -->
<sql:update dataSource="${ds}">
    CREATE TABLE Angestellter (
    SV_Nummer VARCHAR2(11) PRIMARY KEY,
    Angestellten_Nr INT NOT NULL,
    Konto_Nr INT NOT NULL,
    Bankleitzahl INT NOT NULL,
    Kontostand NUMBER(12, 2),

    FOREIGN KEY (SV_Nummer) REFERENCES Person(SV_Nummer),
    FOREIGN KEY (Bankleitzahl) REFERENCES Bank(Bankleitzahl),
    UNIQUE (Konto_Nr, Bankleitzahl)
    )
</sql:update>

<p>Tabellen wurden erfolgreich erstellt!</p>
