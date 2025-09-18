WITH data_clean AS ( 
SELECT 
	*,
	(pa."HP" + pa."Attack" + pa."Defense" + pa."SpAtk" + pa."SpDef" + pa."Speed" ) AS total_stats
FROM pokemon_analysis pa
),
combine_types AS (
SELECT
	"Type1" AS pokemon_type,
	total_stats
FROM data_clean
UNION ALL
SELECT 
	"Type2" AS pokemon_type,
	total_stats
FROM data_clean
WHERE "Type2" IS NOT NULL
),
avg_stats AS (
SELECT pokemon_type,
	ROUND(AVG(total_stats),2) AS avg_stats
FROM combine_types
GROUP BY
	pokemon_type
ORDER BY
	avg_stats DESC
)

SELECT 
	*
FROM avg_stats