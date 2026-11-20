-- Puntaje 1-5 en reseñas de clientes
alter table reviews add column if not exists rating int default 5;
