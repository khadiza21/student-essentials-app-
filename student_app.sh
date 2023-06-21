#!/bin/bash

FILE=$(pwd)/admin.log
LOGGEDIN=$(pwd)/loggedin.log

function home() {

    user=$(whoami)
    email=$(awk -F ":" '{print $1}' admin.log)
    date=$(date +"%d-%m-%y")
    time=$(date +"%H:%M:%S")

    yad --title="Student Essentials App" --center --borders=10 --width=450 --height=500 --text-align=center --separator="" \
        --text="<span><b><big><big>Welcome!</big></big></b></span>" \
        --text="<span><b>About Student Essentials App</b></span>" \
        --text="<span>This is an app made for as a helping hand as an student or others peoples. Here You can create your account by sign up then you can deep drive in this app by log in using your email and password. In this app you get an magical calculator , stopwatch, and also make your to do list and can manage it. </span>" --text-align=left \
        --form --separator="" \
        --field="<b>Username:</b> $user":LBL \
        --field="<b>Email:</b> $email":LBL \
        --field="<b>Date:</b> $date":LBL \
        --field="<b>Time:</b> $time":LBL \
        --button="Exit":0 \
        --button="To Do List":1 \
        --button="calculator":2 \
        --button="stopwatch":3 \
        --button="Logout":4 \

    code=${?}

    if [ $code == 0 ]; then
        echo "Student Essentials App closed by user"
        exit
    elif [ $code == 2 ]; then
        echo "Calculator"
        calculator
    elif [ $code == 4 ]; then
        echo "Logged out"
        rm loggedin.log
        ./student_app.sh
        exit
    fi
}

function login_window() {
    echo "Login window..."
    # login window
    login=$(yad --form --center --borders=10 --width=400 --height=300 --title="Student Essentials App - Login" --separator=' ' \
        --button=Exit:1 \
        --button=Login:0 \
        --field="Email": \
        --field="Password":) valid=${?}

    if [ $valid -eq 0 ]; then
        email=$(echo $login | awk '{print $1}') 
        password=$(echo $login | awk '{print $2}')

        echo "Email = $email"
        echo "Password = $password"

        if grep -q "$email:$password" admin.log; then
            echo "Login Successful"
            echo "$email:$password" > loggedin.log
            home
        else
            echo "Login Failed!"
            echo "Wrong email or password"
        fi
    elif [ $valid -eq 1 ]; then
        echo "Student Essentials App closed by user"
        exit
    fi
}

function signup_window() {
    echo "Signup window..."

    # signup window
    signup=$(yad --form --center --borders=10 --width=450 --height=300 --title="Student Essentials App - Signup" --separator=' ' --text-align=center --text="<span><b><big><big>Signup</big></big></b></span>" \
        --button=Exit:1 \
        --button=Signup:0 \
        --field="Email": \
        --field="Password":) valid=${?}

    if [ $valid -eq 0 ]; then
        email=$(echo $signup | awk '{print $1}') 
        password=$(echo $signup | awk '{print $2}')

        echo "Email = $email"
        echo "Password = $password"

        echo "$email:$password" >> admin.log
        echo "Signup Successful"
        login_window
    elif [ $valid -eq 1 ]; then
        echo "Student Essentials App closed by user"
        exit
    fi
}
if [ -f "$FILE" ]; then
    while :
    do
        if [ -f "$LOGGEDIN" ]; then
            echo "User already logged in"
            home
        else
            login_window
        fi
    done
else
    signup_window
fi

