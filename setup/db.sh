#!/bin/bash
# Type password when prompted to access the database

MYSQLHOST="remotemysql.com"
MYSQLUSER="ubxh2yqkZt"
MYSQLDB=$MYSQLUSER

function usage () {
    echo "usage:";
    echo "--login, -l: log onto mysql server"
    echo "--reset, -r: setup or soft reset schema in database";
    echo "--hard-reset, -h: hard reset schema";
    echo "--conditional-only, -c: only run conditional.sql";
}

function logon() {
    mysql -h $MYSQLHOST -u $MYSQLUSER -D $MYSQLDB -p
}

if [[ $# -eq 0 ]]; then
    usage;
    logon;
    exit 0
elif [[ $# -eq 1 ]]; then
    case $1 in
    -l | --login)
        logon;
        exit 0
        ;;
    -h | --hard-reset)
        logon < schema.sql;
        logon < static.sql;
        logon < conditional.sql;
        exit 0
        ;;
    -r | --reset)
        logon < static.sql;
        logon < conditional.sql;
        exit 0
        ;;
    -c | --conditional-only)
        logon < conditional.sql;
        exit 0
    *)
        usage;
        exit 1
        ;;
    esac
else
    usage;
fi

