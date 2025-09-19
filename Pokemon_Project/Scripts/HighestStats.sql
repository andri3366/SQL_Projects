WITH top_pokemon AS (
SELECT 
	pa."Index",
	nameChange,
	SUM(pa."HP" + pa."Attack" + pa."Defense" + pa."SpAtk" + pa."SpDef" + pa."Speed" ) AS total_stats,
	pa."Generation"
FROM pokemon_analysis pa
WHERE
	pa.legendary_fixed IS NOT TRUE
	AND pa.mythical IS NOT TRUE
	AND pa."Name" NOT LIKE '%Mega%'
GROUP BY
	pa."Index",
	nameChange,
	pa."Generation"
ORDER BY
	total_stats DESC
),

ranked_pokemon AS (
SELECT
	*,
	DENSE_RANK() OVER (PARTITION BY "Generation" ORDER BY total_stats DESC) AS dense_gen_rank
FROM top_pokemon 
)
SELECT
	*
FROM ranked_pokemon
WHERE dense_gen_rank <= 6 
	--AND "Generation" = 3
ORDER BY
	"Generation",
	dense_gen_rank
--LIMIT 6;