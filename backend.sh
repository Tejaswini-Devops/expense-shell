component=backend
source common.sh

Head "Disable existing Nodejs version"
dnf module disable nodejs -y &>>$log_file
echo $?

Head "Enable Latest version of nodejs"
dnf module enable nodejs:20 -y &>>$log_file
echo $?

Head "Install Nodejs"
dnf install nodejs -y &>>$log_file
echo $?

Head "Configure Backend service file"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

Head "Add User"
useradd expense &>>$log_file
echo $?

App_Preq /app

Head "Start and reload the services"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
echo $?

Head "Install mysql client"
dnf install mysql -y &>>$log_file
echo $?

Head "Load Schema"
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?



