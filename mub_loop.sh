#!/bin/bash

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

if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 #other than 0
fi

for package in $@
do
    dnf list installed $package
    if [ $? -eq 0 ]
    then 
        dnf remove $package -y
        VALIDATE $? "Removing $package"
    else
        echo "$package is not installed"
    fi
done

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ] 
    then 
        dnf install $package -y
        VALIDATE $? "Installing $package"
    else
        echo "$package is already INSTALLED"
    fi
done

