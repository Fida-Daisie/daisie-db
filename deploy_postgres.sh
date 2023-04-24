#!/bin/bash
how_to_use()
{
    printf "How to use $(basename ${0}):\n"
    printf "./$(basename ${0}) \"env-file-name\"\n"
}

if [ $# -eq 0 ]
then
    how_to_use
    exit 1
fi

source $1

# Docker Compose V2
docker compose \
    --project-name ${project_name}_${project_version} \
    --env-file ${1} \
    --file ./compose/compose-configuration-postgres.yml\
    up --detach --build


