-- Essa query tem como objetivo trazer contratos com vencimentos em 5, 4 e 0 dias, de forma que possamos notificar os clientes quanto ao pagamento.

SELECT
    cod_contrato,
    cod_parcela,
    data_vencimento,
    data_pagamento,
    email_cliente,
    telefone_cliente,
    CASE
        WHEN data_vencimento = CURDATE() THEN 0
        WHEN data_vencimento = DATE_ADD(CURDATE(), INTERVAL 3 DAY) THEN 3
        WHEN data_vencimento = DATE_ADD(CURDATE(), INTERVAL 5 DAY) THEN 5
    END AS dias_vencimento
FROM tb_recebimento_auto_funcao_corrigido trafc
WHERE
    data_vencimento IN (CURDATE(), 
                        DATE_ADD(CURDATE(), INTERVAL 3 DAY),
                        DATE_ADD(CURDATE(), INTERVAL 5 DAY))
    AND data_pagamento IS NULL;
