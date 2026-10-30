-- 1. Chamados abertos, do mais recente para o mais antigo
SELECT * FROM chamados WHERE status = 'ABERTO' ORDER BY criado_em DESC;

-- 2. Quantidade de chamados por status
SELECT status, COUNT(*) AS total FROM chamados GROUP BY status;

-- 3. Título de cada chamado com o nome do cliente
SELECT c.titulo, u.nome
FROM chamados c
INNER JOIN usuarios u ON c.cliente_id = u.id;

-- 4. Técnicos que nunca atenderam chamado (anti-join)
SELECT u.nome
FROM usuarios u
LEFT JOIN chamados c ON u.id = c.tecnico_id
WHERE u.perfil = 'TECNICO' AND c.id IS NULL;

-- 5. Tempo médio de resolução por prioridade (chamados fechados)
SELECT prioridade, AVG(fechado_em - criado_em) AS tempo_medio
FROM chamados
WHERE fechado_em IS NOT NULL
GROUP BY prioridade;
