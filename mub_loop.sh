#!/bin/bash

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 ... FAILURE"
        exit 1
    else
        echo "$2 ... SUCCESS"
    fi
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 #other than 0
fi

for package in $@
do
    dnf list installed $package &>>$LOG_FILE_NAME
    if [ $? -eq 0 ]
    then 
        dnf remove $package -y &>>$LOG_FILE_NAME
        VALIDATE $? "Removing $package"
    else
        echo "$package is not installed"
    fi
done

for package in $@
do
    dnf list installed $package &>>$LOG_FILE_NAME
    if [ $? -ne 0 ] 
    then 
        dnf install $package -y &>>$LOG_FILE_NAME
        VALIDATE $? "Installing $package"
    else
        echo "$package is already INSTALLED"
    fi
done

