
SELECT *
FROM information_schema.Columns;

SELECT Column_name
FROM information_schema.Columns
WHERE Table_schema = 'information_schema' AND 
		Table_name = 'tables';
		
SELECT Table_name
FROM information_schema.Tables
WHERE Table_schema = 'information_schema'
ORDER BY 1;

SELECT table_schema, table_name 
FROM information_schema.Tables
ORDER BY 1, 2;

SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'stud'



-- Visos stud lenteles
SELECT table_name AS "visos Stud lenteles"
FROM information_schema.tables
WHERE table_schema = 'stud';

-- Visos BASE lenteles
SELECT table_name AS "visos Stud lenteles"
FROM information_schema.tables
WHERE table_type = 'BASE TABLE';


-- Visi lenteliu stulpeliai
SELECT table_name AS "Lenteles pavadinimas",
		 column_name AS "stulpeliu pavadinimai"
FROM information_schema.columns
WHERE table_schema = 'stud'
ORDER BY 1;


-- stud lenteliu stulpeliu skaicius
SELECT table_name AS "Lenteles pavadinimas",
		 COUNT(*) AS "Stulpeliu skaicius"
FROM information_schema.columns
WHERE table_schema = 'stud'
GROUP BY table_name, table_schema, table_catalog;

-- BASE lenteliu stulpeliu skaicius
SELECT A.table_name AS "Lenteles pavadinimas",
		 COUNT(*) AS "Stulpeliu skaicius"
FROM information_schema.columns A
JOIN information_schema.tables B ON A.table_schema = B.table_schema AND
												A.table_name = B.table_name
WHERE B.table_type = 'BASE TABLE'
GROUP BY A.table_name, A.table_schema, A.table_catalog;


-- Stud lentele su daugiausiai stulpeliu
WITH 
	lentele AS (SELECT table_name AS "Lenteles pavadinimas",
		 					 COUNT(*) AS sk
					FROM information_schema.columns
					WHERE table_schema = 'stud'
					GROUP BY table_name, table_catalog, table_schema)
SELECT *
FROM lentele A
WHERE A.sk = (SELECT MAX(sk)
				  FROM lentele);
				  

-- BASE lentele su daugiausiai stulpeliu
WITH 
	lentele AS (SELECT A.table_name AS "Lenteles pavadinimas",
					COUNT(*) AS sk
					FROM information_schema.columns A
					JOIN information_schema.tables B ON A.table_schema = B.table_schema AND
									 								A.table_name = B.table_name
					WHERE B.table_type = 'BASE TABLE'
					GROUP BY A.table_name, A.table_schema, A.table_catalog)
SELECT *
FROM lentele
WHERE sk = (SELECT MAX(sk)
				  FROM lentele);
			  



-- Lenteliu stulpeliu tipas
SELECT table_name AS "Lenteles pavadinimas",
		 column_name AS "egzemplioriaus stulpeliai",
		 data_type AS "Lauko tipas"
FROM information_schema.columns
WHERE table_schema = 'stud'
ORDER BY 1;


-- Stud lenteliu vidiniai raktai
SELECT table_name AS "lenteles pavadinimas",
		 column_name AS "stulpelio vidinio rakto pavadimimas",
		 ordinal_position AS "vidinio rakto pozicija"
FROM information_schema.key_column_usage
WHERE table_schema = 'stud' AND
		position_in_unique_constraint IS NULL;


-- Stud lenteliu isoriniai raktai
SELECT table_name AS "lenteles pavadinimas",
		 column_name AS "stulpelio isorinio rakto pavadimimas",
		 position_in_unique_constraint AS "isorinio rakto pozicija"
FROM information_schema.key_column_usage
WHERE table_schema = 'stud' AND
		position_in_unique_constraint IS NOT NULL;


-- teises
SELECT grantee,
		 table_name,
		 column_name,
		 privilege_type,
		 is_grantable		 
FROM information_schema.role_column_grants
WHERE table_schema = 'stud'
ORDER BY 2;



-- Visos stud lenteles, neturincios ne vieno isorinio rakto
WITH lenteles AS (SELECT table_name,
								 SUM(COALESCE(position_in_unique_constraint, 0)) as isRaktuSk
						FROM information_schema.key_column_usage
						WHERE table_schema = 'stud' 
						GROUP BY table_name, table_catalog, table_schema)
SELECT table_name AS "lenteles pavadinimas",
		 isRaktuSk
FROM lenteles 
WHERE isRaktuSk = 0;

-- Visos BASE lenteles, neturincios ne vieno isorinio rakto
WITH lenteles AS (SELECT A.table_name,
								 SUM(COALESCE(A.position_in_unique_constraint, 0)) as isRaktuSk
						FROM information_schema.key_column_usage A
						JOIN information_schema.tables B ON A.table_name = B.table_name AND
																		A.table_schema = B.table_schema
						WHERE B.table_type = 'BASE TABLE' 
						GROUP BY A.table_name, A.table_catalog, A.table_schema)
SELECT DISTINCT table_name AS "lenteles pavadinimas",
		 isRaktuSk
FROM lenteles 
WHERE isRaktuSk = 0;


-- Stud Lenteles turincios daugiausiai skirtingu duomenu tipu
WITH 
	pavTipuSk AS (SELECT table_name,
		 						COUNT (DISTINCT data_type) AS sk
					  FROM information_schema.columns
					  WHERE table_schema = 'stud'
					  GROUP BY table_name, table_catalog, table_schema)
SELECT table_name AS "Lenteles pavadinimas",
		 sk AS "skirtingu duomenu tipu sk"
FROM pavTipuSk	
WHERE sk IN (SELECT MAX(sk)
				 FROM pavTipuSk);
	 
		
-- BASE Lenteles turincios daugiausiai skirtingu duomenu tipu		 
WITH 
	pavTipuSk AS (SELECT A.table_name,
		 						COUNT (DISTINCT A.data_type) AS sk
					  FROM information_schema.columns A
					  JOIN information_schema.tables B ON A.table_catalog = B.table_catalog AND
					  												  A.table_schema = B.table_schema
					  WHERE B.table_type = 'BASE TABLE'
					  GROUP BY A.table_name, A.table_catalog, A.table_schema)
SELECT table_name AS "Lenteles pavadinimas",
		 sk AS "skirtingu duomenu tipu sk"
FROM pavTipuSk	
WHERE sk IN (SELECT MAX(sk)
				 FROM pavTipuSk);
				 
	
		 
				 
-- Lenteles, kuriu pavadinimai kartojasi 6 kartus
SELECT A.table_name,
		 COUNT(*)
FROM information_schema.Tables AS A
GROUP BY A.table_name
HAVING COUNT(*) = 6;


-- stud leneteles ir is_nullable
SELECT table_name,
		 column_name,
		 is_nullable 
FROM information_schema.columns
WHERE table_schema = 'stud'
ORDER BY 1;

-- Stud lenteles, kur visi laukai yra privalomi
SELECT A.table_schema,
		 A.table_name
FROM information_schema.tables AS A
WHERE table_schema = 'stud' AND
		NOT EXISTS (SELECT B.is_nullable
					 	FROM information_schema.Columns AS B
					 	WHERE A.table_schema = B.table_schema AND
					 			A.table_name = B.table_name AND
					 			B.is_nullable = 'YES'
						);

