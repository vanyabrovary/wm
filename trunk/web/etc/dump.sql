CREATE TABLE pgsql_auth (
    id serial,
    username character varying(255) NOT NULL,
    passwd character varying(255) NOT NULL,
    CONSTRAINT pgsql_auth_id PRIMARY KEY (id),
    CONSTRAINT pgsql_auth_username_key UNIQUE (username)
);
