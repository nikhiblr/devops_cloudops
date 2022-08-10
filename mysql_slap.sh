time mysqlslap --user=root --password=$(cat /root/mysql) --host=localhost concurrency=50 --iterations=100 --number-int-cols=5 --number-char-cols=20 --auto-generate-sql --verbose
