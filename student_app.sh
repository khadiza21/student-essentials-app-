#!/bin/bash

FILE=$(pwd)/admin.log
LOGGEDIN=$(pwd)/loggedin.log

function home() {
    user=$(whoami)
    email=$(awk -F ":" '{print $1}' admin.log)
    date=$(date +"%Y-%m-%d")
    time=$(date +"%H:%M:%S")

    yad --title="Student Essentials App" --center --borders=10 --width=450 --height=500 --text-align=center --separator="" \
        --text="<span><b><big><big>Welcome!</big></big></b></span>" \
        --form \
        --field="<b><u>here</u></b>":LBL \
        --field="<b>Date:</b> $date":LBL \
        --field="<b>Time:</b> $time":LBL \
        --field="<b>Username:</b> $user":LBL \
        --button="Exit":0 \
        --button="To Do List":1 \
        --button="calculator":2 \
        --button="stopwatch":3 \
        --button="Logout":4 \
        # --field="todo":FBTN "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "./to_do.sh" \
        # --field="stopwatch":FBTN "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "./stopwatch.sh" \
    #    --field="calculator":FBTN "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "./calculator.sh" \
    code=${?}

    if [ $code == 0 ]; then
        echo "Student Essentials App closed by user"
        exit
    elif [ $code == 4 ]; then
        echo "Logged out"
        rm loggedin.log
        ./linux_toolbox.sh
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
    signup=$(yad --form --center --borders=10 --width=350 --height=300 --title="Student Essentials App - Signup" --separator=' ' --text-align=center --text="<span><b><big><big>Signup</big></big></b></span>" \
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

