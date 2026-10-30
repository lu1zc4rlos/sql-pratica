CREATE TABLE usuarios (
  id     SERIAL PRIMARY KEY,
  nome   VARCHAR(100) NOT NULL,
  perfil VARCHAR(20)  NOT NULL
);

CREATE TABLE chamados (
  id         SERIAL PRIMARY KEY,
  titulo     VARCHAR(150) NOT NULL,
  status     VARCHAR(20)  NOT NULL,
  prioridade VARCHAR(20)  NOT NULL,
  cliente_id INT NOT NULL REFERENCES usuarios(id),
  tecnico_id INT REFERENCES usuarios(id),
  criado_em  TIMESTAMP NOT NULL,
  fechado_em TIMESTAMP
);

INSERT INTO usuarios (nome, perfil) VALUES
  ('Ana', 'CLIENTE'), ('Bruno', 'CLIENTE'), ('Carla', 'CLIENTE'),
  ('Diego', 'TECNICO'), ('Elisa', 'TECNICO'), ('Fábio', 'TECNICO'),
  ('Gabi', 'ADMIN');

INSERT INTO chamados (titulo, status, prioridade, cliente_id, tecnico_id, criado_em, fechado_em) VALUES
  ('Impressora não imprime', 'FECHADO', 'ALTA',  1, 4, '2026-10-01 09:00', '2026-10-01 15:30'),
  ('Sem acesso ao e-mail',   'FECHADO', 'MEDIA', 2, 4, '2026-10-02 10:00', '2026-10-04 10:00'),
  ('PC muito lento',         'ABERTO',  'ALTA',  3, 5, '2026-10-20 08:15', NULL),
  ('Instalar programa',      'ABERTO',  'BAIXA', 1, NULL, '2026-10-21 14:00', NULL),
  ('Wi-Fi caindo',           'FECHADO', 'ALTA',  2, 5, '2026-10-10 11:00', '2026-10-10 13:00'),
  ('Trocar mouse',           'FECHADO', 'BAIXA', 3, 4, '2026-10-05 16:00', '2026-10-06 09:00');
