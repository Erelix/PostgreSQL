SELECT A.nr,
		 vardas,
		 pavarde,
		 isbn
FROM Stud.Skaitytojas AS A,
	  Stud.Egzempliorius AS B
WHERE B.skaitytojas = A.nr;

SELECT isbn,
		 B.vardas,
		 B.pavarde
FROM Stud.Autorius AS A,
	  Stud.Skaitytojas AS B
WHERE A.vardas = B.vardas AND
		A.pavarde = B.pavarde;

SELECT A.isbn,
		 A.vardas,
		 A.pavarde
FROM Stud.Autorius AS A,
	  Stud.knyga AS B
WHERE A.isbn = B.isbn;

SELECT DISTINCT A.isbn,
		 			 A.vardas,
		 			 A.pavarde,
		 			 B.isbn
FROM Stud.Autorius AS A,
	  Stud.Egzempliorius AS B
WHERE skaitytojas IS NOT NULL AND
		A.isbn = B.isbn;

-- Neveikia
SELECT COUNT(A.isbn) AS "DB Atorius eil. sk.",
		 COUNT(B.nr) AS "DB Egzempliorius eil. sk.",
		 COUNT(*) AS "Is viso"
FROM Stud.Autorius AS A,
	  Stud.Egzempliorius AS B	
WHERE A.isbn = B.isbn		  

SELECT A.vardas AS "Knyg. aut. var.",
		 A.pavarde AS "Knyg. aut. pav.",
		 B.isbn
FROM Stud.Autorius AS A,
	  Stud.Knyga AS B
WHERE A.isbn = B.isbn;

-- Skaitytojai ir kurias knygas pasieme		
SELECT DISTINCT A.vardas AS "Knyg. aut. var.",
					 A.pavarde AS "Knyg. aut. pav.",
					 B.isbn,
					 B.pavadinimas
FROM Stud.Autorius AS A,
	  Stud.Knyga AS B,
	  Stud.Egzempliorius AS C
WHERE A.isbn = B.isbn AND
		C.isbn = B.isbn;
		
-- Blogai, kai prijungiamas C.nr, nes gali buti keli bendraautoriai
SELECT DISTINCT A.vardas AS "Knyg. aut. var.",
		 			 A.pavarde AS "Knyg. aut. pav.",
		 			 B.pavadinimas,
		 			 C.nr
FROM Stud.Autorius AS A,
	  Stud.Knyga AS B,
	  Stud.Egzempliorius AS C
WHERE A.isbn = B.isbn AND 
		B.isbn = C.isbn AND
		C.skaitytojas IS NOT NULL;

SELECT A.pavadinimas,
		 B.metai,
		 A.isbn
FROM Stud.Knyga A,
	  Stud.Knyga B
WHERE A.isbn = B.isbn

SELECT A.nr,
		 vardas,
		 pavarde,
		 isbn
FROM Stud.Skaitytojas AS A
JOIN Stud.Egzempliorius AS B ON B.skaitytojas = A.nr;

SELECT isbn,
		 B.vardas,
		 B.pavarde
FROM Stud.Autorius AS A
JOIN Stud.Skaitytojas AS B ON A.vardas = B.vardas AND
	  A.pavarde = B.pavarde;

SELECT A.isbn,
		 vardas,
		 pavarde,
		 metai
FROM Stud.Autorius AS A
RIGHT JOIN Stud.knyga AS B ON A.isbn = B.isbn
WHERE metai < 2010;

SELECT A.nr,
		 vardas,
		 pavarde,
		 isbn
FROM Stud.Skaitytojas AS A
LEFT OUTER JOIN Stud.Egzempliorius AS B ON B.skaitytojas = A.nr;

--Blogai
SELECT A.nr,
		 vardas,
		 pavarde,
		 isbn
FROM Stud.Skaitytojas AS A
RIGHT JOIN Stud.Egzempliorius AS B ON B.skaitytojas = A.nr;

SELECT DISTINCT A.isbn,
					 A.vardas,
					 A.pavarde,
		 			 B.pavadinimas
FROM Stud.Autorius AS A
JOIN Stud.Knyga AS B ON A.isbn = B.isbn;

SELECT DISTINCT A.isbn,
		 A.vardas,
		 A.pavarde,
		 B.pavadinimas
FROM Stud.Autorius AS A
RIGHT JOIN Stud.Knyga AS B ON A.isbn = B.isbn;

SELECT DISTINCT B.vardas,
		 			 B.pavarde,
		 			 B.gimimas,
		 			 C.metai,
					 C.pavadinimas AS "Skaitomos knygos pavadinimas"
FROM Stud.Egzempliorius A
JOIN Stud.Skaitytojas B ON A.skaitytojas = B.nr
FULL JOIN Stud.Knyga C ON A.isbn = C.isbn;
!!!!!!

-- Skaitytojai, kurie skaito knygas
SELECT DISTINCT B.vardas,
					 B.pavarde,
					 B.nr
FROM Stud.Skaitytojas B
JOIN Stud.Egzempliorius A ON B.nr = A.skaitytojas;

-- Skaitytojai, kurie neskaito knygu
SELECT DISTINCT B.vardas, 
                B.pavarde, 
                B.nr
FROM Stud.Skaitytojas B
LEFT JOIN Stud.Egzempliorius A ON B.nr = A.skaitytojas
WHERE A.skaitytojas IS NULL;

-- Visi pasiskolinti leidyklos 'baltoji' egzemplioriai
SELECT DISTINCT A.isbn,
		 			 B.pavadinimas,
		 			 B.leidykla
FROM Stud.Egzempliorius A
JOIN Stud.Knyga B ON A.isbn = B.isbn
WHERE A.skaitytojas IS NOT NULL AND
		LOWER(B.leidykla) = 'baltoji';
*/
--Skaitytojai, kurie gyvena toje pacioje gatveje
SELECT A.vardas,
		 A.pavarde,
		 B.vardas,
		 B.pavarde,
		 A.adresas,
		 C.pavadinimas
FROM Stud.Skaitytojas A
JOIN Stud.Skaitytojas B ON A.adresas = B.adresas 
LEFT JOIN Stud.Egzempliorius D ON D.skaitytojas = A.nr
LEFT JOIN Stud.Knyga C ON D.isbn = C.isbn
WHERE A.ak < B.ak;
--ka jie skaito


SELECT DISTINCT B.vardas,
		 			 B.pavarde,
		 			 B.gimimas,
		 			 C.metai,
					 C.pavadinimas AS "Skaitomos knygos pavadinimas",
					 EXTRACT(YEAR FROM age(make_date(C.metai, 1, 1), B.gimimas)) AS "Isleista po skait. gimimo apytiskliai"
FROM Stud.Egzempliorius A
JOIN Stud.Skaitytojas B ON A.skaitytojas = B.nr
JOIN Stud.Knyga C ON A.isbn = C.isbn
WHERE A.skaitytojas IS NOT NULL;

-- Gali buti keli Autoriai!! Todel taip lengvai negalima atspausdinti ju vardo ir pavardes
SELECT DISTINCT A.skaitytojas,
		 B.vardas,
		 B.pavarde,
		 C.isbn,
		 C.pavadinimas AS "Skaitomos knygos pavadinimas",
		 D.isbn
FROM Stud.Egzempliorius A
JOIN Stud.Skaitytojas B ON A.skaitytojas = B.nr
JOIN Stud.Knyga C ON A.isbn = C.isbn
JOIN Stud.Autorius D ON C.isbn = D.isbn
WHERE A.skaitytojas IS NOT NULL;

-- skaitytojas skaitantis knyga, kurios autorius yra su bendru vardu bei pavarde
SELECT C.vardas AS "skaitytojo var.",
		 C.pavarde AS "skaitytojo pav.",
		 A.isbn AS "skaitoma knyg.",
		 D.vardas AS "aut. var.",
		 D.pavarde AS "aut. pav."
FROM Stud.Knyga A
JOIN Stud.Egzempliorius B ON A.isbn = B.isbn
JOIN Stud.Skaitytojas C ON B.skaitytojas = C.nr
JOIN Stud.Autorius D ON A.isbn = D.isbn AND D.vardas = C.vardas AND D.pavarde = C.pavarde
WHERE B.skaitytojas IS NOT NULL;
*/

-- Egzemplioriai, kuriu niekas neskaito
SELECT  B.vardas,
		 			 B.pavarde,
		 			 B.gimimas,
		 			 C.metai,
					 C.pavadinimas AS "Skaitomos knygos pavadinimas"
FROM Stud.Egzempliorius A
LEFT JOIN Stud.Skaitytojas B ON A.skaitytojas = B.nr
JOIN Stud.Knyga C ON A.isbn = C.isbn
WHERE B.vardas IS NULL;




-- 2 UZD
SELECT DISTINCT A.nr, 
		 			 A.vardas, 
		 			 A.pavarde 
FROM stud.Skaitytojas A
JOIN stud.Egzempliorius B ON A.nr = B.skaitytojas
WHERE paimta = DATE '2024-09-14';


SELECT nr, 
		 vardas, 
		 pavarde 
FROM stud.skaitytojas 
WHERE nr IN 
	(SELECT skaitytojas 
	 FROM stud.egzempliorius 
	 WHERE paimta = DATE '2024-09-12')

SELECT nr, 
		 vardas, 
		 pavarde 
FROM stud.skaitytojas 
WHERE nr IN 
	(SELECT DISTINCT skaitytojas 
	 FROM stud.egzempliorius 
	 WHERE paimta = DATE '2024-09-12')
