echo disable nodejs current version
dnf module disable nodejs -y

echo enable nodejs latest version
dnf module enable nodejs:18 -y

echo install nodejs version
dnf install nodejs -y

echo configure backend.service file
cp backend.service /etc/systemd/system/backend.service

echo Add user
useradd expense

echo remove the existing content in app directory when you run code again
rm -rf /app    //reruning should not fail so we added this step

echo create directory
mkdir /app

echo download the application content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo extract the content
unzip /tmp/backend.zip

echo install the dependencies
npm install

echo reload the systemd and start backend services.
systemctl daemon reload
systemctl enable backend
systemctl restart backend

echo install mysql client
dnf install mysql -y

echo load the schema
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

