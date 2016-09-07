execute sp_insert_role 'Administrador', 'Utilizado solo por los gerentes'
execute sp_insert_role 'Desarrollador', 'Equipo de desarrollo'
delete from Roles
execute sp_get_roles
select * from Roles