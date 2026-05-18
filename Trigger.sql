-- Primeiro, apagamos a trigger antiga para não dar conflito
DROP TRIGGER IF EXISTS trg_alerta_estoque_produto;

DELIMITER //

CREATE TRIGGER trg_gerencia_estoque_completo
BEFORE INSERT ON movimentacoes
FOR EACH ROW
BEGIN
    DECLARE var_qtd_atual INT;
    DECLARE var_capacidade INT;
    DECLARE var_limite_alerta INT;
    DECLARE var_nova_qtd INT;

    -- Busca os dados atuais do produto
    SELECT quantidade_atual, capacidade_maxima INTO var_qtd_atual, var_capacidade 
    FROM produtos WHERE id = NEW.produto_id;

    -- ==========================================
    -- REGRA PARA ENTRADAS DE MERCADORIA
    -- ==========================================
    IF NEW.tipo = 'ENTRADA' THEN
        SET var_nova_qtd = var_qtd_atual + NEW.quantidade;
        
        -- Aplica a Análise de Valor Limite (Fronteira Superior)
        IF var_nova_qtd > var_capacidade THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Operação cancelada: A entrada informada ultrapassa a capacidade máxima deste produto no estoque.';
        ELSE
            -- Se estiver tudo certo, atualiza a quantidade
            UPDATE produtos SET quantidade_atual = var_nova_qtd WHERE id = NEW.produto_id;
        END IF;
        
    -- ==========================================
    -- REGRA PARA SAÍDAS DE MERCADORIA (VENDAS)
    -- ==========================================
    ELSEIF NEW.tipo = 'SAIDA' THEN
        
        -- Impede que o estoque fique negativo
        IF NEW.quantidade > var_qtd_atual THEN
             SIGNAL SQLSTATE '45000' 
             SET MESSAGE_TEXT = 'Operação cancelada: Estoque insuficiente para realizar esta saída.';
        ELSE
             SET var_nova_qtd = var_qtd_atual - NEW.quantidade;
             UPDATE produtos SET quantidade_atual = var_nova_qtd WHERE id = NEW.produto_id;
             
             -- Verifica a regra dos 10% (Fronteira Inferior)
             SET var_limite_alerta = var_capacidade * 0.10;
             IF var_nova_qtd <= var_limite_alerta THEN
                 IF NOT EXISTS (SELECT 1 FROM alertas_estoque WHERE produto_id = NEW.produto_id AND status = 'PENDENTE') THEN
                     INSERT INTO alertas_estoque (produto_id, mensagem)
                     VALUES (NEW.produto_id, CONCAT('ATENÇÃO: Produto atingiu nível crítico. Restam apenas ', var_nova_qtd, ' unidades.'));
                 END IF;
             END IF;
        END IF;
    END IF;

END //

DELIMITER ;