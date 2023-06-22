#!/bin/bash

FILE=$(pwd)/admin.log
LOGGEDIN=$(pwd)/loggedin.log

# bash functions start
#calendar window
# function calendar(){
#    yad --center --borders=10 --width=420 --title="Linux Toolbox - Calendar" --calendar --button=Back:0

#    if [ ${?} -eq 252 ]; then
#        echo "Linux Toolbox closed by user"
#        exit
#    fi
# }

# function view_all_note() {
#     echo "View all note"

#     # Get all note from file
#     note_file=$(pwd)/notebook.txt

#     if [ -f "$note_file" ]; then
#         note_text=$(cat notebook.txt)
#         notebook=$(yad --scroll --width=450 --height=500 --title="Linux Toolbox - Notebook" --borders=10 --center --separator="ㅤ" \
#         --text-align=center \
#         --text="<span><b><big><big>My Notes</big></big></b></span>" \
#         --form \
#         --field="$note_text":LBL \
#         --button="Back:0" \
#         )
#         btn_click=$?

#         if [ $btn_click == 0 ]; then
#             echo "Back to Notebook"
#         elif [ $btn_click == 252 ]; then
#             echo "Linux Toolbox closed by user"
#             exit
#         fi
#     else
#         echo "No note found"
#         notebook=$(yad --scroll --width=450 --height=500 --title="Linux Toolbox - Notebook" --borders=10 --center --separator="ㅤ" \
#         --text-align=center \
#         --text="<span><b><big><big>My Notes</big></big></b></span>" \
#         --form \
#         --field="No note found":LBL \
#         --button="Back:0" \
#         )
#         btn_click=$?

#         if [ $btn_click == 0 ]; then
#             echo "Back to Notebook"
#         elif [ $btn_click == 252 ]; then
#             echo "Linux Toolbox closed by user"
#             exit
#         fi
#     fi
# }

# function notebook(){

#     while :
#     do
#         notebook=$(yad --width=450 --height=500 --title="Linux Toolbox - Notebook" --borders=10 --center --separator="ㅤ" \
#         --text-align=center \
#         --text="<span><b><big><big>Create Your Note</big></big></b></span>" \
#         --form --field="<b>Title</b>": \
#         --field="":TXT \
#         --button="Add:2" \
#         --button="View:3" \
#         --button="Back:0" \
#         )
#         btn_click=$?

#         if [ $btn_click == 0 ]; then
#             echo "Back to home"
#             break
#         elif [ $btn_click == 2 ]; then
#             title=$(echo $notebook | awk -F "ㅤ" '{print $1}')
#             notebook=$(echo $notebook | awk -F "ㅤ" '{print $2}')
#             break="\n----------------------------------------------------------------------------------------------------------\n"
#             echo "Title: $title\nNote: $notebook $break" >> notebook.txt
#             echo "Note added"
#         elif [ $btn_click == 3 ]; then
#             echo "View Note"
#             view_all_note
#         fi
#     done
# }

# contact window start
# function add_contact(){

#     contact_value=$(yad --form --center --borders=10 --width=380 --height=280 --title="Linux Toolbox" --separator='ㅤ' \
#     --text-align=center --text="<span><b><big><big>Add Contact</big></big></b></span>"\
#     --field="  <b>Name:</b>":LBL \
#     --field="" \
#     --field="  <b>Phone:</b>":LBL \
#     --field="" \
#     --field="  <b>Email:</b>":LBL \
#     --field="" \
#     --button=Add:0 \
#     --button=Back:1 \ ) valid=${?}

#     code=${?}

#     if [ $code == 1 ]; then
#         echo "Back to the contact window"
#     elif [ $code == 0 ]; then
#         echo "$contact_value"
#         echo "Add contact"

#         name=$(echo $contact_value | awk -F "ㅤ" '{print $2}')
#         phone=$(echo $contact_value | awk -F "ㅤ" '{print $4}')
#         email=$(echo $contact_value | awk -F "ㅤ" '{print $6}')
#         break="------------------------------------------------"
#         echo -e "Name: $name | Phone: $phone | Email: $email\n" >> contact_list.log
#         add_contact
#     fi
# }

# function phone_number_not_found(){
#     echo "Phone number not found"
#     $(yad --center --borders=10 --width=350 --height=300 --title="Linux Toolbox" --text="<span><b><big><big>Phone number not found</big></big></b></span>" \
#     --button="Back":1 \ )
#     code=${?}

#     if [ $code == 1 ]; then
#         echo "Back to home window"
#     elif [ $code == 252 ]; then
#         echo "Linux Toolbox closed by user"
#         exit
#     fi
# }

# function update_contact(){

#     echo "Update contact"

#     update_string=$(yad --form --center --borders=10 --width=350 --height=300 --title="Linux Toolbox" --separator='ㅤ' --text-align=center --text="<span><b><big><big>Update Contact</big></big></b></span>" \
#     --field="<b>Old Phone:</b>":LBL \
#     --field="" \
#     --field="<b>New Name:</b>":LBL \
#     --field="" \
#     --field="<b>New Phone:</b>":LBL \
#     --field="" \
#     --field="<b>New Email:</b>":LBL \
#     --field="" \
#     --button="Update":0 \
#     --button="Back":1 \ )

#     code=${?}

#     if [ $code == 1 ]; then
#         echo "Back to home window"
#     elif [ $code == 0 ]; then
#         echo "Update string: $update_string"
        
#         old_phone=""
        

#         entry_phone=$(echo $update_string | awk -F "ㅤ" '{print $2}')
#         full_string=$(grep -i "$entry_phone" contact_list.log)
    
#         old_name=$(echo $full_string | awk '{print $2}')
#         old_phone=$(echo $full_string | awk '{print $5}')
#         old_email=$(echo $full_string | awk '{print $8}')

#         echo "Full string: $full_string"
#         echo "Old phone: $old_phone"
#         echo "Entry phone: $entry_phone"

#         if [ ! -z "$old_phone" ]; then
#             if [ $entry_phone == $old_phone ]; then
#                 echo "Phone number found"

#                 new_name=$(echo $update_string | awk -F "ㅤ" '{print $4}')
#                 new_phone=$(echo $update_string | awk -F "ㅤ" '{print $6}')
#                 new_email=$(echo $update_string | awk -F "ㅤ" '{print $8}')

#                 if [ ! -z "$new_name" ]; then
#                     sed -i "s/$old_name/$new_name/g" contact_list.log
#                 fi
#                 if [ ! -z "$new_phone" ]; then
#                     sed -i "s/$old_phone/$new_phone/g" contact_list.log
#                 fi
#                 if [ ! -z "$new_email" ]; then
#                     sed -i "s/$old_email/$new_email/g" contact_list.log
#                 fi
#                 echo "Contact Updated"
#             else
#                 phone_number_not_found
#             fi
#         else
#             phone_number_not_found
#         fi
#     elif [ $code == 252 ]; then
#         echo "Linux Toolbox closed by user"
#         exit
#     fi
# }

# function view_contact(){
    
#     echo "View contact"
#     v_contact=$(nl -s '. ' -w 1 contact_list.log)

#     $(yad --form --center --borders=10 --width=350 --height=300 --title="Linux Toolbox" --separator=' ' --text-align=center --scroll --text="<span><b><big><big>Contact List</big></big></b></span>"\
#     --field="":LBL \
#     --field="$v_contact":LBL \
#     --button="Add":1 \
#     --button="Update":2 \
#     --button="Search":3 \
#     --button="Delete":4 \
#     --button="Back":0 \ )

#     code=${?}
    
#     if [ $code == 0 ]; then
#         echo "Back to manage contact window"
#     elif [ $code == 1 ]; then
#         echo "Add contact"
#         add_contact
#     elif [ $code == 2 ]; then
#         echo "Update contact"
#         update_contact
#     elif [ $code == 3 ]; then
#         echo "Search contact"
#         search_contact
#     elif [ $code == 4 ]; then
#         echo "Delete contact"
#         delete_contact
#     elif [ $code == 252 ]; then
#         echo "Linux Toolbox closed by user"
#         exit
#     fi

# }

# function search_contact (){

#     echo "Search contact"

#     search_field=$(yad --form --center --borders=10 --width=350 --height=300 --title="Linux Toolbox" --separator=' ' --text-align=center --text="<span><b><big><big>Search Contact</big></big></b></span>" \
#     --field="":LBL \
#     --field="" \
#     --button="Search":0 \
#     --button="Back":1 \ ) code=${?}

#     code=${?}

#     if [ $code == 1 ]; then
#         echo "Back to home window"
#     elif [ $code == 0 ]; then
#         echo "Search query: $search_field"
#         contact_find $search_field
#     elif [ $code == 252 ]; then
#         echo "Linux Toolbox closed by user"
#         exit
#     fi
# }

# function contact_find {
#     echo "Find contact"
#     search=$(grep -i $1 contact_list.log)
#     find_field=$(yad --form --center --borders=10 --width=450 --height=300 --scroll --title="Linux Toolbox" --separator=' ' --text-align=center --text="<span><b><big><big>Search Contact</big></big></b></span>"\
#     --field="<b>Search Query:</b> $1\n\n<b>Result:</b>":LBL \
#     --field="$search":LBL \
#     --button="Back":1 \ ) code=${?}

#     code=${?}

#     if [ $code == 1 ]; then
#         echo "Back to home window"
#     elif [ $code == 252 ]; then
#         echo "Linux Toolbox closed by user"
#         exit
#     fi
# }

# function delete_contact(){

#     delete_string=$(yad --form --center --borders=10 --width=350 --height=300 --title="Linux Toolbox" --separator='ㅤ' --text-align=center --text="<span><b><big><big>Delete Contact</big></big></b></span>" \
#     --field="<b>Enter Phone Number:</b>":LBL \
#     --field="" \
#     --button="Delete":0 \
#     --button="Back":1 \ ) code=${?}


#     if [ $code == 1 ]; then
#             echo "Back to home window"
#     elif [ $code == 0 ]; then

#         echo "Delete string: $delete_string"
        
#         entry_phone=$(echo $delete_string | awk -F "ㅤ" '{print $2}')
#         full_string=$(grep -i "$entry_phone" contact_list.log)

#         delete_via_phone=$(echo $full_string | awk '{print $5}')

#         echo "Delete row: $delete_via_phone"

#         if [ ! -z "$delete_via_phone" ]; then
#                 if [ $entry_phone == $delete_via_phone ]; then
                
#                     sed -i -e "/$delete_via_phone/d" contact_list.log
#                     echo "Contact deleted"
#                 else
#                     phone_number_not_found
#                 fi
#         else
#             phone_number_not_found
#         fi
#     fi
# }
# contact window end

# function contact(){
    
#     while :
#     do
#         contact=$(yad --form --center --borders=10 --width=350 --height=300 --title="Linux Toolbox" --separator=' ' --text-align=center --text="<span><b><big><big>Manage Contacts</big></big></b></span>"\
#         --field="":LBL \
#         --field="<b>Add:</b> Add contact information. i.e: Name, Email Address, and Phone Number.":LBL \
#         --field="<b>Update:</b> Update a specific contact.":LBL \
#         --field="<b>View:</b> View the contact list after adding one or more contact to list.":LBL \
#         --field="<b>Search:</b> Search a specific contact.":LBL \
#         --field="<b>Delete:</b> Delete a specific contact.":LBL \
#         --button="Add":1 \
#         --button="Update":2 \
#         --button="View":3 \
#         --button="Search":4 \
#         --button="Delete":5 \
#         --button="Back":0 \ ) code=${?}

#         code=${?}
        
#         if [ $code == 0 ]; then
#             echo "Contact window closed by user"
#             ./linux_toolbox.sh
#             exit
#         elif [ $code == 1 ]; then
#             echo "Add contact"
#             add_contact
#         elif [ $code == 2 ]; then
#             echo "Update contact"
#             update_contact
#         elif [ $code == 3 ]; then
#             echo "View contact"
#             view_contact
#         elif [ $code == 4 ]; then
#             echo "Search contact"
#             search_contact
#         elif [ $code == 5 ]; then
#             echo "Delete contact"
#             delete_contact
#         elif [ $code == 252 ]; then
#             echo "Linux Toolbox closed by user"
#             exit
#         fi
#     done
# }

function home(){

    date=$(date +'%A %B %d, %Y')
    time=$(date +'%l:%M:%S %p')
    user=$(whoami)
    email=$(awk -F ":" '{print $1}' admin.log)
  

    yad --title="Linux Toolbox" --center --borders=10 --width=450 --height=500 --text-align=center --separator="" --text="<span><b><big><big>System Info</big></big></b></span>" \
    --field="":LBL \
    --form \
    --field="<b><u>Basic Info</u></b>":LBL \
    --field="<b>Date:</b> $date":LBL \
    --field="<b>Time:</b> $time":LBL \
    --field="<b>Username:</b> $user":LBL \
    --field="<b>Email:</b> $email":LBL \
    --field="":LBL \
    --field="Calendar":FBTN "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "./calendar.sh" \
    --button="Notebook":2 \
    --button="Contact":3 \
    --button="Refresh":1 \
    --button="Log out":4 \
    --button="Exit":0
    code=${?}

    if [ $code == 0 ]; then
        echo "Linux Toolbox closed by user"
        exit
    elif [ $code == 1 ]; then
        echo "Refresh Date: $date $time"
    elif [ $code == 2 ]; then
        echo "Notebook window"
        notebook
    elif [ $code == 3 ]; then
        echo "Contact window"
        contact
    elif [ $code == 4 ]; then
        echo "Logged out"
        rm loggedin.log
        ./linux_toolbox.sh
        exit
    elif [ $code == 252 ]; then
        echo "Linux Toolbox closed by user"
        exit
    fi
}

export -f calendar home notebook view_all_note contact add_contact view_contact search_contact contact_find update_contact phone_number_not_found delete_contact
# bash functions end

 [ -f "$FILE" ]
then
    while :
    do
        
        if [ -f "$LOGGEDIN" ]
        then
            old_usr_pass=$(cat admin.log)
            log_usr_pass=$(cat loggedin.log)

            if [ $old_usr_pass == $log_usr_pass ]
            then
                # If the user has already logged in, redirected in home page
                echo "User already logged in"
                home
            else
                rm loggedin.log
                echo "User not logged in"
            fi
        else
            # login window start
            echo "Login window..."
            # login window
            login=$(yad --form --center --borders=10 --width=400 --height=300 --title="Linux Toolbox - Login" --separator=' ' \
                --button="Calendar":"bash -c calendar" \
                --button=Exit:1 \
                --button=Login:0 \
                --field="Email":\
                --field="Password":\') valid=${?}

            if [ $valid -eq 0 ]; then

                email=$(echo $login | awk '{print $1}') 
                password=$(echo $login | awk '{print $2}')

                echo "Email = $email"
if
            elif [ $valid -eq 1 ]; then
                echo "Linux Toolbox closed by user"
                exit
            fi
            # login window end

            echo -e "$email:$password" >> temp.log

            old_usr_pass=$(cat admin.log)
            crnt_usr_pass=$(cat temp.log)

            if [ $old_usr_pass == $crnt_usr_pass ]
            then
                rm temp.log
                echo "Login Successful"
                echo "$email:$password" >> loggedin.log
                # login success window start
                home
                # login success window end
            else
                rm temp.log
                # login failed window start
                echo "Login Failed!"
                echo "Wrong email or password"
                # login failed window end
            fi

        fi

    done

else
    # create admin.log file start
    echo "Signup window..."

    # signup window
    signup=$(yad --form --center --borders=10 --width=350 --height=300 --title="Linux Toolbox - Signup" --separator=' ' --text-align=center --text="<span><b><big><big>Signup</big></big></b></span>"\
        --field="":LBL \
        --button="Calendar":"bash -c calendar" \
        --button=Exit:1 \
        --button=Signup:0 \
        --field="Email":\
        --field="Password":\') valid=${?}

    if [ $valid -eq 0 ]; then

        email=$(echo $signup | awk '{print $1}') 
        password=$(echo $signup | awk '{print $2}')

        echo "Email = $email"
        # echo "Password = $password"

        echo "$email:$password" >> admin.log
        # create admin.log file end

        ./linux_toolbox.sh

    elif [ $valid -eq 1 ]; then
        echo "Linux Toolbox closed by user"
        exit
    fi
    
fi