FROM openjdk:8

COPY ./app /app

WORKDIR /app

RUN chmod +x ./sq_docker_start/sq_docker_start_run.sh

CMD ./sq_docker_start/sq_docker_start_run.sh --context_param DB_VERBINDUNG_FILE=/app/files/db_verbindung.file --context_param daisie_csvFilePath=/app/files/input.xlsx
