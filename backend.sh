echo -e "\e[33m disable nodejs current version\e[0m"
dnf module disable nodejs -y &>>/tmp/expense.log

echo -e  "\e[33m enable nodejs latest version\e[0m"
dnf module enable nodejs:18 -y &>>/tmp/expense.log

echo -e  "\e[33m install nodejs version\e[0m"
dnf install nodejs -y &>>/tmp/expense.log

echo -e  "\e[33m configure backend.service file\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo -e  "\e[33m Add user\e[0m"
useradd expense &>>/tmp/expense.log

echo -e  "\e[33m remove the existing content in app directory when you run code again\e[0m"
rm -rf /app   &>>/tmp/expense.log //reruning should not fail so we added this step

echo -e  "\e[33m create directory\e[0m"
mkdir /app &>>/tmp/expense.log

echo -e  "\e[33m download the application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/expense.log
cd /app

echo -e  "\e[33m extract the content\e[0m"
unzip /tmp/backend.zip &>>/tmp/expense.log

echo -e  "\e[33m install the dependencies\e[0m"
npm install &>>/tmp/expense.log

echo -e  "\e[33m reload the systemd and start backend services\e[0m"
systemctl daemon reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log

echo -e  "\e[33m install mysql client\e[0m"
dnf install mysql -y &>>/tmp/expense.log

echo -e  "\e[33m load the schema\e[0m"
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log

