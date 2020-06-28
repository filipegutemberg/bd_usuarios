CREATE TABLE IF NOT EXISTS cargo 
(id  BIGSERIAL, cargo_nome VARCHAR(255) NOT NULL);

ALTER TABLE cargo ADD PRIMARY KEY (id);

ALTER TABLE cargo RENAME COLUMN cargo TO nome;

CREATE TABLE IF NOT EXISTS orgao
(id BIGSERIAL, nome VARCHAR (255)NOT NULL);

ALTER TABLE orgao ADD PRIMARY KEY (id);


CREATE TABLE IF NOT EXISTS usuario
(cpf BIGSERIAL PRIMARY KEY, nome VARCHAR(255), id_cargo BIGINT NOT NULL, id_orgao BIGINT NOT NULL,
FOREIGN KEY (id_cargo) REFERENCES cargo (id),
FOREIGN KEY (id_orgao) REFERENCES orgao (id));

ALTER TABLE usuario
ALTER COLUMN cpf TYPE BIGINT;

CREATE TABLE IF NOT EXISTS sistema
(cpf BIGSERIAL PRIMARY KEY, nome VARCHAR(255), id_cargo BIGINT NOT NULL, id_orgao BIGINT NOT NULL,
FOREIGN KEY (id_cargo) REFERENCES cargo (id),
FOREIGN KEY (id_orgao) REFERENCES orgao (id));


CREATE TABLE IF NOT EXISTS sistema
(id BIGSERIAL PRIMARY KEY, nome VARCHAR(255) NOT NULL);


CREATE TABLE IF NOT EXISTS usuario_sistema
(id BIGSERIAL PRIMARY KEY, cpf_usuario BIGINT NOT NULL, id_sistema BIGINT NOT NULL,
FOREIGN KEY (cpf_usuario) REFERENCES usuario (cpf),
FOREIGN KEY (id_sistema) REFERENCES sistema (id));

INSERT INTO cargo (nome)
VALUES ('Desenvolvedor');
INSERT INTO cargo (nome)
VALUES ('Analista de Requisitos');
INSERT INTO cargo (nome)
VALUES ('Analista de Sistemas');
INSERT INTO cargo (nome)
VALUES ('Arquiteto de Software');
INSERT INTO cargo (nome)
VALUES ('Gerente de Projetos');

INSERT INTO orgao (nome)
VALUES ('Secretaria A');
INSERT INTO orgao (nome)
VALUES ('Secretaria B');
INSERT INTO orgao (nome)
VALUES ('Secretaria C');
INSERT INTO orgao (nome)
VALUES ('Secretaria D');

select nome from orgao;
select * from cargo;

INSERT INTO usuario (cpf, nome, id_cargo, id_orgao)
VALUES (11111111111,'Ana', 1, 2);
INSERT INTO usuario (cpf, nome, id_cargo, id_orgao)
VALUES (11111111113,'Pedro', 2, 1);
INSERT INTO usuario (cpf, nome, id_cargo, id_orgao)
VALUES (11111111114,'Jonas', 3, 3);
INSERT INTO usuario (cpf, nome, id_cargo, id_orgao)
VALUES (11111111115,'Sara', 4, 4);


select * from usuario;

INSERT INTO sistema (nome)
values ('Compras');
INSERT INTO sistema (nome)
values ('Rh');
INSERT INTO sistema (nome)
values ('Atendimento');
INSERT INTO sistema (nome)
values ('Jurídico');

select * from sistema;


INSERT INTO usuario_sistema (cpf_usuario, id_sistema)
values (11111111111, 1);
INSERT INTO usuario_sistema (cpf_usuario, id_sistema)
values (11111111111, 2);
INSERT INTO usuario_sistema (cpf_usuario, id_sistema)
values (11111111111, 3);
INSERT INTO usuario_sistema (cpf_usuario, id_sistema)
values (11111111113, 2);
INSERT INTO usuario_sistema (cpf_usuario, id_sistema)
values (11111111113, 3);
INSERT INTO usuario_sistema (cpf_usuario, id_sistema)
values (11111111114, 4);

select * from usuario_sistema;

CREATE OR REPLACE TEMPORARY VIEW vw_sistemas_por_usuario AS (
	SELECT usuario_sistema.cpf_usuario, usuario.nome as usuario_nome, sistema.nome FROM usuario_sistema
	JOIN usuario ON usuario_sistema.cpf_usuario = usuario.cpf
	JOIN sistema ON usuario_sistema.id_sistema = sistema.id
	GROUP BY usuario_nome, sistema.nome, usuario_sistema.cpf_usuario
);

SELECT * FROM USUARIO;
	
SELECT * FROM vw_sistemas_por_usuario;

SELECT regexp_replace(CAST (usuario.cpf AS VARCHAR(11)),'([0-9]{3})([0-9]{3})([0-9]{3})','\1.\2.\3-'), UPPER(usuario.nome) as usuario_nome,
cargo.nome as cargo_nome,
orgao.nome as nome_orgao,
sistema.nome as nome_sistema
FROM usuario
JOIN cargo ON usuario.id_cargo = cargo.id
JOIN orgao ON usuario.id_orgao = orgao.id
JOIN usuario_sistema ON usuario_sistema.cpf_usuario = usuario.cpf
JOIN sistema ON usuario_sistema.id_sistema = sistema.id




	