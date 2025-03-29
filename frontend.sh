source common.sh
component=frontend

Head "Install nginx web server"
dnf install nginx -y
echo $?

Head "Configure frontend"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

App_Preq /usr/share/nginx/html

Head "start nginx services"
systemctl enable nginx
systemctl restart nginx
echo $?
