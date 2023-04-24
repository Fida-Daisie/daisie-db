ARG postgres_version

FROM postgres:${postgres_version}

RUN localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8

ENV LANG de_DE.utf8

ARG postgres_user
ARG postgres_password
ARG postgres_db

ENV POSTGRES_PASSWORD ${postgres_password}
ENV POSTGRES_USER ${postgres_user}
ENV POSTGRES_DB ${postgres_db}

ENV PGDATA /var/lib/postgresql/data/

COPY init.sql /docker-entrypoint-initdb.d/
