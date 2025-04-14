-- O objetivo do OVER PARTITION é ordenar os registros de uma tabela e selecionar apenas o primeiro ou o último de acordo com a categoria definida. Esta técnica é extremamente útil para realizar cálculos agregados sobre subconjuntos de dados, sem precisar agrupar os resultados.

WITH CTE_RANKING AS (
    SELECT
        A.*,
        ROW_NUMBER() OVER (PARTITION BY CÓDIGO ORDER BY DATA_REF DESC) AS RANKING
    FROM TABELA A
)
SELECT *
FROM CTE_RANKING 
WHERE RANKING = 1;
