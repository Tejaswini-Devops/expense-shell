dnf module disable mysql -y
cp mysql.repo /etc/yum.repos.d/mysql.repo

dnf module install mysql-community-server -y

dnf module enable mysqld
dnf module start mysqld

mysql_secure_installation --set-root-pass ExpenseApp@1

mysql 172.31.94.208 -uroot -pExpenseApp@1

