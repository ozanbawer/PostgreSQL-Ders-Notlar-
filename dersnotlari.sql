SELECT * FROM film;   				
-- Bütün tabloları getiren sorgu

SELECT title,description FROM film;   
-- Belirli bir tablo/tabloları getiren sorgu  
-- NOT:büyük küçük harf duyarlılığı için tırnaklı "column" şeklinde yazılmalı 

SELECT first_name || ' ' || last_name AS full_name FROM actor;   
-- AS(ALIAS) yeni_kolon_ismi  için kullanılır
-- || kolonları birleştirmek için kullanılır yerine => CONCAT(first_name, ' ', last_name) de kullanılabilir.

SELECT UPPER(first_name) FROM actor;
-- UPPER(kolonismi) o kolondaki verileri büyük harf yapar, LOWER() küçük harf yapar.

SELECT SUBSTRING(title, 1, 5) FROM film;
-- SUBSTRING (kolon ismi, ilk harakter, son karakter) 
-- => o tablodaki her satırda belirlenen sayıdaki karakterleri getiriyor UPPER ve LOWER ile kullanılabilir

SELECT LENGTH(title) FROM film; 
--LENGTH(kolonismi) => tablodaki her satırın karakter uzunluğunu verir.

SELECT title,rating FROM film
WHERE rating = 'G';  "WHERE" koşullar belirlemek için kullanılır 
-- < küçüktür , > büyüktür , >= büyükeşit, <= küçük eşit , <> ve != eşit değildir 

SELECT * FROM film
WHERE length BETWEEN 50 AND 100;
--"BETWEEN value1 AND value2" belirli bir aralıktaki verileri göstermek için kullanılır  (stringlerde de kullanılır)
--"NOT BETWEEN value1 AND value2" NOT kullanılırsa o aralıkta olmayanları getirir koşulun tersini alır

SELECT * FROM film
WHERE rental_rate IN (0.99, 2.99);
-- "IN (value1,value2,...)" belirli değerlerin içinde olduğu verileri göstermek için kullanılır
-- "NOT IN" kullanılırsa o değer olmayanları getirir koşulun tersini alır

SELECT * FROM film
WHERE rental_rate IN (2.99, 0.99) AND "length" BETWEEN 100 AND 130
-- İki koşul arasına "AND" gelirse her iki koşulunda sağlandığı bir sorgu oluşur 
--(Hepsi gerçekleşmek zorunda)

SELECT * FROM film
WHERE rental_rate = 0.99 OR rating = 'PG';
-- İki koşul arasına "OR" gelirse her iki koşuldan her birinin ayrı ayrı sağlandığı bir sorgu oluşur (Biri gerçekleşse yeterli)

/* AND ve OR için "NOT" kullanılırsa o koşulun sağlanmadığı sorgulama yapılır ve gösterilir
 AND sorgulamalarda OR'a göre daha önceliklidir dikkat edilmesi gerekiyor !!!! */

SELECT * FROM film
WHERE title LIKE 'B%'; 
--LIKE anahtar kelimesi ile bir karakteri bilinen veri/veriler getirilir
-- %  0 veya daha fazla karakter için kullanılır _ ile sadece bir karakter için kullanılır 
-- B ile başlayıp içinde M olaran ve % olan yerlerde de 0 veya daha fazla karakter için LIKE 'B%M%'   
--'B_' ile başlayı sonrasında sadece 1 karakter için LIKE 'B_'
--% veya _ nerede olduğu o yerdeki karakteri temsil eder başta sonra ortada farketmez ve beraberde kullanılır LIKE 'C_%o'
-- LIKE büyük küçük harf duyarlıdır

SELECT * FROM film
WHERE title ILIKE 'b%H'; 
--LIKE anahtar kelime ile aynı özelliklerdedir fakat büyük küçük harf duyarlılığı yoktur 

/* NOT LIKE veya NOT ILIKE kullanıldığında bu şartı sağlamayanlar getirilir */

SELECT * FROM film
WHERE title SIMILAR TO 'B%|C%';
-- SIMILAR TO LIKE gibi çalışır ama farklı özellikleri var örn: | veya anlamında daha fazla seçenek sağlar (döküman incele)

SELECT * FROM film
WHERE title SIMILAR TO '[A-Z,a-z]{5}'; 
--Bu özellik ile a'danz'ye büyük küçük farketmeksizin 5 karakterli olanları getirir
--A,Z ve 5 değiştirildiğinde ona göre veriler getirilir {5,7} olursa 5den 7ye kadar olan karakterler gelir

SELECT COUNT(*) FROM customer;
-- COUNT sütun sayısını toplayan bir özelliktir (Boş sütunları saymaz veri olanları sayar)
-- Koşullara bağlı olan sütunların sadece sayısını gösterir

SELECT DISTINCT rental_rate FROM film;
--DISTINCT anahtar kelimesi benzersiz olanları listeler 

SELECT * FROM film
ORDER BY "length" DESC;
-- ORDER BY .... DESC (ASC) verileri sıralar sayıları büyük-küçük harfleri a-z olarak
-- DESC büyükten küçüğe (z-a) ASC küçükten büyüğe (a-z) (NOT: NULL veriler en büyükten sonra veya zden sonra gibi işlenir)

SELECT * FROM film
ORDER BY "length" ASC
LIMIT 10
--LIMIT sayı; verilerin ilk sayı kadarını getirir
OFFSET 5
--OFFSET sayı; verilerin ilk sayı kadarını atlar öyle getirir
/*OFFSET VE LIMIT BERABERDE KULLANILABİLİR AYRI AYRIDA */


SELECT AVG("length"), MAX("length"), MIN ("length"), SUM("length") 
FROM film;
--AVG: sütunun ortalamasını alır, MAX: sütunda en büyük olanı alır, MIN: sütunda en küçük olanı alır, SUM: bütün sütunun toplamını alır */


SELECT rental_rate, MAX("length") FROM film
GROUP BY rental_rate;
--GROUP BY column1 anahtar ifadesi kullanıldığı sütunu gruplar ve fonsiyonlar ile kullanılınca anlamlı çıktı verir*/

/* GENEL TEKRAR*/
SELECT customer_id, SUM(amount) AS total_amount FROM payment -- default syntax (AS yeni sütuna isim verme)
WHERE customer_id < 100 -- sütun koşulları belirtmek için
GROUP BY customer_id -- sütuna göre gruplama
HAVING SUM(amount) > 100 -- gruplanan sütunların değerleri üzerinden koşul (sadece yeni değerlere göre uygular)
ORDER BY total_amount -- azdan çoğa (veya çoktan aza) sırlama
LIMIT 10 -- gösterilecek veri sayısını limitlendirme
OFFSET 5; -- baştan atlanacak veri sayısını belirtme
/* GENEL TEKRAR*/

                ##VERİ TABANI OLUŞTURMA

/* YENİ VERİ TABANI OLUŞTURMA (psql shell üzerinde) */
-- \l : veri tabanlarını sıralar, 
-- \c vtismi : vtismi database bağlanır, 
-- \! cls: sayfayı temizler
-- \d : çıkış yapar
-- \dt: tabloları sıralar

CREATE DATABASE vtismi;  
-- Veri Tabanı oluşturur
DROP DATABASE vtismi; 
-- Veri Tabanını siler (o veri tabanından çıkmadan silmez)

-- Veri Tabanına tablolar eklemek için bu syntax kullanılır.
CREATE TABLE book (  -- book tablosunu oluşturma 
	"id" SERIAL PRIMARY KEY,   -- id: sütun ismi, SERIAL: veri tipi sıralı sayılar için, PRIMARY KEY: benzersiz sayılar
	title VARCHAR(255) NOT NULL, -- title: sütun ismi VARCHAR(255) : Veri Tipi karakter için, NOT NULL: Boş olamaz
	author_name VARCHAR(100) NOT NULL,
	page_number INT -- INT(INTEGER): veri tipi sayı  (not: veri tipleri için dökümana bakılacak) 
);

/* NOT: Eğer FOREIGN KEY kullanılacaksa syntaxı 
"author_id INT REFERENCES author(id)" 
şeklinde olması gerekiyor bu sayede başka bir tablodaki id'e referans verilerek o tablodaki veri kullanılır */

-- Veri Tabanına tablolar silmek için bu syntax kullanılır.
DROP TABLE book;

-- Tablolara veri ekleme
INSERT INTO book (title, author_name, page_number) -- Tabloların ismi (id: SERIAL otomatik geldiği için yazmaya gerek yok)
VALUES
	('kitapismi', 'yazar ismi', 345), 		-- 1. satır
	.
	.
	.

	/* KİTAPLIK VERİ TABANI OLUŞTURMA */

/* YAZAR TABLOSU OLUŞTURMA */

CREATE TABLE author (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100) NOT NULL,
	"birthday" DATE
); 


/* KİTAP TABLOSU OLUŞTURMA */

CREATE TABLE book (
	"id" SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	author_id INT REFERENCES author(id),
	page_number INT
); 


/* YAZARLARIN author TABLOSUNA EKLENMESİ */
INSERT INTO author ("name", birthday) 
VALUES 
		('Yaşar Kemal', '1889-02-15'),
		('Michel De Montaigne', '1916-06-21'),
		('Sabahattin Ali', '1885-06-01' );


/* KİTAPLARIN book TABLOSUNA EKLENMESİ */
INSERT INTO book (title,author_id,page_number)
VALUES 
	('Kuyucaklı Yusuf', 3, 268 ),
	('Denemeler', 2, 296),
	('Binboğalar Efsanesi', 1, 281);


/* FOREIGN KEY KULLANILARAK TABLOLAR ARASI İLİŞKİ KURMA one-to-one */


CREATE TABLE "user" (
	"id" SERIAL PRIMARY KEY,
	email VARCHAR(150) UNIQUE
); 

CREATE TABLE user_setting (
	"id" SERIAL PRIMARY KEY,
	theme VARCHAR(10), 
	"logged" BOOLEAN,
	user_id INT UNIQUE REFERENCES "user"("id")  /* FOREIGN KEY İLİŞKİSİ */
); 

INSERT INTO "user" (email)
VALUES
	('ozanbaran@gmail.com'),
	('ahmetcan@gmail.com'),
	('yavuzselim@gmail.com'),
	('fatih1453@gmail.com');

INSERT INTO user_setting (theme, "logged", user_id)
VALUES
	('dark', true, 1),
	('default', true, 2),
	('dark', false, 3),
	('light', false, 4);

/* FOREIGN KEY KULLANILARAK TABLOLAR ARASI İLİŞKİ KURMA many-to-many */

CREATE TABLE employee (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL
);

CREATE TABLE project (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL
);


CREATE TABLE employee_project (
	employee_id INT REFERENCES employee("id"),
	project_id INT REFERENCES project("id"),
	PRIMARY KEY (employee_id, project_id)
);


INSERT INTO project ("name")
VALUES
	('data analysis'),
	('game of survival');

INSERT INTO employee_project (employee_id,project_id)
VALUES
	(1,2),
	(2,1);

/* VERİ GÜNCELLEME */

CREATE TABLE employee (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	age INT,
	salary INT
); 

INSERT INTO employee (name, age, salary)
VALUES
	('Ozan', 35, 72000),
	('Yusuf', 37, 95000),
	('Onur', 27, 156000); 

/* TABLODAKİ VERİLERİ GÜNCELLEME İŞLEMİ */

UPDATE employee  --veri güncellenecek tablo
SET salary = salary*1.50 -- güncellenecek sütun ve güncellemesi
WHERE age < 30  -- belli şartlara göre güncelleme yapılabilir
RETURNING "name"  -- değiştirilen satırları gösterir (* : bütün sütunları, sütunismi: sadece o sütunu getirir)
;

/* TABLODAKİ VERİLERİ SİLME İŞLEMİ */

DELETE FROM employee --veri silinecek tablo
WHERE id = 2; -- silme işlemi için koşul (koşul olmazsa bütün tablodaki verileri siler)
RETURNING "name"  -- değiştirilen satırları gösterir (* : bütün sütunları, sütunismi: sadece o sütunu getirir)

/* TABLOYA SÜTUN EKLEME VEYA ÖZELLİK DEĞİŞTİRME */

ALTER TABLE employee -- ekleme yapılacak tablo
ADD email VARCHAR(100);  -- yeni sütun ekleme işlemi 

ALTER TABLE employee -- ekleme yapılacak tablo

ALTER COLUMN email TYPE VARCHAR(50);  -- mevcut sütun özelliğini değiştirme işlemi TYPE: tipini SET:özelliğini
ALTER COLUMN email SET NOT NULL; 

ALTER COLUMN "name" SET DEFAULT 'Unknown'; -- mevcut sütuna boş veri yerine bi default veri atar "Unknown" gibi

RENAME COLUMN "name" TO full_name; -- mevcut sütunun ismini değiştirme işlemi

RENAME TO employe_new; -- tablonun ismini değiştirir

DROP COLUMN email; -- mevcut sütunu kaldırır (sütun isminden önce IF EXISTS yazılırsa hata vermez olmayan sütun için)

DROP COLUMN IF EXISTS age, 
DROP COLUMN IF EXISTS salary;  -- toplu kaldırma işlemi

ALTER TABLE employee -- ekleme yapılacak tablo
ADD CONSTRAINT unique_email UNIQUE (email); -- mevcut sütuna bi zorunluluk ekleme işlemi (PRIMARY KEY, NOT NULL vs vs )
DROP CONSTRAINT unique_email -- mevcut zorunluluğu kaldırma işlemi


