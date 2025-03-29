log_file=/tmp/expense.log

Head(){
  echo -e "\e[33m$1\e[0m"
}
App_Preq(){
DIR=$1

Head "remove the existing/default app content"
rm -rf $1  &>>$log_file //reruning should not fail so we added this step
echo $?

Head "create Application directory"
mkdir $1 &>>$log_file
echo $?

Head "download the application content"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
cd $1
echo $?

Head "extract the content"
echo $?
unzip /tmp/${component}.zip &>>$log_file
}
echo $?