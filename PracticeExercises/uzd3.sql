SELECT vardas,
		 pavarde
FROM Stud.Skaitytojas
GROUP BY nr;

SELECT adresas,
		 COUNT(*) AS "sk gyvenanciu skaitytoju"
FROM Stud.Skaitytojas
GROUP BY adresas;

SELECT leidykla,
		 SUM(puslapiai) AS "Bendras puslapiu skaicius",
		 SUM(COALESCE(verte, 0)) AS "Bendra verte"
FROM Stud.Knyga
GROUP BY leidykla;

SELECT DISTINCT isbn,
		 vardas,
		 pavarde
FROM Stud.Autorius;
-- TAS PATS
SELECT isbn,
		 vardas,
		 pavarde
FROM Stud.Autorius
GROUP BY isbn, vardas, pavarde;


SELECT pavadinimas,
		 leidykla
FROM Stud.Knyga
GROUP BY 1;

SELECT EXTRACT(YEAR FROM gimimas) AS "metai",
		 SUM(nr) AS "bendra nr suma gimusiu tais metais"
FROM Stud.Skaitytojas
GROUP BY EXTRACT(YEAR FROM gimimas);

-- ERROR, turi sueiti i viena reiksme
SELECT leidykla,
		 pavadinimas,
		 SUM(puslapiai) AS "Bendras puslapiu skaicius",
		 SUM(COALESCE(verte, 0)) AS "Bendra verte"
FROM Stud.Knyga
GROUP BY leidykla;

SELECT '9997' AS "isbn prasideda:",
		 COUNT(*) AS "Autoriu skaicius"
FROM Stud.Autorius
WHERE isbn LIKE '9997%'
GROUP BY isbn;

SELECT '9997' AS "isbn prasideda:",
		 COUNT(*) AS "Autoriu Simo vardu skaicius"
FROM Stud.Autorius
WHERE LOWER(vardas) LIKE 'simas'
GROUP BY isbn 
HAVING isbn LIKE '9997%';

SELECT metai,
		 COUNT(*) AS "isleistu baltosios knygu skaicius 201*"
FROM Stud.Knyga
WHERE LOWER(leidykla) LIKE 'baltoji'
GROUP BY metai 
HAVING metai/10 = 201;


SELECT A.pavadinimas,
		 A.isbn,
		 COUNT(*) AS "autoriu skaicius"
FROM Stud.Autorius A
JOIN Stud.Knyga B ON A.isbn = B.isbn
GROUP BY A.isbn ;

SELECT B.vardas,
		 B.pavarde,
		 A.skaitytojas AS "nr skaito daugiau nei 1 knyga", 
		 COUNT(*) AS "skaito knygu"
FROM Stud.Egzempliorius A
JOIN Stud.Skaitytojas B ON A.skaitytojas = B.nr
--WHERE skaitytojas IS NOT NULL
GROUP BY skaitytojas, B.nr 
HAVING COUNT(*) > 1;

SELECT leidykla, 
		 metai,
		 COUNT(*) AS "Skaicius"
FROM Stud.Knyga
GROUP BY GROUPING SETS((leidykla), (metai));

SELECT vardas, 
		 pavarde,
		 SUBSTRING(isbn FROM 1 FOR 4),
		 COUNT(*) AS "Skaicius"
FROM Stud.Autorius
GROUP BY GROUPING SETS((vardas), (pavarde), (SUBSTRING(isbn FROM 1 FOR 4)));

SELECT leidykla, 
		 metai,
		 COUNT(*) AS "Skaicius"
FROM Stud.Knyga
GROUP BY ROLLUP((leidykla), (metai));

SELECT vardas, 
		 pavarde,
		 SUBSTRING(isbn FROM 1 FOR 4),
		 COUNT(*) AS "Skaicius"
FROM Stud.Autorius
GROUP BY ROLLUP((vardas), (pavarde), (SUBSTRING(isbn FROM 1 FOR 4)));

SELECT vardas, 
		 pavarde
FROM Stud.Autorius
GROUP BY CUBE((vardas), (pavarde));

SELECT leidykla, 
		 metai
FROM Stud.Knyga
GROUP BY CUBE((leidykla), (metai));

SELECT vardas, 
		 pavarde,
		 SUBSTRING(isbn FROM 1 FOR 4)
FROM Stud.Autorius
GROUP BY CUBE((vardas), (pavarde), (SUBSTRING(isbn FROM 1 FOR 4)));

SELECT leidykla, 
		 metai,
		 SUBSTRING(isbn FROM 1 FOR 4) AS "isbn",
		 COUNT(*) AS "skaicius"
FROM Stud.Knyga
GROUP BY GROUPING SETS((leidykla, metai), (metai, (SUBSTRING(isbn FROM 1 FOR 4))));

SELECT A.pavadinimas,
		 COUNT(CASE WHEN B.paimta IS NOT NULL THEN 1 ELSE NULL END) AS "paimta",
		 COUNT(CASE WHEN B.paimta IS NULL THEN 1 ELSE NULL END) AS "laisva",
		 COUNT(b.isbn) AS "Viso"
FROM Stud.Knyga A
JOIN Stud.Egzempliorius B ON A.isbn = B.isbn
GROUP BY A.pavadinimas;

SELECT A.adresas,
		 COUNT(DISTINCT A.nr) AS "zmoniu",
		 COUNT(DISTINCT b.isbn) AS "skaito egzemplioriu"
FROM Stud.Skaitytojas A
LEFT JOIN Stud.Egzempliorius B ON A.nr = B.skaitytojas
GROUP BY A.adresas;

SELECT COUNT(CASE WHEN A.ak LIKE '5%' THEN 1 ELSE NULL END) AS "vyrai",
		 COUNT(CASE WHEN A.ak LIKE '6%' THEN 1 ELSE NULL END) AS "moterys",
		 COUNT(*) AS "viso"
FROM Stud.Skaitytojas A
GROUP BY SUBSTRING(ak, 0, 1);






-- 3 UZD 
-- Kiekvienai leidyklai joje isleistu knygu skaicius ir bendras visu ju egzemplioriu skaicius
SELECT leidykla,
		 COUNT(*) AS "Isleistu k. sk."
FROM Stud.Knyga
GROUP BY leidykla;

SELECT A.leidykla,
		 COUNT(A.leidykla) AS "Isleistu k. sk.",
		 COUNT(B.isbn) AS "Egzemplioriu sk."
FROM Stud.Knyga A
JOIN Stud.Egzempliorius B ON A.isbn = B.isbn
GROUP BY A.leidykla, B.isbn;

-- ATS.:
SELECT A.leidykla,
		 COUNT(DISTINCT A.isbn) AS "Isleistu k. sk.",
		 COUNT(B.isbn)	AS "Egzemplioriu sk."	 
FROM Stud.Knyga A
JOIN Stud.Egzempliorius B ON A.isbn = B.isbn
GROUP BY A.leidykla;
--

SELECT A.leidykla,
		 COUNT(DISTINCT A.isbn) AS "Isleistu k. sk.",
		 COUNT(B.isbn)	AS "Egzemplioriu sk.",
		 COUNT(CASE WHEN B.paimta IS NOT NULL THEN 1 ELSE NULL END) AS "paimta",
		 COUNT(CASE WHEN B.paimta IS NULL THEN 1 ELSE NULL END) AS "laisva"
FROM Stud.Knyga A
JOIN Stud.Egzempliorius B ON A.isbn = B.isbn
GROUP BY A.leidykla;

