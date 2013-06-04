#!/bin/bash
# ox0spy <ox0spy[at]gmail.com>

# get MySQL root password
read -s -p "Please input MySQL root password: " pw
echo

mysql_cmd="mysql -u root -p$pw"
all_db='clid bigbrother'
# process database and all table in those databases
for db in $all_db
do
    echo "ALTER DATABASE $db DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci" | $mysql_cmd
    mysql_cmd_with_db="$mysql_cmd -D $db"
    for x in $(echo 'show tables' | $mysql_cmd_with_db | \
        grep -Ev "^Tables_in_$db")
        do
            echo $x
            sql="ALTER TABLE $x CONVERT TO CHARACTER SET utf8"
            echo $sql | $mysql_cmd_with_db
            echo "done, convert $x to utf8"
        done
done

# change mysqld and mysql client charset
# change /etc/mysql/my.cnf, add "default-character-set=utf8" under [mysqld] and [mysql]
# then, restart mysqld: $ sudo services mysql restart
