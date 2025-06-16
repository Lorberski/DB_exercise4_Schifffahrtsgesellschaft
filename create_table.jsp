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

<!-- Tabelle Hersteller erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Hersteller (
Herstellername VARCHAR2(50) PRIMARY KEY
)
</sql:update>

<!-- Tabelle Schiff_Typ erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Schiff_Typ (
Typennummer INT PRIMARY KEY,
Typenbezeichnung VARCHAR2(50),
Bruttoregistertonnen NUMBER,
Besatzungsstaerke INT,
Hersteller VARCHAR2(50) NOT NULL,

FOREIGN KEY (Hersteller) REFERENCES Hersteller(Herstellername)
)
</sql:update>

<!-- Tabelle Person erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Person (
SV_Nr VARCHAR2(11) PRIMARY KEY,
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
SV_Nr     VARCHAR2(11) NOT NULL,
Telefonnummer VARCHAR2(30) NOT NULL,

PRIMARY KEY (SV_Nr, Telefonnummer),
FOREIGN KEY (SV_Nr) REFERENCES Person(SV_Nr)
)
</sql:update>

<!-- Tabelle Passagier erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Passagier (
SV_Nr VARCHAR2(11) PRIMARY KEY,
Passagier_Nr INT NOT NULL UNIQUE,

FOREIGN KEY (SV_Nr) REFERENCES Person(SV_Nr)
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
SV_Nr VARCHAR2(11) PRIMARY KEY,
Angestellten_Nr INT NOT NULL UNIQUE,
Konto_Nr INT NOT NULL,
Bankleitzahl INT NOT NULL,
Kontostand NUMBER(12, 2),

FOREIGN KEY (SV_Nr) REFERENCES Person(SV_Nr),
FOREIGN KEY (Bankleitzahl) REFERENCES Bank(Bankleitzahl),
UNIQUE (Konto_Nr, Bankleitzahl)
)
</sql:update>

<!-- Tabelle Kapitaen erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Kapitaen (
SV_Nr VARCHAR2(11) PRIMARY KEY,
Kapitaenspatent VARCHAR2(11) NOT NULL,
Seemeilen NUMBER(12, 2),

FOREIGN KEY (SV_Nr) REFERENCES Angestellter(SV_Nr)
)
</sql:update>

<!-- Tabelle Techniker erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Techniker (
Lizenz_Nr INT PRIMARY KEY,
Grad_der_Ausbildung VARCHAR2(50),
SV_Nr VARCHAR2(11) NOT NULL UNIQUE,
wartet_Schiff_Typ INT NOT NULL,

FOREIGN KEY (SV_Nr) REFERENCES Angestellter(SV_Nr),
FOREIGN KEY (wartet_Schiff_Typ) REFERENCES Schiff_Typ(Typennummer)
)
</sql:update>

<!-- Tabelle Passage erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Passage (
Passagen_Nr INT PRIMARY KEY,
Abfahrtshafen VARCHAR2(50),
Zielhafen VARCHAR2(50),
Abfahrtszeit Date,
Ankunftszeit Date
)
</sql:update>

<!-- Tabelle Buchen erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Buchen (
Buchungsnummer INT PRIMARY KEY,
Klasse VARCHAR2(20),
Buchungsdatum DATE,
Passagen_Nr INT NOT NULL,
Passagier_Nr INT NOT NULL,

FOREIGN KEY (Passagen_Nr) REFERENCES Passage(Passagen_Nr),
FOREIGN KEY (Passagier_Nr) REFERENCES Passagier(Passagier_Nr)
)
</sql:update>

<!-- Tabelle Schiff_Exemplar erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Schiff_Exemplar (
Inventarnummer INT PRIMARY KEY,
Typennummer INT NOT NULL,
Fertigungsjahr INT,
Seemeilen NUMBER,
Code VARCHAR2(50) UNIQUE NOT NULL,

FOREIGN KEY (Typennummer) REFERENCES Schiff_Typ(Typennummer)
)
</sql:update>

<!-- Tabelle wartet_ab erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE wartet_ab (
abhaengige_Passage INT NOT NULL,
vorausgesetzte_Passage INT NOT NULL,

PRIMARY KEY (abhaengige_Passage, vorausgesetzte_Passage),
FOREIGN KEY (abhaengige_Passage) REFERENCES Passage(Passagen_Nr),
FOREIGN KEY (vorausgesetzte_Passage) REFERENCES Passage(Passagen_Nr)
)
</sql:update>

<!-- Tabelle Ausleihberechtigter_entlehnen erstellen -->
<sql:update dataSource="${ds}">
CREATE TABLE Ausleihberechtigter_entlehnen (
Logbuch VARCHAR2(50) PRIMARY KEY,
SV_Nr VARCHAR2(11) NOT NULL,

FOREIGN KEY (Logbuch) REFERENCES Schiff_Exemplar(Code),
FOREIGN KEY (SV_Nr) REFERENCES Angestellter(SV_Nr)
)
</sql:update>


<!-- Tabelle Fahren erstellen -->
<sql:update dataSource="${ds}">
    CREATE TABLE Fahren (
    SV_Nr VARCHAR2(11),
    Passagen_Nr INT,
    Typennummer INT,

    FOREIGN KEY (Passagen_Nr) REFERENCES Passage(Passagen_Nr),
    FOREIGN KEY (SV_Nr) REFERENCES Kapitaen(SV_Nr),
    FOREIGN KEY (Typennummer) REFERENCES Schiff_Typ(Typennummer)
    )
</sql:update>
<p>Tabellen wurden erfolgreich erstellt!</p>
