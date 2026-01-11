SELECT *
FROM stud.skaitytojas;

SELECT nr,
       vardas,
       pavarde,
       gimimas
FROM stud.skaitytojas;

SELECT pavadinimas,
       isbn,
       leidykla
FROM Stud.Knyga
WHERE LOWER(leidykla) = 'raudonoji'

SELECT Stud.Autorius.isbn,
       Stud.Autorius.pavarde
FROM Stud.Autorius WHERE LOWER(Stud.Autorius.vardas) = 'jonas'

SELECT A.isbn,
       A.pavarde
FROM Stud.Autorius AS A WHERE LOWER(A.vardas) = 'jonas'

SELECT DISTINCT vardas,
                pavarde
FROM Stud.autorius

SELECT DISTINCT isbn
FROM Stud.Egzempliorius

SELECT vardas,
       pavarde,
       nr*20 AS "nr*20"
FROM Stud.Skaitytojas

SELECT pavadinimas,
       COALESCE(verte, 0)/puslapiai AS "Puslapio kaina"
FROM Stud.Knyga

SELECT pavadinimas,
       '1 puslapio kaina:' AS Pastaba,
       COALESCE(verte, 0)/puslapiai AS "Puslapio kaina"
FROM Stud.Knyga

SELECT pavadinimas,
       '1 puslapio kaina:' AS Pastaba,
       COALESCE(verte, 0)/puslapiai AS "Puslapio kaina",
       'eur' AS Valiuta,
       leidykla
FROM Stud.Knyga

SELECT vardas,
       pavarde,
       CURRENT_DATE - gimimas AS "Pries kiek dienu gime",
       'd' AS vnt
FROM Stud.Skaitytojas

SELECT vardas,
       pavarde,
       (CURRENT_DATE - gimimas)/365 AS "Pries kiek metu gime",
       'm' AS vnt
FROM Stud.Skaitytojas

SELECT 'test' AS pasibandymas
FROM Stud.Skaitytojas

SELECT DISTINCT 'test' AS pasibandymas
FROM Stud.Skaitytojas

SELECT *
FROM Stud.Autorius

SELECT Stud.Autorius.*
FROM Stud.Autorius

SELECT A.*
FROM Stud.Autorius A

SELECT A.*
FROM Stud.Autorius AS A

SELECT nr,
       vardas,
       pavarde
FROM Stud.Skaitytojas
ORDER BY nr

SELECT nr,
       vardas,
       pavarde
FROM Stud.Skaitytojas
ORDER BY nr DESC

SELECT nr,
       vardas,
       pavarde
FROM Stud.Skaitytojas
ORDER BY vardas DESC

SELECT nr,
       vardas,
       pavarde,
       ak
FROM Stud.Skaitytojas
ORDER BY 4 DESC

SELECT isbn,
       pavadinimas,
       leidykla,
       metai,
       puslapiai
FROM Stud.Knyga
ORDER BY leidykla DESC,
         puslapiai

SELECT *
FROM Stud.Autorius
ORDER BY isbn DESC,
         vardas,
         pavarde DESC

SELECT *
FROM Stud.Egzempliorius
ORDER BY skaitytojas

SELECT DISTINCT USER AS "Current user"
FROM Stud.Autorius

SELECT nr,
       paimta,
       grazinti,
       CURRENT_DATE-paimta AS "jau dienu praeje",
       grazinti-CURRENT_DATE AS "dienu like"
FROM Stud.Egzempliorius

SELECT DISTINCT CURRENT_TIMESTAMP AS "Current timestamp"
FROM Stud.Autorius

SELECT CURRENT_TIMESTAMP AS "Current timestamp"
FROM Stud.Autorius

SELECT SUM(puslapiai) AS "puslapiu is viso",
       'psl' AS vnt
FROM Stud.Knyga

SELECT SUM(COALESCE(verte, 0)) AS "verte is viso",
       'eur' AS vnt
FROM Stud.Knyga

SELECT AVG(DISTINCT skaitytojas) AS "Skaitytoju nepasikartojanciu kodu vidurkis"
FROM Stud.Egzempliorius

SELECT 'Jauniausiojo gimtadienis:' AS "Pastaba",
       MAX(gimimas) AS "Gimtadienis"
FROM Stud.Skaitytojas

SELECT 'Vyriausiojo gimtadienis:' AS "Pastaba", MIN(gimimas) AS "Gimtadienis"
FROM Stud.Skaitytojas

SELECT 'Baltoji leidyklos knygu skaicius:' AS "Pastaba", 
		 COUNT(leidykla) AS "Skaiscius"
FROM Stud.Knyga
WHERE LOWER(leidykla) = 'baltoji'

SELECT COUNT(*) AS "Eiluciu skaicius"
FROM Stud.Autorius

SELECT COUNT(DISTINCT isbn) AS "Skirtingu isbn sk",
 		 COUNT(DISTINCT vardas) AS "Skirtingu vardu sk", 
 		 COUNT(DISTINCT pavarde) AS "Skirtingu vardu skaicius"
FROM Stud.Autorius

SELECT vardas, 
		 pavarde, 
		 'gime:' AS pastaba,
		 EXTRACT(YEAR FROM gimimas) AS "metai",
		 EXTRACT(MONTH FROM gimimas) AS "menesis",
	    EXTRACT(YEAR FROM gimimas) AS "diena"
FROM Stud.Skaitytojas

SELECT pavadinimas,
		 CHAR_LENGTH(pavadinimas) AS "pavadinimo ilgis"
FROM Stud.Knyga 

SELECT vardas,
		 SUBSTRING (vardas, 1, 3) AS "trumpinys"
FROM Stud.Autorius

SELECT vardas,
		 pavarde,
		 'inicialai:' AS "pastaba",
		 SUBSTRING (vardas, 1, 1) AS "vardas",
		 SUBSTRING (pavarde, 1, 1) AS "pavarde"
FROM Stud.Autorius

SELECT DISTINCT CURRENT_TIMESTAMP AS dabar,
		 CURRENT_TIMESTAMP + INTERVAL '3 SECONDS' AS "Po 3 sek"
FROM Stud.Knyga
 

SELECT DISTINCT EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS dabar,
		 EXTRACT(YEAR FROM (CURRENT_DATE - INTERVAL '5 YEARS')) AS "Pries 5 m"
FROM Stud.Knyga

SELECT 'knygos su daugiau nei 300 psl:' AS pastaba,
		 pavadinimas,
		 puslapiai
FROM Stud.Knyga
WHERE puslapiai > 300

SELECT nr, 
		 skaitytojas, 
		 grazinti
FROM Stud.Egzempliorius
WHERE EXTRACT(MONTH FROM grazinti) <> 11

SELECT pavadinimas,
		 metai, 
		 leidykla
FROM Stud.Knyga
WHERE LOWER(pavadinimas) LIKE '%sistemos%'

SELECT pavadinimas,
		 metai, 
		 leidykla,
		 COALESCE(verte, 0), 
		 puslapiai
FROM Stud.Knyga
WHERE LOWER(leidykla) IN ('baltoji' , 'raudonoji') AND
		COALESCE(verte, 0) < 30 AND
		puslapiai > 300

SELECT isbn,
		 vardas,
		 pavarde
FROM Stud.Autorius
WHERE isbn LIKE '9998________5'

SELECT isbn,
		 vardas,
		 pavarde
FROM Stud.Autorius
WHERE isbn LIKE '9998%5'

SELECT pavadinimas, 
		 leidykla,
		 COALESCE(verte, 0)
FROM Stud.Knyga


SELECT COUNT(CASE WHEN ak LIKE '6%' THEN 0 ELSE NULL END) AS "moteru sk",
		 COUNT(CASE WHEN ak LIKE '5%' THEN 0 ELSE NULL END) AS "vyru sk"
FROM Stud.Skaitytojas

SELECT isbn,
		 COALESCE(skaitytojas, 0)
FROM Stud.Egzempliorius

SELECT COUNT(CASE WHEN skaitytojas IS NULL THEN 'nezinoma' END) AS "stulpeliu su null sk"
FROM Stud.Egzempliorius


SELECT isbn, skaitytojas, paimta, grazinti
FROM Stud.Egzempliorius
WHERE skaitytojas IS NOT NULL AND
		paimta IS NOT NULL AND
		grazinti IS NOT NULL

-- UZD 1 --

SELECT nr,
       vardas,
       pavarde,
       gimimas
FROM stud.skaitytojas
WHERE gimimas < CURRENT_DATE - INTERVAL '21 YEARS';

SELECT nr,
       vardas,
       pavarde,
       gimimas
FROM stud.skaitytojas
WHERE (gimimas <= CURRENT_DATE - INTERVAL '21 YEARS')
  AND (gimimas >= CURRENT_DATE - INTERVAL '22 YEARS');

SELECT nr*2 AS "Numeris",
       vardas,
       pavarde AS "Surname",
       gimimas AS "Gimtadienis"
FROM stud.skaitytojas
WHERE (gimimas <= CURRENT_DATE - INTERVAL '21 YEARS')
  AND (gimimas >= CURRENT_DATE - INTERVAL '22 YEARS');

SELECT nr,
       vardas,
       pavarde,
       gimimas
FROM stud.skaitytojas
WHERE gimimas BETWEEN (CURRENT_DATE - INTERVAL '11 YEARS') 
	   AND (CURRENT_DATE - INTERVAL '10 YEARS');

SELECT nr,
       vardas,
       pavarde,
       EXTRACT (YEAR FROM age(gimimas))
FROM stud.skaitytojas
WHERE (EXTRACT (YEAR FROM age(gimimas))) = 20


SELECT nr,
       vardas,
       pavarde,
       gimimas
FROM stud.skaitytojas
WHERE (gimimas <= CURRENT_DATE - INTERVAL '20 YEARS')
  AND (gimimas >= CURRENT_DATE - INTERVAL '21 YEARS')
ORDER BY nr;

SELECT nr,
       vardas,
       pavarde,
       gimimas
FROM stud.skaitytojas
WHERE (gimimas <= CURRENT_DATE - INTERVAL '20 YEARS')
  AND (gimimas >= CURRENT_DATE - INTERVAL '21 YEARS')
ORDER BY nr DESC;
