WITH mega_evol AS (
SELECT
	base."Index"        	AS base_index,
    base.nameChange     	AS base_name,
    mega.nameChange     	AS mega_name,
    base.legendary_fixed	AS legendary,
    (base."HP" + base."Attack" + base."Defense" + base."SpAtk" + base."SpDef" + base."Speed") AS base_stat,
    (mega."HP" + mega."Attack" + mega."Defense" + mega."SpAtk" + mega."SpDef" + mega."Speed") AS mega_stat,
    (mega."HP" - base."HP") AS hp_gain,
    (mega."Attack" - base."Attack") AS attack_gain,
    (mega."Defense" - base."Defense") AS defense_gain,
    (mega."SpAtk" - base."SpAtk") AS spatk_gain,
    (mega."SpDef" - base."SpDef") AS spdef_gain,
    (mega."Speed" - base."Speed") AS speed_gain,
    CASE
    	WHEN (mega."HP" - base."HP") = GREATEST(
    		(mega."HP" - base."HP"),
    		(mega."Attack" - base."Attack"),
    		(mega."Defense" - base."Defense"),
    		(mega."SpAtk" - base."SpAtk"),
   			(mega."SpDef" - base."SpDef"),
    		(mega."Speed" - base."Speed") 
    	) THEN 'HP'
    	WHEN (mega."Attack" - base."Attack") = GREATEST(
    		(mega."HP" - base."HP"),
    		(mega."Attack" - base."Attack"),
    		(mega."Defense" - base."Defense"),
    		(mega."SpAtk" - base."SpAtk"),
   			(mega."SpDef" - base."SpDef"),
    		(mega."Speed" - base."Speed") 
    	) THEN 'Attack'
    	WHEN (mega."Defense" - base."Defense") = GREATEST(
    		(mega."HP" - base."HP"),
    		(mega."Attack" - base."Attack"),
    		(mega."Defense" - base."Defense"),
    		(mega."SpAtk" - base."SpAtk"),
   			(mega."SpDef" - base."SpDef"),
    		(mega."Speed" - base."Speed") 
    	) THEN 'Defense'
    	WHEN (mega."SpAtk" - base."SpAtk") = GREATEST(
    		(mega."HP" - base."HP"),
    		(mega."Attack" - base."Attack"),
    		(mega."Defense" - base."Defense"),
    		(mega."SpAtk" - base."SpAtk"),
   			(mega."SpDef" - base."SpDef"),
    		(mega."Speed" - base."Speed") 
    	) THEN 'SpAtk'
    	WHEN (mega."SpDef" - base."SpDef") = GREATEST(
    		(mega."HP" - base."HP"),
    		(mega."Attack" - base."Attack"),
    		(mega."Defense" - base."Defense"),
    		(mega."SpAtk" - base."SpAtk"),
   			(mega."SpDef" - base."SpDef"),
    		(mega."Speed" - base."Speed") 
    	) THEN 'SpDef'
    	ELSE 'Speed'
    END AS biggest_gain,
    GREATEST(
    		(mega."HP" - base."HP"),
    		(mega."Attack" - base."Attack"),
    		(mega."Defense" - base."Defense"),
    		(mega."SpAtk" - base."SpAtk"),
   			(mega."SpDef" - base."SpDef"),
    		(mega."Speed" - base."Speed")
    ) AS biggest_gain_value
    
FROM pokemon_analysis base
--JOIN pokemon_analysis mega ON mega.nameChange LIKE 'Mega ' || base.nameChange || '%'
JOIN pokemon_analysis mega 
      ON SPLIT_PART(mega.nameChange, ' ', 2) = base.nameChange
         OR SPLIT_PART(mega.nameChange, ' ', 2) || ' ' || SPLIT_PART(mega.nameChange, ' ', 3) = base.nameChange
WHERE base.nameChange NOT LIKE 'Mega%'
	AND mega.nameChange LIKE 'Mega%'
),
stronger_mega AS (
SELECT DISTINCT ON (base_name)
	base_name,
    mega_name,
    legendary,
    base_stat,
    mega_stat,
	(mega_stat - base_stat) AS stat_remainder,
	ROUND(((mega_stat - base_stat) * 100 / base_stat), 2) AS pct_increase,
	biggest_gain,
    biggest_gain_value
FROM mega_evol
ORDER BY base_name, stat_remainder DESC
)
SELECT 
	*
FROM stronger_mega
ORDER BY mega_stat DESC, base_stat, pct_increase

