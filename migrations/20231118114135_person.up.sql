CREATE EXTENSION IF NOT EXISTS citext;

CREATE DOMAIN public.email AS public.citext CHECK (
    OCTET_LENGTH(VALUE) BETWEEN 6 AND 320 -- https://en.wikipedia.org/wiki/Email_address
    AND VALUE LIKE '_%@_%.__%'
);

COMMENT ON DOMAIN public.email IS 'Aдрес электронной почты с минимальной, но быстрой валидацией';

CREATE TYPE person_status_enum AS ENUM ('active', 'blocked');

CREATE TABLE person
(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login TEXT NOT NULL CHECK(LENGTH(login) BETWEEN 1 AND 255 AND trim(login) = login),
    password_hash TEXT NOT NULL CHECK(LENGTH(password_hash) BETWEEN 1 AND 255 AND trim(password_hash) = password_hash),
    full_name TEXT NOT NULL CHECK(LENGTH(full_name) BETWEEN 1 AND 255 AND trim(full_name) = full_name),
    email email NOT NULL CHECK(trim(email) = email),
    status person_status_enum NOT NULL,
    created_at TIMESTAMP(0) WITH TIME ZONE DEFAULT NOW() NOT NULL CHECK(created_at <= NOW() + interval '10m'),
    last_login_at TIMESTAMP(0) WITH TIME ZONE DEFAULT NOW() NOT NULL CHECK(last_login_at <= NOW() + interval '10m')
);

CREATE UNIQUE INDEX person_login_uniq ON person (login);
