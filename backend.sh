log_file= /tmp/expemse.log
Head(){
  echo -e "\e[35m$1\e[0m"
}
Head "Disable existing Nodejs version"
dnf module disable nodejs -y &>>$log_file

Head "Enable Latest version of nodejs"
dnf module enable nodejs:20 -y &>>$log_file

Head "Install Nodejs"
dnf install nodejs -y &>>$log_file

Head "Configure Backend service file"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

Head "Add User"
useradd expense &>>$log_file

Head "Remove the existing content"
rm -rf /app &>>$log_file

Head "Create Directory"
mkdir /app &>>$log_file

Head "Download the Content to Directory"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$log_file
cd /app &>>$log_file

Head "Extract the Application content"
unzip /tmp/backend.zip &>>$log_file
npm install &>>$log_file

Head "Start and reload the services"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file

Head "Install mysql client"
dnf install mysql -y &>>$log_file

Head "Load Schema"
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file



