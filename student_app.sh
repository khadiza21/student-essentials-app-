#!/bin/bash

FILE=$(pwd)/admin.log
LOGGEDIN=$(pwd)/loggedin.log


# function calculator(){
#    yad --center --borders=10 --width=500 --height=500 --title="Calculator"  --button=Back:0 \
#        --text="<span><b>Here you can caluculte this below optoin. Press an option which you need!</b></span>" \
#        --button="Arithmetic":1 \
#        --button="BMI":2 \
#        --button="Decimal And Binary":3 \
#        --button="Calore":4 \
#     code=${?}

 
#    if [ ${?} -eq 252 ]; then
#        echo "Student Essentials App closed by user"
#        exit
#    fi
# }

 function delete_contact(){

    deleteTask=$(yad --form --center --borders=10 --width=350 --height=300 --title="Linux Toolbox" --separator='ㅤ' --text-align=center --text="<span><b><big><big>Delete Contact</big></big></b></span>" \
    --field="<b>Enter Phone Number:</b>":LBL \
    --field="" \
    --button="Delete":0 \
    --button="Back":1 \ ) code=${?}


    if [ $code == 1 ]; then
        echo "Back to home window"
    elif [ $code == 0 ]; then
        echo "Delete TAsk: $deleteTask"
        entry_phone=$(echo $delete_string | awk -F "ㅤ" '{print $2}')
        full_string=$(grep -i "$entry_phone" contact_list.log)

    #     delete_via_phone=$(echo $full_string | awk '{print $5}')

    #     echo "Delete row: $delete_via_phone"

    #     if [ ! -z "$delete_via_phone" ]; then
    #             if [ $entry_phone == $delete_via_phone ]; then
                
    #                 sed -i -e "/$delete_via_phone/d" contact_list.log
    #                 echo "Contact deleted"
    #             else
    #                 phone_number_not_found
    #             fi
    #     else
    #         phone_number_not_found
    #     fi
    fi
}


function viewTask(){   
    echo "View Tasks"
    vTask=$(nl -s '. ' -w 1 task.log)
    $(yad --form --center --borders=10 --width=350 --height=300 --title="Student Essential App" --separator=' ' --text-align=center --scroll --text="<span><b><big><big>Task List</big></big></b></span>"\
    --field="":LBL \
    --field="$vTask":LBL \
    --button="Add":1 \
    --button="Delete":2 \
    --button="Back":0 \ )

    code=${?}
    
    if [ $code == 0 ]; then
        echo "Back to manage contact window"
    elif [ $code == 1 ]; then
        echo "Add Task"
        add_Task
    elif [ $code == 2 ]; then
        echo "Delete Task"
        deleteTask
    elif [ $code == 252 ]; then
        echo "Linux Toolbox closed by user"
        exit
    fi

}

function add_task(){

    taskNum=$(yad --form --center --borders=10 --width=500 --height=300 --title="Student Essential App" --separator='ㅤ' \
    --text-align=center --text="<span><b><big><big>Add New Task</big></big></b></span>"\
     --field="  <b>Task Num:</b>":LBL \
    --field="" \
    --field="  <b>Task Title:</b>":LBL \
    --field="" \
    --field="  <b>Date:</b>":LBL \
    --field="" \
    --button=Add:0 \
    --button=Back:1 \ )
    #  valid=${?}

    code=${?}

    if [ $code == 1 ]; then
        echo "Back to the contact window"
        ./student_app.sh
    elif [ $code == 0 ]; then
        echo "$taskNum"
        echo "Add task"

        t_title=$(echo $taskNum | awk -F "ㅤ" '{print $2}')
        date=$(echo $taskNum | awk -F "ㅤ" '{print $4}')
        break="------------------------------------------------"
        echo -e "Task Title: $t_title | Date: $date \n" >> task.log
        add_task
    fi
}



function toDoList(){
    while :
    do 
        task=$(yad --center --borders=10 --width=350 --height=300 --title="To Do List"  --separator=' ' --text-align=center --text="<span><b><big><big>Manage To Do List</big></big></b></span>"\
        --field="":LBL \
        --field="<b>Add:</b> Add a new Task.":LBL \
        --field="<b>Update:</b> Update a specific task.":LBL \
        --field="<b>View:</b> View the task list after adding one or more task to list.":LBL \
        --field="<b>Search:</b> Search a specific task.":LBL \
        --field="<b>Delete:</b> Delete a specific task.":LBL \
        --button="Back":0 \
        --button="Add":1 \
        # --button="Update":2 \
        # --button="View":3 \
        # --button="Delete":5 \
       ) 
       code=${?}

        # code=${?}
        if [ $code == 0 ]; then
        echo "back student app" 
            ./student_app.sh
        elif [ $code == 1 ]; then
            echo "Add task"
            add_task
        # elif [ $code == 2 ]; then
        #     echo "Update task"
        #     update_task
        # elif [ $code == 3 ]; then
        #     echo "View task"
        #     view_task
        # elif [ $code == 4 ]; then
        #     echo "Search task"
        #     search_task
        # elif [ $code == 5 ]; then
        #     echo "Delete task"
        #     delete_task
        elif [ $code == 252 ]; then
            echo "Student Essentials app closed by user"
            exit
        fi

       
    done
 

}


function home() {

    user=$(whoami)
    email=$(awk -F ":" '{print $1}' admin.log)
    date=$(date +"%d-%m-%y")
    time=$(date +"%H:%M:%S")

    yad --title="Student Essentials App" --center --borders=10 --width=450 --height=500 --text-align=center --separator="" \
        --text="<span><b>About Student Essentials App</b></span>" \
        --text="<span>This is an app made for as a helping hand as an student or others peoples. Here You can create your account by sign up then you can deep drive in this app by log in using your email and password. In this app you get an magical calculator , stopwatch, and also make your to do list and can manage it. </span>" --text-align=left \
        --form --separator="" \
        --field="<b>Username:</b> $user":LBL \
        --field="<b>Email:</b> $email":LBL \
        --field="<b>Date:</b> $date":LBL \
        --field="<b>Time:</b> $time":LBL \
        --button="Exit":0 \
        --button="To Do List":2 \
        --button="calculator":1 \
        --button="Logout":4 \

    code=${?}

    if [ $code == 0 ]; then
        echo "Student Essentials App closed by user"
        exit
    elif [ $code == 1 ]; then
        echo "Calculator"
        calculator
    elif [ $code == 2 ]; then
        echo "To DO List"
        toDoList
    elif [ $code == 4 ]; then
        echo "Logged out"
        rm loggedin.log
        ./student_app.sh
        exit
    elif [ $code == 252 ]; then
        echo "Student Essentials App closed by user"
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
 export -f task
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

