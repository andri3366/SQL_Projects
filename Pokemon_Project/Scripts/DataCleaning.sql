CREATE VIEW pokemon_analysis AS
WITH data_clean AS ( 
SELECT 
	*,
	CASE
		WHEN p."Name" LIKE '%Mega%' THEN substring(p."Name" FROM POSITION('Mega ' IN p."Name"))
		WHEN p."Name" LIKE '%Hoopa%' THEN regexp_replace(p."Name", 'Hoopa', '', 1, 1)
		WHEN p."Name" LIKE 'Kyogre%' AND length(p."Name") > length('Kyogre') THEN regexp_replace(p."Name", 'Kyogre', '', 1, 1)
		WHEN p."Name" LIKE 'Groudon%' AND length(p."Name") > length('Groudon') THEN regexp_replace(p."Name", 'Groudon', '', 1, 1)
		WHEN p."Name" LIKE 'Kyurem%' AND length(p."Name") > length('Kyurem') THEN regexp_replace(p."Name", 'Kyurem', '', 1, 1)
		WHEN p."Name" ~ '[a-z][A-Z]' THEN regexp_replace(p."Name", '([a-z])([A-Z])', '\1 \2', 'g')
		WHEN p."Name" ~ '[0-9]' THEN regexp_replace(p."Name", '([a-z])([0-9])', '\1 \2', 'g')
		ELSE p."Name"
	END AS nameChange
FROM pokemondb p 
)
SELECT
	*
FROM data_clean