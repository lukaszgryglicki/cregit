#!/bin/sh
cd persons
sbt 'run /home/justa/dev/kubernetes_token ../kubernetes-persons.xls ../kubernetes-persons.db'
# printf "drop table persons;\n" | sqlite3 $PERSONSDB
# printf "create table persons(personid text primary key not null, personname text);\n" | sqlite3 $PERSONSDB
# printf "insert into persons(personid) select distinct personid from emails;\n" | sqlite3 $PERSONSDB
