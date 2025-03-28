log_file=/tmp/expense.log
echo -e "\e[33m disable nodejs current version\e[0m"
dnf module disable nodejs -y &>>$log_file

echo -e  "\e[33m enable nodejs latest version\e[0m"
dnf module enable nodejs:18 -y &>>$log_file

echo -e  "\e[33m install nodejs version\e[0m"
dnf install nodejs -y &>>$log_file

echo -e  "\e[33m configure backend.service file\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo -e  "\e[33m Add user\e[0m"
useradd expense &>>$log_file

echo -e  "\e[33m remove the existing content in app directory when you run code again\e[0m"
rm -rf /app   &>>$log_file //reruning should not fail so we added this step

echo -e  "\e[33m create directory\e[0m"
mkdir /app &>>$log_file

echo -e  "\e[33m download the application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app

echo -e  "\e[33m extract the content\e[0m"
unzip /tmp/backend.zip &>>$log_file

echo -e  "\e[33m install the dependencies\e[0m"
npm install &>>$log_file

echo -e  "\e[33m reload the systemd and start backend services\e[0m"
systemctl daemon reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file

echo -e  "\e[33m install mysql client\e[0m"
dnf install mysql -y &>>$log_file

echo -e  "\e[33m load the schema\e[0m"
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file

