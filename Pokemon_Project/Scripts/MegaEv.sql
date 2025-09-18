WITH mega_evol AS (
SELECT
	base."Index"        AS base_index,
    base.nameChange     AS base_name,
    mega.nameChange     AS mega_name,
    base."Legendary"	AS legendary,
    (base."HP" + base."Attack" + base."Defense" + base."SpAtk" + base."SpDef" + base."Speed") AS base_stat,
    (mega."HP" + mega."Attack" + mega."Defense" + mega."SpAtk" + mega."SpDef" + mega."Speed") AS mega_stat
FROM pokemon_analysis base
--JOIN pokemon_analysis mega ON mega.nameChange LIKE 'Mega ' || base.nameChange || '%'
JOIN pokemon_analysis mega 
      ON SPLIT_PART(mega.nameChange, ' ', 2) = base.nameChange
         OR SPLIT_PART(mega.nameChange, ' ', 2) || ' ' || SPLIT_PART(mega.nameChange, ' ', 3) = base.nameChange
WHERE base.nameChange NOT LIKE 'Mega%'
),
stronger_mega AS (
SELECT DISTINCT ON (base_name)
	base_name,
    mega_name,
    legendary,
    base_stat,
    mega_stat,
	(mega_stat - base_stat) AS stat_remainder
FROM mega_evol
ORDER BY base_name, stat_remainder DESC
)
SELECT 
	*
FROM stronger_mega
ORDER BY mega_stat DESC, base_stat

