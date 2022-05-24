#!/bin/sh
/opt/mssql-tools/bin/sqlcmd -S AzureSQLEdge,1433 -U 'sa' -P 'password1!test' -i /home/root/init.sql

