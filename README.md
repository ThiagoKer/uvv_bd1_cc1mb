# PSET
- **Aluno:** Thiago Ker Gama Nunes Carvalho
- **Turma**:CC1MB
- **Professor:**   Abrantes Araújo Silva Filho
- **Monitora:** Suellen Miranda

> Este é um trabalho da matéria de Design e Desenvolvimento de Banco de dados com o professor Abrantes da Universidade de Vila Velha
                                 


# O que é o PSET?
O **PSET** é um conjunto de exercícios fornecidos pelo professor aos seus alunos, com o intuito de aprender e aplicar de forma prática a matéria passada em sala de aula. É necessário que o aluno faça individualmente, aplicando seus conhecimentos aprendidos e indo em busca das respostas em livros e documentações.

Os **PSETs** são comumentes passados em universidades e faculdades para avaliar os conhecimentos dos alunos e como está o aprendizado na matéria, testando seus conhecimentos e sua capacidade de resolver adversidades.

## Introdução:
Neste **PSET** tivemos como objetivo a implementação do esquema "lojas" no **PostgresSQL**, criação de códigos SQL para gerar relatórios sobre o banco, introdução ao **Git** e **Github** e responder questões discursivas sobre a matéria.

## Projeto lógico

Uma imagem do diagrama "lojas" que utilizamos como base para produzir o código no postgres.
[Esquema "lojas"](https://github.com/ThiagoKer/cc1mb_202305845_postgree.sql/blob/main/bd_pset.pdf)

## Banco de Dados no Postgres

A princípio, criei o diagrama "lojas" no **SQL Power Architect** e com ele gerei parte do código no formato do **Postgres**. Desse modo, implementei mais alguns comandos no código, como o de criação do  banco de dados "uvv" e a criação do usuário "thiago". Por fim, a maior parte do código foi gerado com ajuda do **SQL Power Architect** mas ainda era necessário a criação de **CONSTRAINTS** no comando, para evitar que dados inválidos sejam inseridos no banco de dados. E a formatação do código, com o intuito de ter um melhor visual e facilidade no entendimento e procura de dados.

## Consulta SQL
|Comando| Ação ||
|-|---|--|
|DROP DATABASE|Deleta o banco de dados
|DROP USER|Deleta o usuário
|CREATE USER|Cria o usuário
|CREATE DATABASE|Cria o banco de dados
|CREATE SCHEMA|Conecta as tabelas
|ALTER USER|Altera o usuário
|SET SEARCH_PATH|Muda a ordem dos esquemas
|CREATE TABLE| Cria uma tabela
|COMMENT ON TABLE|Faz um comentário sobre a tabela
|COMMENT ON COLUMN|Faz um comentário sobre a coluna
|ALTER TABLE|Modifica a tabela
