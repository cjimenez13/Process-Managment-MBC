use RRHH;
go

CREATE UNIQUE NONCLUSTERED INDEX idx_email_notnull
ON Users(email)
WHERE email IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX idx_username_notnull
ON Users(username)
WHERE username IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX idx_id_notnull
ON Users(id)
WHERE id IS NOT NULL;