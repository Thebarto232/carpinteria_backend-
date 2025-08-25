-- Crear usuario y sus permisos
create user flaco_2323@localhost identified by "johan123";

grant all privileges on carpinteria_connet_v2. *to  flaco_2323@localhost;
flush privileges;

SELECT user, host FROM mysql.user WHERE user = 'flaco_2323';