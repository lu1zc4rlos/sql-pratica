# SQL Prática – Help Desk

Exercícios de SQL com PostgreSQL sobre um banco simplificado de Help Desk
(usuários e chamados), feitos no terminal com `psql`.

## Conceitos praticados
SELECT, WHERE, ORDER BY, GROUP BY, COUNT, AVG, INNER JOIN, LEFT JOIN (anti-join), IS NULL.

## Estrutura do repositório
- `schema-e-dados.sql`: criação das tabelas `usuarios` e `chamados` e dados de exemplo
- `consultas.sql`: as 5 consultas, cada uma com um comentário explicando o objetivo

## Como rodar (Ubuntu + PostgreSQL)
```bash
sudo -u postgres psql -c "CREATE DATABASE helpdesk_pratica;"
sudo -u postgres psql -d helpdesk_pratica < schema-e-dados.sql
sudo -u postgres psql -d helpdesk_pratica < consultas.sql
```

## Consultas
1. **Chamados abertos, do mais recente ao mais antigo** – Lista só os chamados em aberto. Uso `WHERE` para filtrar pelo status e `ORDER BY criado_em DESC` para mostrar os mais recentes primeiro.
2. **Quantidade por status** – Mostra quantos chamados existem em cada status. Uso `GROUP BY status` para agrupar e `COUNT(*) AS total` para contar cada grupo e dar um nome claro à coluna.
3. **Chamado com nome do cliente (INNER JOIN)** – Lista o título de cada chamado com o nome do cliente que o abriu. O `INNER JOIN` busca na tabela `usuarios` o par de cada chamado, e o `ON c.cliente_id = u.id` define a condição que liga as duas tabelas.
4. **Técnicos sem chamados (LEFT JOIN + IS NULL)** – Lista os técnicos que nunca atenderam nenhum chamado. Uso `LEFT JOIN` porque ele mantém todos os usuários, mesmo sem chamado ligado (um `INNER JOIN` eliminaria justamente esses técnicos). O `WHERE` filtra o perfil `TECNICO` e, com `AND c.id IS NULL`, fica só quem não teve par na tabela `chamados`.
5. **Tempo médio de resolução por prioridade** – Mostra quanto tempo, em média, os chamados de cada prioridade levam para ser resolvidos. Uso `AVG(fechado_em - criado_em)` para a média e `GROUP BY prioridade` para calcular uma por prioridade. O filtro `WHERE fechado_em IS NOT NULL` deixa só os chamados fechados, porque só eles têm tempo de resolução.

## Aprendizados
- **Letras maiúsculas e minúsculas importam.** Filtrei por `'fechado'` e os dados estavam como `'FECHADO'`. No PostgreSQL a comparação de texto diferencia maiúsculas de minúsculas, então a consulta voltou vazia, sem erro.
- **`IS NULL`, e não `= NULL`.** `NULL` significa valor desconhecido, e comparar com `=` nunca dá verdadeiro. Para achar linhas sem par, o certo é `IS NULL`.
- **Coluna do `SELECT` fora de função precisa estar no `GROUP BY`.** Na consulta da média, listei colunas que não estavam no agrupamento, e na contagem por status esqueci de mostrar o `status`, o que deixou os números sem rótulo.

## Próximos passos
`HAVING`, subconsultas e índices.
