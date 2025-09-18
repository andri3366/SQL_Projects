# Pokemon SQL Analysis

## Overview
This project explores the Pokemon pokedex using advanced SQL techniques. The dataset was retrieved on [Kaggle](https://www.kaggle.com/datasets/mlomuscio/pokemon?select=PokemonData.csv) with the goal of analyzing different aspects of the pokedex. 

## 📈 The Dataset 
The dataset contains the following columns:
- Num
- Name
- Type1
- Type2
- HP
- Atack
- Defense
- SPAtk
- SPDef
- Speed
- Generation
- Legendary

## 🔧 Tools 
- pgAdmin 4
- DBeaver
- VS code
- GitHub

## 🧼 Data Cleaning
- **Purpose:** When analyzing the original dataset it was evident there were issues regarding the naming convention for each pokemon. Pokemon who had mega evolution had repetitions in their name:

    | Name | Name Change | 
    | :------- | :------: | 
    | CharizardMega Charizard | Mega Charizard | 
    | HoopaHoopa Confined  | Hoopa Confined  | 
    | MeowsticMale  | Meowstic Male  | 
- The table above list some instances were the naming convention is incorrect. 
- Upon observation there several issues with the naming convention involved mega evolutions and non-/legendary pokemon with different forms. 
- To resolve the issue I created a view that could be used in the beginning of each analysis.
- Using a CASE statement, pokemon with 'Mega' in the name used a substring() function to remove the base name. Where as regex_replace() was used as the exact position of the second word was never the same. regex_replace() was additionally used to add spaces when a capital letter would appear in the same string when there was no space.
```
WHEN p."Name" LIKE '%Mega%' THEN substring(p."Name" FROM POSITION('Mega ' IN p."Name"))

WHEN p."Name" LIKE 'Kyogre%' AND length(p."Name") > length('Kyogre') THEN regexp_replace(p."Name", 'Kyogre', '', 1, 1)

WHEN p."Name" ~ '[a-z][A-Z]' THEN regexp_replace(p."Name", '([a-z])([A-Z])', '\1 \2', 'g')
```
## 📊 Analysis
1. What is the Highest Stat per Generation?
- **Purpose:** Determine the top 6 Pokemon per generation, excluding legendary and mega evolution pokemon, to determine the strongest team from total stats.
- 