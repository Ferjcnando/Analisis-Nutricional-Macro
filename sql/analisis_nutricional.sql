-- 1. Cantidad de alimentos por categoría

SELECT 
  categoria, 
  COUNT(*) AS cantidad_alimentos 
FROM `omega-ability-454915-n9.alimentos_guia.alimentos_info` 
GROUP BY categoria 
ORDER BY cantidad_alimentos DESC;

-- 2. Promedio nutricional por categoría

SELECT
  categoria,
  ROUND(AVG(calorias_100g), 2) AS calorias_promedio,
  ROUND(AVG(proteina_100g), 2) AS proteina_promedio,
  ROUND(AVG(carbohidratos_100g), 2) AS carbohidratos_promedio,
  ROUND(AVG(grasas_100g), 2) AS grasas_promedio
FROM `omega-ability-454915-n9.alimentos_guia.alimentos_info`
GROUP BY categoria
ORDER BY calorias_promedio DESC;

-- 3. Top 5 alimentos más calóricos por categoría

WITH alimentos_rankeados AS (
  SELECT 
    categoria, 
    nombre_alimento, 
    calorias_100g, 
    ROW_NUMBER() OVER (
      PARTITION BY categoria 
      ORDER BY calorias_100g DESC 
    ) AS ranking 
  FROM `omega-ability-454915-n9.alimentos_guia.alimentos_info` 
  WHERE calorias_100g IS NOT NULL 
) 
 
SELECT 
  categoria, 
  ranking, 
  nombre_alimento, 
  calorias_100g 
FROM alimentos_rankeados 
WHERE ranking <= 5 
ORDER BY categoria, ranking;


-- 4. Alimentos con mayor contenido calórico

SELECT 
  nombre_alimento, 
  categoria, 
  calorias_100g, 
  proteina_100g, 
  carbohidratos_100g, 
  grasas_100g 
FROM `omega-ability-454915-n9.alimentos_guia.alimentos_info` 
WHERE calorias_100g IS NOT NULL 
ORDER BY calorias_100g DESC 
LIMIT 20;
