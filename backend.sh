component=backend
source common.sh

Head "Disable existing Nodejs version"
dnf module disable nodejs -y &>>$log_file
Stat $?

Head "Enable Latest version of nodejs"
dnf module enable nodejs:20 -y &>>$log_file
Stat $?

Head "Install Nodejs"
dnf install nodejs -y &>>$log_file
Stat $?

Head "Configure Backend service file"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
Stat $?

Head "Add User"
id=expense
if [ $? -ne 0 ]; then
  useradd expense &>>$log_file
fi
Stat $?

App_Preq /app

npm install &>>$log_file

Head "Start and reload the services"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
Stat $?

Head "Install mysql client"
dnf install mysql -y &>>$log_file
Stat $?

Head "Load Schema"
mysql -h mysql-dev.tejudevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
Stat $?



