SELECT ProductID AS UrunID,
				Name AS UrunAdi,
				ProductNumber UrunKodu,
				Color AS Renk,
				ListPrice BirimFiyat
INTO AdvUrunler
FROM AdventureWorks2014.Production.Product

--Urun ID si 506 olan �r�n
SELECT * 
FROM AdvUrunler
WHERE UrunID=506
--Birim fiyat� 50 ile 150 aras�nda olan �r�nler
SELECT *
FROM AdvUrunler
WHERE BirimFiyat>=50 AND BirimFiyat<=150 --WHERE BirimFiyat BETWEEN 50 AND 150
--�r�n ad�nda 'Road' ge�en �r�nler
SELECT * 
FROM AdvUrunler
WHERE UrunAdi Like '%Road%'
--UrunKodunun ikinci karakteri 'j' olan �r�nler
SELECT * 
FROM AdvUrunler
WHERE UrunKodu Like '_j%'
--En pahal� 10 �r�n
SELECT TOP(10) * 
FROM AdvUrunler
ORDER BY  BirimFiyat DESC
--Urunler hangi renklerden
SELECT DISTINCT Renk FROM AdvUrunler
--SELECT Renk FROM AdvUrunler GROUP BY Renk

--Hangi renkten ka�ar tane �r�n var
SELECT Renk,Count(*) AS RenkSayisi FROM AdvUrunler
GROUP BY Renk
--7.Sorguyu b�y�kten k����e g�re listeleyiniz
SELECT Renk,Count(*) AS RenkSayisi FROM AdvUrunler -- Se-Fr-Wh-Gr-Or s�ralama �nemli
GROUP BY Renk
ORDER BY RenkSayisi DESC
--ID si 500(500-599) olan �r�nden  en pahali urunden en ucuza listeleyiniz
SELECT *
FROM AdvUrunler
WHERE UrunID>=500 AND UrunID<=599 --LIKE '%5' de kullan�labilir
ORDER BY BirimFiyat DESC
--I�inde frame ge�en �r�nlerden en pahal� 5 tanesini listeleyiniz
SELECT TOP(5) *
FROM AdvUrunler
WHERE UrunAdi LIKE '%frame%' 
ORDER BY BirimFiyat DESC

-- 5 ten fazla urun olan renk gruplar�
--Gruop by da filtreleme yapmak istersek
SELECT Renk,Count(*) Adet FROM AdvUrunler
GROUP BY Renk HAVING Count(*)>5
ORDER BY Adet DESC

--Renkleri Tan�mlanmam�� �r�nler
SELECT * FROM AdvUrunler
WHERE Renk IS NULL
--Renkleri Tan�mlanm�� �r�nler
SELECT * FROM AdvUrunler
WHERE Renk IS NOT NULL

--DDL KOMUTLARI
--CREATE - YEN� B�R NESNE OLU�TURMAK ���N KULLANILIR
--ALTER - VAR OLAN B�R NESNEY� DE���T�RMEK ���N KULLANILIR
--DROP - VAR OLAN NESNEY� KOMPLE S�LMEK ���N

CREATE TABLE Kitaplar --Kitaplar table olu�turduk
(KitapID int,
KitapAdi varchar(100),
Yazar varchar(50),
Kategori varchar(50),
Fiyat money)

--ERM DIAGRAM

ALTER TABLE Kitaplar ADD YayinEvi varchar(50) --Tabloya s�tun ekledik

ALTER TABLE Kitaplar DROP COLUMN YayinEvi --Tablodan s�tunu ��kard�k

DROP TABLE Kitaplar --Kitaplar tablosunu database den ��kard�k

-- SQL de 2 tane temel kural vard�r
-- Bir veri taban� sisteminde bir veri m�mk�n oldu�unca az tekrar etmedilir.
-- Veriler tutarl� olmal�d�r.

CREATE TABLE Personel(
		PerID int,
		Ad varchar(20),
		Soyad varchar(20),
		BolumID int
		)
CREATE TABLE Bolum(
					BolumID tinyint,
					BolumAdi varchar(50)
					)

INSERT INTO Bolum VALUES(1,'Muhasebe'),(2,'Sat��'),(3,'BIM'),(4,'IK')
INSERT INTO Personel VALUES(1,'Cevdet','Korkmaz',1),(2,'Selami','Dursun',2),(3,'Dursun','Durmas�n',2),
(4,'Cavit','Mavi',3),(5,'Zafer','Mavi',11)

--JOINS(B�RDEN FAZLA TABLOLARI B�RLE�T�RME)
SELECT * FROM Personel
SELECT * FROM Bolum

--CROSS JOIN
--Geleneksel Y�ntem
SELECT * FROM Personel,Bolum --Her ihtimali d�ker, Server bu i�i yap�yor
--Microsoft Y�ntemi
SELECT * FROM Personel CROSS JOIN Bolum

--INNER JOIN
--E�le�en kay�tlar� getirir
--Geleneksel
SELECT * FROM Personel,Bolum
WHERE Personel.BolumID=Bolum.BolumID
--Microsoft
SELECT * FROM Personel INNER JOIN Bolum
ON Personel.BolumID=Bolum.BolumID

--OUTER JOIN
--E�le�en ve E�le�meyen kay�tlar� getirir
SELECT * FROM Personel AS P LEFT OUTER JOIN Bolum AS B --Soldaki e�le�enler gelir
ON P.BolumID =B.BolumID

SELECT * FROM Personel AS P RIGHT OUTER JOIN Bolum AS B --Soldaki e�le�enler gelir
ON P.BolumID =B.BolumID

SELECT * FROM Personel AS P FULL OUTER JOIN Bolum AS B -- Hepsini getirir
ON P.BolumID =B.BolumID