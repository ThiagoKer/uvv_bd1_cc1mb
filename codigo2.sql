--Apaga o banco de dados "uvv" se ele já for existente
DROP DATABASE IF EXISTS uvv;

--Apaga o usuario "thiago" se ele já for existente
DROP USER IF EXISTS thiago;

--cria o usuario "thiago"
CREATE USER thiago with CREATEDB INHERIT login password '123';


--cria o banco de dados "uvv" 
CREATE DATABASE uvv 
	OWNER thiago
	TEMPLATE template0 
	ENCODING 'UTF8'
	LC_COLLATE 'pt_BR.UTF-8'
	LC_CTYPE 'pt_BR.UTF-8'
	ALLOW_CONNECTIONS TRUE;

--Usa o banco de dados "uvv" e o usuário "thiago" sem pedir a senha de login
\c 'dbname=uvv user=thiago password=123';



CREATE SCHEMA lojas AUTHORIZATION thiago;



SET SEARCH_PATH TO lojas, "$user", public;

ALTER USER thiago SET SEARCH_PATH TO lojas, "$user", public;


CREATE TABLE lojas (
                loja_id                                 NUMERIC(38)       NOT NULL,
                nome                                    VARCHAR(255)      NOT NULL,
                endereco_web                            VARCHAR(100),
                endereco_fisico                         VARCHAR(512),
                latitude                                NUMERIC,
                longitude                               NUMERIC,
                logo                                    BYTEA,
                logo_mime_type                          VARCHAR(512),
                logo_arquivo                            VARCHAR(512),
                logo_charset                            VARCHAR(512),
                logo_ultima_atualizacao                 DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE  lojas                                 IS      'Tabela com as informações das lojas';
COMMENT ON COLUMN lojas.loja_id                         IS      'Número de identificação das lojas';
COMMENT ON COLUMN lojas.nome                            IS      'Nome das lojas';
COMMENT ON COLUMN lojas.endereco_web                    IS      'Endereço web(site) das lojas';
COMMENT ON COLUMN lojas.endereco_fisico                 IS      'Endereço fisíco da loja';
COMMENT ON COLUMN lojas.latitude                        IS      'Distância em graus entre o local da loja até a linha do Equador';
COMMENT ON COLUMN lojas.longitude                       IS      'Distância em graus da distância da loja até o Meridiano de Greenwich';
COMMENT ON COLUMN lojas.logo                            IS      'Visual gráfico das lojas';
COMMENT ON COLUMN lojas.logo_mime_type                  IS      'Para indicar o tipo de mídia padrão usado nas logos';
COMMENT ON COLUMN lojas.logo_arquivo                    IS      'Repertório que se encontra o arquivo da logo';
COMMENT ON COLUMN lojas.logo_charset                    IS      'Indica o formato de codificação dos caracteres da logo no documento';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao         IS      'Informa a última vez que a logo da loja foi alterada';


CREATE TABLE produtos (
                produto_id                              NUMERIC(38)       NOT NULL,
                nome                                    VARCHAR(255)      NOT NULL,
                preco_unitario                          NUMERIC(10,2),
                detalhes                                BYTEA,
                imagem                                  BYTEA,
                imagem_mimi_type                        VARCHAR(512),
                imagem_arquivo                          VARCHAR(512),
                imagem_charset                          VARCHAR(512),
                imagem_ultima_atualizacao               DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE  produtos                              IS      'Tabela com as informações dos produtos';
COMMENT ON COLUMN produtos.produto_id                   IS      'Número de identificação dos produtos';
COMMENT ON COLUMN produtos.nome                         IS      'Nome dos produtos';
COMMENT ON COLUMN produtos.preco_unitario               IS      'Preço unitário de cada produto';
COMMENT ON COLUMN produtos.detalhes                     IS      'Detalhes sobre o produto';
COMMENT ON COLUMN produtos.imagem                       IS      'Imagens do produto';
COMMENT ON COLUMN produtos.imagem_mimi_type             IS      'Para indicar o tipo de mídia padrão usado nas imagens';
COMMENT ON COLUMN produtos.imagem_arquivo               IS      'Repertório que se encontra o arquivo da imagem';
COMMENT ON COLUMN produtos.imagem_charset               IS      'Indica o formato de codificação dos caracteres da imagem no documento';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao    IS      'Informa a última vez que foi alterada a imagem de algum produto';


CREATE TABLE estoques (
                estoque_id                              NUMERIC(38)       NOT NULL,
                loja_id                                 NUMERIC(38)       NOT NULL,
                produto_id                              NUMERIC(38)       NOT NULL,
                quantidade                              NUMERIC(38)       NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques                               IS      'Tabela com as informações do estoque das lojas';
COMMENT ON COLUMN estoques.estoque_id                   IS      'Número de identificação do estoque';
COMMENT ON COLUMN estoques.loja_id                      IS      'Número de identificação das lojas';
COMMENT ON COLUMN estoques.produto_id                   IS      'Número de identificação dos produtos';
COMMENT ON COLUMN estoques.quantidade                   IS      'Quantidade de produtos no estoque';


CREATE TABLE clientes (
                cliente_id                              NUMERIC(38)       NOT NULL,
                email                                   VARCHAR(255)      NOT NULL,
                nome                                    VARCHAR(255)      NOT NULL,
                telefone1                               VARCHAR(20),
                telefone2                               VARCHAR(20),
                telefone3                               VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE  clientes                              IS      'Tabela com as informações dos clientes';
COMMENT ON COLUMN clientes.cliente_id                   IS      'Número de identificação dos clientes';
COMMENT ON COLUMN clientes.email                        IS      'Email do cliente para a loja entrar em contato';
COMMENT ON COLUMN clientes.nome                         IS      'Nome do cliente';
COMMENT ON COLUMN clientes.telefone1                    IS      'Telefone do cliente para a loja entrar em contato';
COMMENT ON COLUMN clientes.telefone2                    IS      'Telefone secundário do cliente para a loja entrar em contato';
COMMENT ON COLUMN clientes.telefone3                    IS      'Telefone terciário do cliente para a loja entrar em contato';


CREATE TABLE envios (
                envio_id                                NUMERIC(38)       NOT NULL,
                loja_id                                 NUMERIC(38)       NOT NULL,
                cliente_id                              NUMERIC(38)       NOT NULL,
                endereco_entrega                        VARCHAR(512)      NOT NULL,
                status                                  VARCHAR(15)       NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE envios                                 IS      'Tabela com as informações de envio ';
COMMENT ON COLUMN envios.envio_id                       IS      'Número de identificação dos envios';
COMMENT ON COLUMN envios.loja_id                        IS      'Número de identificação das lojas';
COMMENT ON COLUMN envios.cliente_id                     IS      'Número de identifcação dos clientes';
COMMENT ON COLUMN envios.endereco_entrega               IS      'Endereço do cliente para recebimento do produto';
COMMENT ON COLUMN envios.status                         IS      'Para acompanhar o andamento do produto ';


CREATE TABLE    pedidos (
                pedido_id                               NUMERIC(38)       NOT NULL,
                data_hora                               TIMESTAMP         NOT NULL,
                cliente_id                              NUMERIC(38)       NOT NULL,
                status                                  VARCHAR(15)       NOT NULL,
                loja_id                                 NUMERIC(38)       NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE  pedidos                               IS      'Tabela com as informações dos pedidos dos clientes';
COMMENT ON COLUMN pedidos.pedido_id                     IS      'Número de identificação dos pedidos';
COMMENT ON COLUMN pedidos.data_hora                     IS      'Data a Hora que foi realizado o pedido do cliente';
COMMENT ON COLUMN pedidos.cliente_id                    IS      'Número de identificação dos clientes';
COMMENT ON COLUMN pedidos.status                        IS      'Para acompanhar o andamento do produto ';
COMMENT ON COLUMN pedidos.loja_id                       IS      'Número de indetificação das lojas';


CREATE TABLE   pedidos_itens (
                pedido_id                               NUMERIC(38)       NOT NULL,
                produto_id                              NUMERIC(38)       NOT NULL,
                numero_da_linha                         NUMERIC(38)       NOT NULL,
                preco_unitario                          NUMERIC(10,2)     NOT NULL,
                quantidade                              NUMERIC(38)       NOT NULL,
                envio_id                                NUMERIC(38),
                CONSTRAINT pedido_item PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE pedidos_itens                          IS      'Tabela com as informações dos pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id               IS      'Número de identificação dos pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id              IS      'Número de identificação dos produtos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha         IS      'Número da linha que o produto se encontra';
COMMENT ON COLUMN pedidos_itens.preco_unitario          IS      'Preço unitário de cada produto';
COMMENT ON COLUMN pedidos_itens.quantidade              IS      'Quantidade de pedidos feitos';
COMMENT ON COLUMN pedidos_itens.envio_id                IS      'Número de identificação dos envios';

/*Criação das Foreign Keys das tabelas do banco de dados "uvv"*/

--Cria a Foreign Key da tabela envios
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Cria a Foreign Key da tabela estoques
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Cria a Foreign Key da tabela pedidos
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Cria a Foreign Key da tabela estoques
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--Cria a Foreign Key da tabela pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Cria a Foreign Key da tabela pedidos
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Cria a Foreign Key da tabela envios
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Cria a Foreign Key da tabela pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--Cria a Foreign Key da tabela pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Adiciona restrições as tabelas determinadas para não serem inseridados dados invalidados nas tabelas */

--Restrição da tabela produtos para o preço não ser negativo
ALTER TABLE produtos  ADD CONSTRAINT preco_positivo       CHECK(preco_unitario >= 0);

--Restrição da tabela estoques para a quantidade não ser negativa
ALTER TABLE estoques  ADD CONSTRAINT quantidade_positiva  CHECK(quantidade >= 0);

--
ALTER TABLE pedidos   ADD CONSTRAINT status_certo         CHECK(status IN ('CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO, ENVIADO'));

--
ALTER TABLE envios    ADD CONSTRAINT status_certo_2       CHECK(status IN('CRIADO, ENVIADO, TRANSITO, ENTREGUE'));

-- Comando para não deixar a tabela endeco_web e endereco_fisico vazias ao mesmo tempo
ALTER TABLE lojas     ADD CONSTRAINT endereco_vazio 	  CHECK(endereco_web IS not null OR endereco_fisico IS not null);






