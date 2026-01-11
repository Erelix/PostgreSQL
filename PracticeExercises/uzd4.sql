-- 2.7 Strukturines uzklausos
SELECT A.pavadinimas,
		 A.leidykla
FROM Stud.Knyga A
WHERE A.isbn IN (
	SELECT B.isbn
	FROM Stud.Autorius B
	WHERE LOWER(B.vardas) LIKE 'jonas' 
);

-- Knygos ir jų autoriai, kurie yra skaitomi
SELECT isbn,
		 vardas,
		 pavarde
FROM Stud.Autorius 
WHERE isbn IN (
	SELECT isbn
	FROM Stud.Knyga
	WHERE isbn IN (
		SELECT isbn
		FROM Stud.Egzempliorius
		WHERE paimta IS NOT NULL	
);

--visi vyrai skaitytojai gime 2004
SELECT vardas, 
		 pavarde,
		 gimimas
FROM Stud.skaitytojas
WHERE ak IN (
	SELECT ak
	FROM Stud.Skaitytojas
	WHERE EXTRACT(YEAR FROM gimimas) = 2004 AND
			ak LIKE '5%'
);

--2.8 Laikinieji pavadinti uzklausu rezultatai
SELECT pavadinimas,
		 A.isbn,
		 leidykla
FROM Stud.Knyga A, 
	 (SELECT DISTINCT isbn 
	  FROM Stud.Egzempliorius
	  WHERE isbn LIKE '9998%' AND
	 		  skaitytojas IS NOT NULL) AS isbn9998
WHERE isbn9998.isbn = A.isbn;
-- =
WITH isbn9998 AS (SELECT isbn 
	 				   FROM Stud.Egzempliorius
	 				   WHERE isbn LIKE '9998%' AND
	 		  					skaitytojas IS NOT NULL)
SELECT DISTINCT pavadinimas,
		 A.isbn,
		 leidykla
FROM Stud.Knyga A, isbn9998
WHERE A.isbn = isbn9998.isbn;


WITH 
	knyg AS (SELECT isbn,
				  		 COUNT(*) AS skaicius
				FROM Stud.Egzempliorius
				WHERE skaitytojas IS NOT NULL
				GROUP BY isbn),
 	leid AS (SELECT isbn,
						 pavadinimas,
					    leidykla
				FROM Stud.Knyga)
SELECT leid.isbn,
		 pavadinimas,
	)
		 leidykla,
		 skaicius
FROM knyg, leid
WHERE leid.isbn = knyg.isbn;

WITH 
	skaityt2004 AS (SELECT nr,
								  vardas,
								  pavarde,
								  gimimas
					    FROM Stud.Skaitytojas
						 WHERE EXTRACT(YEAR FROM gimimas) = 2004),
	skaito AS (SELECT skaitytojas,
						   isbn
				  FROM Stud.Egzempliorius
				  WHERE skaitytojas IS NOT NULL),
	pavBalt AS (SELECT pavadinimas,
							 leidykla,
							 isbn
					FROM Stud.Knyga
					WHERE LOWER(leidykla) = 'baltoji'),
	autorSk AS (SELECT isbn,
		 					 COUNT(*) AS auSk
							 FROM Stud.Autorius
							 GROUP BY isbn)
SELECT pavadinimas,
		 autorSk.auSk,
		 leidykla,
		 vardas,
		 pavarde,
		 gimimas
FROM skaityt2004, skaito, pavBalt, autorSk
WHERE skaityt2004.nr = skaito.skaitytojas AND
		skaito.isbn = pavBalt.isbn AND
		autorSk.isbn = skaito.isbn;

-- 2.9 Bendrumo ir egzistavimo kvantoriai uzklausose
SELECT pavadinimas,
		 K.isbn
FROM Stud.Knyga K
WHERE EXISTS (SELECT *
				  FROM Stud.Egzempliorius 
				  WHERE skaitytojas IS NOT NULL);

SELECT A.pavadinimas,
		 A.verte
FROM Stud.Knyga A
WHERE 10 < ALL(SELECT B.verte
			 		FROM Stud.Knyga B
			 		WHERE B.verte IS NOT NULL);
SELECT A.pavadinimas,
		 A.verte
FROM Stud.Knyga A
WHERE 20 < ALL(SELECT B.verte
			 		FROM Stud.Knyga B
			 		WHERE B.verte IS NOT NULL);

SELECT A.pavadinimas,
		 A.leidykla
FROM Stud.Knyga A
WHERE 'juodoji' = ANY (SELECT LOWER(leidykla)
							  FROM Stud.Knyga);

-- 2.11 Aibiu operacijos
SELECT pavadinimas,
		 leidykla
FROM Stud.Knyga
UNION ALL
SELECT vardas,
		 pavarde
FROM Stud.Skaitytojas;

SELECT vardas
FROM Stud.Autorius
UNION
SELECT vardas
FROM Stud.Skaitytojas;

SELECT pavarde
FROM Stud.Autorius
INTERSECT
SELECT pavarde
FROM Stud.Skaitytojas;

SELECT vardas
FROM Stud.Autorius
INTERSECT ALL
SELECT vardas
FROM Stud.Skaitytojas;

-- 2.12 Lenteliu reiskiniu konstruktorius
VALUES (CURRENT_DATE);

VALUES (CURRENT_DATE - INTERVAL '1 YEAR'),
		 (CURRENT_DATE),
		 (CURRENT_DATE + INTERVAL '1 YEAR');
		 
SELECT PraeitiMetai, DabartiniaiMetai, BusimiMetai		 
FROM (VALUES (CURRENT_DATE - INTERVAL '1 YEAR',
          	  CURRENT_DATE,
		 		  CURRENT_DATE + INTERVAL '1 YEAR'))
AS Metai(PraeitiMetai, DabartiniaiMetai, BusimiMetai);

-- 2.13 Salyginiai reiskiniai
SELECT pavadinimas,
		 'pigi' AS "kaina"
FROM Stud.Knyga 
WHERE verte > 15 AND
		verte < 30
UNION
SELECT pavadinimas,
		 'vidutine'
FROM Stud.Knyga 
WHERE verte > 30 AND
		verte < 45
UNION
SELECT pavadinimas,
		 'brangi'
FROM Stud.Knyga 
WHERE verte > 45;

-- Teisingai
SELECT pavadinimas,
		 CASE 
		 	WHEN verte > 15 AND verte < 30 THEN 'pigi'
		 	WHEN verte > 30 AND verte < 45 THEN 'vidutine'
		 	WHEN verte > 45 THEN 'brangi'
		 	ELSE '-'
		 END AS "verte"
FROM Stud.Knyga;
		 




SELECT AVG(CASE 
				WHEN isbn LIKE '9999%' THEN 1
			  	WHEN isbn LIKE '9998%' THEN 2
			  	ELSE 3 END) AS "Kazkoks vidurkis"
FROM Stud.Autorius;

-- 2.14 Rekursyviosios uzklausos
-- Suma
WITH RECURSIVE Skaiciai(N) AS (
		VALUES (1)
	UNION ALL
		SELECT N + 1 
		FROM Skaiciai 
		WHERE N <= 10
)
SELECT SUM(N) FROM Skaiciai;

-- Faktorialas
WITH RECURSIVE Skaiciai(N, f) AS (
		SELECT 1, 1
	UNION ALL
		SELECT N + 1,
				 f * ( N + 1 ) 
		FROM Skaiciai 
		WHERE N < 5
)
SELECT N, f AS Faktorialai FROM Skaiciai;

-- 4 uzd
-- Dienos, kai turi buti grazinta maziau egzemplioriu negu per visas grazinimo dienas vidutiniskai, Great pateikti ir tuomet grazintu egz. sk.
WITH 
	egzSkLen AS (SELECT grazinti,
		 					  COUNT(*) AS egzemplioriuSk
							  FROM Stud.Egzempliorius
						     GROUP BY grazinti 
							  HAVING grazinti IS NOT NULL),
	averageLen AS (SELECT AVG(egzemplioriuSk) AS average
					   FROM egzSkLen)					  
SELECT egzSkLen.grazinti,
		 egzSKLen.egzemplioriuSk,
		 'maziau' AS pastaba
FROM egzSkLen, averageLen
WHERE egzemplioriuSk < averageLen.average
UNION
SELECT  (CURRENT_DATE) AS pirma,
		 averageLen.average,
		 ':Vidurkis' AS pastaba
FROM averageLen;

WITH 
	egzSkLen AS (SELECT grazinti,
		 					  COUNT(*) AS egzemplioriuSk
							  FROM Stud.Egzempliorius
						     GROUP BY grazinti 
							  HAVING grazinti IS NOT NULL),
	averageLen AS (SELECT AVG(egzemplioriuSk) AS average
					   FROM egzSkLen)					  
SELECT egzSkLen.grazinti,
		 egzSKLen.egzemplioriuSk,
		 'maziau' AS pastaba
FROM egzSkLen, averageLen
WHERE egzemplioriuSk < averageLen.average
UNION
SELECT egzSkLen.grazinti,
		 egzSKLen.egzemplioriuSk,
		 'daugiau' AS pastaba
FROM egzSkLen, averageLen
WHERE egzemplioriuSk > averageLen.average
UNION
SELECT (CURRENT_DATE) AS grazinti,
		 averageLen.average,
		 ':Vidurkis' AS pastaba
FROM averageLen
ORDER BY 2 DESC;


WITH 
	egzSkLen AS (SELECT grazinti,
		 					  COUNT(*) AS egzemplioriuSk
							  FROM Stud.Egzempliorius
						     GROUP BY grazinti 
							  HAVING grazinti IS NOT NULL),
	averageLen AS (SELECT AVG(egzemplioriuSk) AS average
					   FROM egzSkLen)					  
SELECT egzSkLen.grazinti,
		 egzSKLen.egzemplioriuSk,
		 CASE 
		 	WHEN egzemplioriuSk < averageLen.average THEN 'maziau'
		 	WHEN egzemplioriuSk > averageLen.average THEN 'daugiau'
		 	ELSE 'vidurkis'
		 END AS pastaba
FROM averageLen, egzSkLen
ORDER BY 2 DESC;	 




-- Kiekvienos leidyklos labiausiai neskaitoma knyga !!!	
		
WITH	
	leidykluKnygSkai AS (SELECT leidykla,
							  A.isbn,
							  COUNT(*) AS skaitytoju
					 FROM Stud.Knyga A, Stud.Egzempliorius B
					 WHERE A.isbn = B.isbn AND B.Skaitytojas IS NOT NULL
					 GROUP BY leidykla, A.isbn),
	minimumai(leidykla, maziausiaiSkaitoma) AS (SELECT leidykla,
								MIN(skaitytoju)
					  FROM leidykluKnygSkai C
					  GROUP BY C.leidykla
	)
SELECT leidykluKnygSkai.leidykla,
		 leidykluKnygSkai.isbn,
		 leidykluKnygSkai.skaitytoju
FROM leidykluKnygSkai, minimumai
WHERE minimumai.leidykla = leidykluKnygSkai.leidykla AND
		maziausiaiSkaitoma = leidykluKnygSkai.skaitytoju;

-- Isvesti skaitytojus, kur jeigu jo skaitomose knygose yra uz ji dar vyresniu skaitytoju
WITH 
	studIrisbn AS (SELECT B.isbn,
								 A.nr,
			 					 A.gimimas
						FROM Stud.Skaitytojas A
						JOIN Stud.Egzempliorius B ON A.nr = B.skaitytojas),
	minimumai AS (SELECT studIrisbn.isbn,
		 			  			MIN(studIrisbn.gimimas) AS min
					  FROM studIrisbn
					  GROUP BY studIrisbn.isbn)
SELECT DISTINCT C.vardas,
		 			 C.pavarde,
		 			 C.gimimas
FROM studIrisbn, minimumai, Stud.Skaitytojas C
WHERE studIrisbn.nr = C.nr AND
		C.gimimas = minimumai.min;



WITH 
	minimumai AS (SELECT D.isbn,
		 			  			MIN(C.gimimas) AS min
					  FROM Stud.Skaitytojas C
					  JOIN Stud.Egzempliorius D ON C.nr = D.skaitytojas
					  GROUP BY D.isbn)
SELECT DISTINCT A.vardas,
		 			 A.pavarde,
		 			 A.gimimas
FROM Stud.Skaitytojas A, minimumai
WHERE A.gimimas = minimumai.min;

-- Isvesti skaitytojus, kur jeigu jo skaitomose knygose yra uz ji dar vyresniu skaitytoju
WITH 
	studIrisbn AS (SELECT B.isbn,
								 A.nr,
			 					 A.gimimas
						FROM Stud.Skaitytojas A
						JOIN Stud.Egzempliorius B ON A.nr = B.skaitytojas),
	minimumai AS (SELECT studIrisbn.isbn,
		 			  			(studIrisbn.gimimas) AS min
					  FROM studIrisbn
					  GROUP BY studIrisbn.isbn)
SELECT DISTINCT C.vardas,
		 			 C.pavarde,
		 			 C.gimimas
FROM studIrisbn, minimumai, Stud.Skaitytojas C
WHERE studIrisbn.nr = C.nr AND
		C.gimimas = minimumai.min;


SELECT  A.vardas,
		 A.pavarde,
		 A.gimimas
FROM Stud.Skaitytojas A
WHERE A.gimimas IN (SELECT MIN(C.gimimas) AS min
					  	  FROM Stud.Skaitytojas C
					  	  JOIN Stud.Egzempliorius D ON C.nr = D.skaitytojas
					  	  GROUP BY D.isbn);

-- Kiekvienu metu labiausiai skaitomos knygos.
WITH 
	isbnSkaitomumas AS (SELECT B.metai,
										B.pavadinimas,
										B.isbn,
							 	 		COUNT(*) AS sk
							  FROM Stud.Egzempliorius A
							  JOIN Stud.Knyga B ON A.isbn = B.isbn
							  WHERE A.paimta IS NOT NULL
							  GROUP BY B.isbn),
	maksimumai AS (SELECT A.metai,
								 MAX(A.sk) AS maks
					   FROM isbnSkaitomumas A
					   GROUP BY A.metai)		  
SELECT D.pavadinimas,
		 D.metai,
		 D.sk
FROM isbnSkaitomumas D, maksimumai E
WHERE D.sk = E.maks AND
		E.metai = D.metai;




WITH
	isbnSkaitomumas AS (SELECT B.metai,
										B.pavadinimas,
										B.isbn,
							 	 		COUNT(*) AS sk
							  FROM Stud.Egzempliorius A
							  JOIN Stud.Knyga B ON A.isbn = B.isbn
							  WHERE A.paimta IS NOT NULL
							  GROUP BY B.metai, B.pavadinimas, B.isbn),
	maksimumai AS (SELECT A.metai,
								 MAX(A.sk) AS maks
					   FROM isbnSkaitomumas A
					   GROUP BY A.metai)
SELECT *
FROM maksimumai




-- Knygos kurias skaito daugiau zmoniu, nei ji turi autoriu
WITH	
	isbnSkaitomumas AS (SELECT isbn,
							 	 		COUNT(*) AS sk
							  FROM Stud.Egzempliorius
							  WHERE paimta IS NOT NULL
							  GROUP BY isbn),
	autoriuSkaicius AS (SELECT A.isbn,
										COUNT(*) AS sk								
							  FROM Stud.Autorius A
							  JOIN isbnSkaitomumas B ON A.isbn = B.isbn
							  GROUP BY A.isbn)
SELECT C.pavadinimas,
		 D.sk AS skaitytojuSK,
		 E.sk AS autoriuSK
FROM Stud.Knyga C, isbnSkaitomumas D, autoriuSkaicius E
WHERE C.isbn = D.isbn AND
		D.isbn = E.isbn AND
		D.sk > E.sk;
		
		
		
-- Knygos kurias skaito daugiau zmoniu, nei ji turi autoriu
WITH	
	isbnSkaitomumas AS (SELECT B.isbn,
										B.pavadinimas,
							 	 		COUNT(paimta) AS skaitytojuSK,
							 	 		COUNT(DISTINCT C.vardas || C.pavarde) AS autoriuSK
							  FROM Stud.Egzempliorius A
							  JOIN Stud.Knyga B ON B.isbn = A.isbn
							  JOIN Stud.Autorius C ON C.isbn = A.isbn
							  WHERE paimta IS NOT NULL
							  GROUP BY B.isbn)
SELECT pavadinimas,
		 skaitytojuSK,
		 autoriuSK
FROM isbnSkaitomumas 
WHERE skaitytojuSK > autoriuSK;


		 

SELECT B.isbn,
				 B.pavadinimas,
				 COUNT(paimta) AS skaitytojuSK,
				 COUNT(DISTINCT C.vardas || C.pavarde) AS autoriuSK
FROM Stud.Egzempliorius A
JOIN Stud.Knyga B ON B.isbn = A.isbn
JOIN Stud.Autorius C ON C.isbn = A.isbn
WHERE paimta IS NOT NULL
GROUP BY B.isbn 
HAVING temp.skaitytojuSK > temp.autoriuSK;





WITH 
	studIrisbn AS (SELECT B.isbn,
								 A.nr,
			 					 A.gimimas
						FROM Stud.Skaitytojas A
						JOIN Stud.Egzempliorius B ON A.nr = B.skaitytojas),
	minimumai AS (SELECT studIrisbn.isbn,
		 			  			MIN(studIrisbn.gimimas) AS min
					  FROM studIrisbn
					  GROUP BY studIrisbn.isbn)
SELECT DISTINCT C.vardas,
		 			 C.pavarde,
		 			 C.gimimas
FROM studIrisbn, minimumai, Stud.Skaitytojas C
WHERE studIrisbn.nr = C.nr AND
		C.gimimas = minimumai.min;

		
		
SELECT C.pavadinimas,
		 b.isbn,
		 B.skaitytojas,
		 EXTRACT (YEAR FROM age(A.gimimas)) AS amzius
FROM Stud.Egzempliorius B
JOIN Stud.Skaitytojas A ON A.nr = B.skaitytojas
JOIN Stud.Knyga C ON B.isbn = C.isbn
WHERE B.paimta IS NOT NULL;


WITH 
	lentele AS (
SELECT C.pavadinimas,
		 B.isbn,
		 B.skaitytojas,
		 EXTRACT (YEAR FROM age(A.gimimas)) AS amzius
FROM Stud.Egzempliorius B
JOIN Stud.Skaitytojas A ON A.nr = B.skaitytojas
JOIN Stud.Knyga C ON B.isbn = C.isbn
WHERE B.paimta IS NOT NULL
)
SELECT *
FROM lentele L
WHERE L.amzius < ANY (SELECT amzius
							 FROM lentele F
							 WHERE L.isbn = F.isbn);
		
	
SELECT C.pavadinimas,
		 B.isbn,
		 B.skaitytojas,
		 A.gimimas
FROM Stud.Egzempliorius B
JOIN Stud.Skaitytojas A ON A.nr = B.skaitytojas
JOIN Stud.Knyga C ON B.isbn = C.isbn
WHERE B.paimta IS NOT NULL;
					 
WITH 
	lentele AS (SELECT C.pavadinimas,
		 					 B.isbn,
		 					 B.skaitytojas,
		 					 A.gimimas
					FROM Stud.Egzempliorius B
					JOIN Stud.Skaitytojas A ON A.nr = B.skaitytojas
					JOIN Stud.Knyga C ON B.isbn = C.isbn
					WHERE B.paimta IS NOT NULL)
SELECT *
FROM lentele L
WHERE L.gimimas < ANY (SELECT gimimas
							 FROM lentele F
							 WHERE L.isbn = F.isbn);


-- Isvesti skaitytojus, kur jeigu jo skaitomose knygose yra uz ji dar vyresniu skaitytoju								 
WITH 
	lentele AS (SELECT B.isbn,
							 B.skaitytojas,
							 A.gimimas
					FROM Stud.Egzempliorius B
					JOIN Stud.Skaitytojas A ON A.nr = B.skaitytojas
					)
SELECT *
FROM Stud.Skaitytojas S
WHERE S.gimimas > ANY (SELECT gimimas
							  FROM lentele F, Stud.Egzempliorius H
							  WHERE H.isbn = F.isbn AND
							  		  H.skaitytojas = S.nr);
							 
							 				 
SELECT pavadinimas,
		 K.isbn
FROM Stud.Knyga K
WHERE EXISTS (SELECT *
				  FROM Stud.Egzempliorius 
				  WHERE skaitytojas IS NOT NULL);

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

						
						
SELECT pavadinimas
FROM Stud.Knyga
ORDER BY metai
FETCH FIRST 4 ROWS ONLY OFFSET 2;

SELECT pavadinimas 
FROM Stud.Knyga
ORDER BY metai
FETCH FIRST 6 ROWS ONLY;

SELECT ROW_NUMBER() OVER (ORDER BY pavadinimas ASC) AS nr,
		 pavadinimas
FROM Stud.Knyga
ORDER BY nr
FETCH FIRST 6 ROWS ONLY;

		


								

