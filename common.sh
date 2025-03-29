log_file=/tmp/expense.log

Head(){
  echo -e "\e[33m$1\e[0m"
}
App_Preq(){
DIR=$1

Head "remove the existing/default app content"
rm -rf $1  &>>$log_file //reruning should not fail so we added this step
Stat $?

Head "create Application directory"
mkdir $1 &>>$log_file
Stat $?

Head "download the application content"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
cd $1
Stat $?

Head "extract the content"
unzip /tmp/${component}.zip &>>$log_file
Stat $?
}

Stat() {
  if [ $1 -eq 0 ]; then
    echo sucess
  else
    echo Failure
    exit 1
  fi
}