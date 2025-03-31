source common.sh
Head "Disable Current Mysql located in system"
dnf module disable mysql -y &>>$log_file
Stat $?

Head "Create repo file"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
Stat $?

Head "Install my sql 5.7 as per developer choice"
dnf install mysql-community-server &>>$log_file
Stat $?

Head "Enable and restart services"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
Stat $?

Head "Change the default password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
Stat $?



