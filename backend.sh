MYSQL_PASSWORD=$1
if [ -z "$MYSQL_PASSWORD" ]; then
  echo Password is missing
  exit 1
fi
source common.sh
component=backend


Head "disable nodejs current version"
dnf module disable nodejs -y &>>$log_file
Stat $?

Head "enable nodejs latest version"
dnf module enable nodejs:18 -y &>>$log_file
Stat $?

Head "install nodejs version"
dnf install nodejs -y &>>$log_file
Stat $?

Head "configure backend.service file"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
Stat $?

Head "Add user"
id expense &>>$log_file
if [ $? -ne 0 ]; then
# the reason why we have $? instead of $1 because when we give id expense in cmd prompt and check whether it is correct or not we use echo $? if its o then pass if its 1 then fail
  useradd expense &>>$log_file
fi
Stat $?

App_Preq /app

Head "install the dependencies"
npm install &>>$log_file
Stat $?

Head "reload the systemd and start backend services"
systemctl daemon reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
Stat $?

Head "install mysql client"
dnf install mysql -y &>>$log_file
Stat $?

Head "load the schema"
mysql -h mysql-dev.tejudevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
Stat $?

