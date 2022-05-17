FROM postgres:12

RUN localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8

ENV LANG de_DE.utf8

ENV POSTGRES_PASSWORD fida
ENV POSTGRES_USER daisie-admin
ENV POSTGRES_DB daisie-dwh
ENV PGDATA /var/lib/postgresql/data/
COPY init.sql /docker-entrypoint-initdb.d/
