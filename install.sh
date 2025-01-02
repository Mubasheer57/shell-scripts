#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 #other than 0
fi

dnf list installed mysql

 if [ $? -ne 0 ]
 then
     echo "Installing MySQL ... FAILURE"
 else
     echo "Installing MySQL ... SUCCESS"
 fi

dnf list installed git


 if [ $? -ne 0 ]
 then
     echo "Installing Git ... FAILURE"
 else
     echo "Installing Git ... SUCCESS"
 fi