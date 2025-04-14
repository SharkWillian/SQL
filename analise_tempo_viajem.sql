-- Este código realiza uma série de operações para transformar e analisar dados de uma tabela de controle dos Pagamentos X Tempo de frete

SELECT
    (CASE
        WHEN (`x`.`RAZAO_SOCIAL` IN ('Empresa A', 'Empresa B', 'Empresa C', 'Empresa D', 'Empresa E', 'Empresa F', 'Empresa G', 'Empresa H', 'Empresa I', 'Empresa J', 'Empresa K', 'Empresa L', 'Empresa M', 'Empresa N', 'Empresa O', 'Empresa P', 'Empresa Q', 'Empresa R', 'Empresa S', 'Empresa T', 'Empresa U', 'Empresa V', 'Empresa W', 'Empresa X', 'Empresa Y', 'Empresa Z')) THEN 'Grupo A'
        WHEN (`x`.`RAZAO_SOCIAL` IN ('Empresa AA', 'Empresa BB')) THEN 'Grupo B'
        WHEN (`x`.`RAZAO_SOCIAL` = 'Empresa CC') THEN 'Grupo C'
        WHEN (`x`.`RAZAO_SOCIAL` IN ('Empresa DD', 'Empresa EE')) THEN 'Grupo D'
        ELSE `x`.`RAZAO_SOCIAL`
    END) AS `RAZAO_SOCIAL`,
    `x`.`MOTORISTA` AS `MOTORISTA`,
    `x`.`COD_VIAJEM` AS `COD_VIAJEM`,
    `x`.`DATA_ADIANTAMENTO` AS `DATA_ADIANTAMENTO`,
    (CASE
        WHEN (`x`.`TIPO_PAGAMENTO` = '0 - Adiantamento') THEN 'ADIANTAMENTO'
        WHEN (`x`.`TIPO_PAGAMENTO` = '1 - Saldo') THEN 'SALDO'
        ELSE `x`.`TIPO_PAGAMENTO`
    END) AS `TIPO_PAGAMENTO`,
    `x`.`DATA_SALDO` AS `DATA_SALDO`,
    `x`.`TIPO_SALDO` AS `TIPO_SALDO`,
    (CASE
        WHEN (`x`.`DIAS_AS` = 0) THEN 1
        ELSE `x`.`DIAS_AS`
    END) AS `DIAS_AS`,
    `x`.`VALOR_ADIANTAMENTO` AS `VALOR_ADIANTAMENTO`,
    `x`.`VALOR_SALDO` AS `VALOR_SALDO`,
    `x`.`VALOR_TOTAL` AS `VALOR_TOTAL`
FROM
    (
    SELECT
        `v1`.`Razão Social` AS `RAZAO_SOCIAL`,
        `v1`.`CPF/CNPJ Motorista` AS `MOTORISTA`,
        `v1`.`Código Viagem` AS `COD_VIAJEM`,
        `v1`.`Data Alteração` AS `DATA_ADIANTAMENTO`,
        `v1`.`Tipo` AS `TIPO_PAGAMENTO`,
        `v2`.`Data Alteração` AS `DATA_SALDO`,
        `v2`.`Tipo` AS `TIPO_SALDO`,
        TIMESTAMPDIFF(DAY,
        `v1`.`Data Alteração`,
        `v2`.`Data Alteração`) AS `DIAS_AS`,
        `v1`.`Valor` AS `VALOR_ADIANTAMENTO`,
        `v1`.`Forma Pagamento` AS `FORMA_PAG_ADIANTAMENTO`,
        `v2`.`Valor` AS `VALOR_SALDO`,
        `v2`.`Forma Pagamento` AS `FORMA_PAG_SALDO`,
        (`v1`.`Valor` + `v2`.`Valor`) AS `VALOR_TOTAL`
    FROM
        (`TABELA_B` `v1`
    JOIN `TABELA_B` `v2` ON
        (((`v1`.`Código Viagem` = `v2`.`Código Viagem`)
            AND (`v1`.`Tipo` = '0 - Adiantamento')
                AND (`v2`.`Tipo` = '1 - Saldo')
                    AND (`v1`.`Data Alteração` < `v2`.`Data Alteração`))))
UNION ALL
    SELECT
        'Grupo D' AS `RAZAO_SOCIAL`,
        `v3`.`CPF_CNPJ_PROP` AS `MOTORISTA`,
        `v3`.`CODIGO_OPERACAO` AS `COD_VIAJEM`,
        `v3`.`DATA_MOVIMENTO` AS `DATA_ADIANTAMENTO`,
        `v3`.`TIPO_EVENTO` AS `TIPO_PAGAMENTO`,
        `v4`.`DATA_MOVIMENTO` AS `DATA_SALDO`,
        `v4`.`TIPO_EVENTO` AS `TIPO_SALDO`,
        TIMESTAMPDIFF(DAY,
        `v3`.`DATA_MOVIMENTO`,
        `v4`.`DATA_MOVIMENTO`) AS `DIAS_AS`,
        `v3`.`VALOR_BAIXA` AS `VALOR_ADIANTAMENTO`,
        'Conta Grupo D' AS `FORMA_PAG_ADIANTAMENTO`,
        `v4`.`VALOR_BAIXA` AS `VALOR_SALDO`,
        'Conta Grupo D' AS `FORMA_PAG_SALDO`,
        (`v3`.`VALOR_BAIXA` + `v4`.`VALOR_BAIXA`) AS `VALOR_TOTAL`
    FROM
        (`TABELA_A` `v3`
    JOIN `TABELA_A` `v4` ON
        (((`v3`.`CODIGO_OPERACAO` = `v4`.`CODIGO_OPERACAO`)
            AND (`v3`.`TIPO_EVENTO` = 'ADIANTAMENTO')
                AND (`v4`.`TIPO_EVENTO` = 'SALDO')
                    AND (`v3`.`DATA_MOVIMENTO` < `v4`.`DATA_MOVIMENTO`))))) `x`
ORDER BY
    `x`.`MOTORISTA`,
    `x`.`COD_VIAJEM`;
