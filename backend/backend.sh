#!/bin/bash
# Type password when prompted to access the database
# THIS FILE WILL AUTHENTICATE YOU TO THE OLD MYSQL DATABASE

MYSQLHOST="localhost"
MYSQLUSER="root"
MYSQLDB="GradPlanner"

function usage () {
    echo "usage:";
    echo "--login, -l: log onto mysql server"
    echo "--reset, -r: setup or soft reset schema in database";
    echo "--hard-reset, -h: hard reset schema";
}

function logon() {
    mysql -h $MYSQLHOST -u $MYSQLUSER -D $MYSQLDB -p
}

if [[ $# -eq 0 ]]; then
    usage;
    exit 1
elif [[ $# -eq 1 ]]; then
    case $1 in
    -l | --login)
        logon;
        exit 0
        ;;
    -h | --hard-reset)
        cat schema.sql data.sql | logon;
        exit 0
        ;;
    -r | --reset)
        logon < data.sql;
        exit 0
        ;;
    *)
        usage;
        exit 1
        ;;
    esac
else
    usage;
fi

