component=frontend
source common.sh
Head " Install nginx server"
dnf install nginx -y &>>$log_file
Stat $?

Head "Configure the configuration fle"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
Stat $?

App_Preq /usr/share/nginx/html

Head " Start and enable Nginx Services"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
Stat $?


