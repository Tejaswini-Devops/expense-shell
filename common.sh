log_file=/tmp/expense.log

Head(){
  echo -e "\e[35m$1\e[0m"
}

App_Preq(){
DIR=$1
Head "Remove the existing content"
rm -rf $1 &>>$log_file
Stat $?

Head "Create Directory"
mkdir $1 &>>$log_file
Stat $?

Head "Download the Content to Directory"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$log_file
cd $1 &>>$log_file
Stat $?

Head "Extract the Application content"
unzip /tmp/${component}.zip &>>$log_file
Stat $?
}

Stat(){
  if [ $1 -eq 0 ]; then
    echo "SUCCESS"
  else
    echo "FAILURE"
  fi
}