#!/bin/sh
cd `dirname $0`
ROOT_PATH=`pwd`
java -Dtalend.component.manager.m2.repository=$ROOT_PATH/../lib -Xms256M -Xmx1024M -cp .:$ROOT_PATH:$ROOT_PATH/../lib/routines.jar:$ROOT_PATH/../lib/log4j-slf4j-impl-2.13.2.jar:$ROOT_PATH/../lib/log4j-api-2.13.2.jar:$ROOT_PATH/../lib/log4j-core-2.13.2.jar:$ROOT_PATH/../lib/log4j-1.2-api-2.13.2.jar:$ROOT_PATH/../lib/commons-collections-3.2.2.jar:$ROOT_PATH/../lib/jboss-marshalling-river-2.0.12.Final.jar:$ROOT_PATH/../lib/jboss-marshalling-2.0.12.Final.jar:$ROOT_PATH/../lib/talend_file_enhanced-1.1.jar:$ROOT_PATH/../lib/trove.jar:$ROOT_PATH/../lib/advancedPersistentLookupLib-1.3.jar:$ROOT_PATH/../lib/dom4j-2.1.3.jar:$ROOT_PATH/../lib/slf4j-api-1.7.29.jar:$ROOT_PATH/../lib/postgresql-42.2.14.jar:$ROOT_PATH/../lib/talendcsv-1.0.0.jar:$ROOT_PATH/../lib/crypto-utils-0.31.12.jar:$ROOT_PATH/sq_docker_start_0_1.jar:$ROOT_PATH/sq_load_files_0_1.jar:$ROOT_PATH/sq_stage_to_core_0_1.jar:$ROOT_PATH/j_dim_zeit_0_1.jar:$ROOT_PATH/j_load_land_to_core_0_1.jar:$ROOT_PATH/j_load_rechnung_position_to_core_0_1.jar:$ROOT_PATH/j_load_artikel_to_core_0_1.jar:$ROOT_PATH/j_load_rechnung_to_core_0_1.jar:$ROOT_PATH/j_load_rechnung_file_0_1.jar:$ROOT_PATH/j_load_kunden_file_0_1.jar:$ROOT_PATH/j_load_rechnung_position_file_0_1.jar:$ROOT_PATH/j_load_artikel_file_0_1.jar:$ROOT_PATH/sq_mart_0_1.jar:$ROOT_PATH/j_dim_land_0_1.jar:$ROOT_PATH/j_load_land_file_0_1.jar:$ROOT_PATH/j_dim_artikel_0_1.jar:$ROOT_PATH/j_load_kunden_to_core_0_1.jar:$ROOT_PATH/j_mart_artikelverkauf_0_1.jar: local_project.sq_docker_start_0_1.sq_docker_start --context=AUS_FILE "$@"
