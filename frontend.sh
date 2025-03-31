source common.sh
Head " Install nginx server"
dnf install nginx -y &>>$log_file
echo $?

Head "Configure the configuration fle"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

Head "Remove the existing content"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

Head "Download the Application Content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
cd  /usr/share/nginx/html &>>$log_file
echo $?

Head "Extract the Application content"
unzip /tmp/frontend.zip &>>$log_file
echo $?

Head " Start and enable Nginx Services"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?


