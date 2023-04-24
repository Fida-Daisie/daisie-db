#!powershell
param (
    [string]${env}
)

function how_to_use()
{
    $file = $MyInvocation.MyCommand
    Write-Output "How to use ${file}:"
    Write-Output "./${file} -env <env-file-name>"
}

if ($env -eq $null -or $env -eq "") {
    how_to_use
    exit 1
}

# Docker Compose V2
docker compose --project-name ${project_name}_${project_version} --env-file ${env} --file ./compose/compose-configuration-postgres.yml up --detach --build