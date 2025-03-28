echo -e "\e[33m disable nodejs current version[0m"
dnf module disable nodejs -y
echo -e  "\e[33m enable nodejs latest version[0m"
dnf module enable nodejs:18 -y
echo -e  "\e[33m install nodejs version[0m"
dnf install nodejs -y
echo -e  "\e[33m configure backend.service file[0m"
cp backend.service /etc/systemd/system/backend.service
echo -e  "\e[33m Add user[0m"
useradd expense
echo -e  "\e[33m remove the existing content in app directory when you run code again[0m"
rm -rf /app    //reruning should not fail so we added this step
echo -e  "\e[33m create directory[0m"
mkdir /app
echo -e  "\e[33m download the application content[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
echo -e  "\e[33m extract the content[0m"
unzip /tmp/backend.zip
echo -e  "\e[33m install the dependencies[0m"
npm install
echo -e  "\e[33m reload the systemd and start backend services.[0m"
systemctl daemon reload
systemctl enable backend
systemctl restart backend
echo -e  "\e[33m install mysql client[0m"
dnf install mysql -y
echo -e  "\e[33m load the schema[0m"
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

