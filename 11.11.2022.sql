SELECT ProductID AS UrunID,
				Name AS UrunAdi,
				ProductNumber UrunKodu,
				Color AS Renk,
				ListPrice BirimFiyat
INTO AdvUrunler
FROM AdventureWorks2014.Production.Product

--Urun ID si 506 olan ürün
SELECT * 
FROM AdvUrunler
WHERE UrunID=506
--Birim fiyatý 50 ile 150 arasýnda olan ürünler
SELECT *
FROM AdvUrunler
WHERE BirimFiyat>=50 AND BirimFiyat<=150 --WHERE BirimFiyat BETWEEN 50 AND 150
--Ürün adýnda 'Road' geçen ürünler
SELECT * 
FROM AdvUrunler
WHERE UrunAdi Like '%Road%'
--UrunKodunun ikinci karakteri 'j' olan ürünler
SELECT * 
FROM AdvUrunler
WHERE UrunKodu Like '_j%'
--En pahalý 10 ürün
SELECT TOP(10) * 
FROM AdvUrunler
ORDER BY  BirimFiyat DESC
--Urunler hangi renklerden
SELECT DISTINCT Renk FROM AdvUrunler
--SELECT Renk FROM AdvUrunler GROUP BY Renk

--Hangi renkten kaçar tane ürün var
SELECT Renk,Count(*) AS RenkSayisi FROM AdvUrunler
GROUP BY Renk
--7.Sorguyu büyükten küçüðe göre listeleyiniz
SELECT Renk,Count(*) AS RenkSayisi FROM AdvUrunler -- Se-Fr-Wh-Gr-Or sýralama önemli
GROUP BY Renk
ORDER BY RenkSayisi DESC
--ID si 500(500-599) olan üründen  en pahali urunden en ucuza listeleyiniz
SELECT *
FROM AdvUrunler
WHERE UrunID>=500 AND UrunID<=599 --LIKE '%5' de kullanýlabilir
ORDER BY BirimFiyat DESC
--Içinde frame geçen ürünlerden en pahalý 5 tanesini listeleyiniz
SELECT TOP(5) *
FROM AdvUrunler
WHERE UrunAdi LIKE '%frame%' 
ORDER BY BirimFiyat DESC

-- 5 ten fazla urun olan renk gruplarý
--Gruop by da filtreleme yapmak istersek
SELECT Renk,Count(*) Adet FROM AdvUrunler
GROUP BY Renk HAVING Count(*)>5
ORDER BY Adet DESC

--Renkleri Tanýmlanmamýþ Ürünler
SELECT * FROM AdvUrunler
WHERE Renk IS NULL
--Renkleri Tanýmlanmýþ Ürünler
SELECT * FROM AdvUrunler
WHERE Renk IS NOT NULL

--DDL KOMUTLARI
--CREATE - YENÝ BÝR NESNE OLUÞTURMAK ÝÇÝN KULLANILIR
--ALTER - VAR OLAN BÝR NESNEYÝ DEÐÝÞTÝRMEK ÝÇÝN KULLANILIR
--DROP - VAR OLAN NESNEYÝ KOMPLE SÝLMEK ÝÇÝN

CREATE TABLE Kitaplar --Kitaplar table oluþturduk
(KitapID int,
KitapAdi varchar(100),
Yazar varchar(50),
Kategori varchar(50),
Fiyat money)

--ERM DIAGRAM

ALTER TABLE Kitaplar ADD YayinEvi varchar(50) --Tabloya sütun ekledik

ALTER TABLE Kitaplar DROP COLUMN YayinEvi --Tablodan sütunu çýkardýk

DROP TABLE Kitaplar --Kitaplar tablosunu database den çýkardýk

-- SQL de 2 tane temel kural vardýr
-- Bir veri tabaný sisteminde bir veri mümkün olduðunca az tekrar etmedilir.
-- Veriler tutarlý olmalýdýr.

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

INSERT INTO Bolum VALUES(1,'Muhasebe'),(2,'Satýþ'),(3,'BIM'),(4,'IK')
INSERT INTO Personel VALUES(1,'Cevdet','Korkmaz',1),(2,'Selami','Dursun',2),(3,'Dursun','Durmasýn',2),
(4,'Cavit','Mavi',3),(5,'Zafer','Mavi',11)

--JOINS(BÝRDEN FAZLA TABLOLARI BÝRLEÞTÝRME)
SELECT * FROM Personel
SELECT * FROM Bolum

--CROSS JOIN
--Geleneksel Yöntem
SELECT * FROM Personel,Bolum --Her ihtimali döker, Server bu iþi yapýyor
--Microsoft Yöntemi
SELECT * FROM Personel CROSS JOIN Bolum

--INNER JOIN
--Eþleþen kayýtlarý getirir
--Geleneksel
SELECT * FROM Personel,Bolum
WHERE Personel.BolumID=Bolum.BolumID
--Microsoft
SELECT * FROM Personel INNER JOIN Bolum
ON Personel.BolumID=Bolum.BolumID

--OUTER JOIN
--Eþleþen ve Eþleþmeyen kayýtlarý getirir
SELECT * FROM Personel AS P LEFT OUTER JOIN Bolum AS B --Soldaki eþleþenler gelir
ON P.BolumID =B.BolumID

SELECT * FROM Personel AS P RIGHT OUTER JOIN Bolum AS B --Soldaki eþleþenler gelir
ON P.BolumID =B.BolumID

SELECT * FROM Personel AS P FULL OUTER JOIN Bolum AS B -- Hepsini getirir
ON P.BolumID =B.BolumID