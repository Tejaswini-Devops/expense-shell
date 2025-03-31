Head " Install nginx server"
dnf install nginx -y
echo $?

Head "Configure the configuration fle"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

Head "Remove the existing content"
rm -rf /usr/share/nginx/html/*
echo $?

Head "Download the Application Content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip
cd  /usr/share/nginx/html
echo $?

Head "Extract the Application content"
unzip /tmp/frontend.zip
echo $?

Head " Start and enable Nginx Services"
systemctl enable nginx
systemctl restart nginx
echo $?


