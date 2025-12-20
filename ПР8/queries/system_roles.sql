CREATE TABLE system_roles (
                              role_id SERIAL PRIMARY KEY,
                              role_name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO system_roles (role_name)
VALUES ('Администратор'), ('Фармацевт'), ('Менеджер');
