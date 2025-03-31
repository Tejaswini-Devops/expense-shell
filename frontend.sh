dnf install nginx -y

systemctl enable nginx
systemctl start nginx

rm-rf /usr/nginx/share/html/*

curl -o /tmp/frontend.zip frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/nginx/share/html
unzip /tmp/frontend.zip

cp expense.conf /etc/nginx/default.d/expense.conf

systemctl restart nginx


