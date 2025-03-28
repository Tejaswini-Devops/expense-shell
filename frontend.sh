source common.sh
component=frontend

Head "Install nginx web server"
dnf install nginx -y &>>$log_file
Stat $?

Head "Configure frontend"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
Stat $?

App_Preq /usr/share/nginx/html

Head "start nginx services"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
Stat $?
