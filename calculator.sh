# !/bin/bash

create(){
    echo "Enter address book name"
    read ab
    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       echo "Error : file is already existing! "
    else 
       touch $ab 
       echo "Adress book created!"
    fi
}

display(){
    echo "Enter address book name"
    read ab
    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       cat $ab
    else 
       echo "Error: file is not existing!"
    fi
}

insert(){
    echo "Enter address book name"
    read ab
    #check address book is available or not in current working dir
    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       echo "Enter email"
       read email

       #check email is present in address book or not
       len=`cat $ab | grep $email | wc -w`
       if [ $len -gt 0 ]
       then 
           echo "Error : Email already existing!"
        else 
           echo "Enter First name , Last Name, Mobile number"
           read fname lname mobile
           record=`echo $fname $lname $email $mobile`
           echo $record >> $ab
           echo "Record Inserted"
        fi
    else 
       echo "Error: file is not existing!"
    fi
}


modify(){
    echo "Enter address book name"
    read ab
    #check address book is available or not in current working dir
    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       echo "Enter email"
       read email

       #check email is present in address book or not
       len=`cat $ab | grep $email | wc -w`
       if [ $len -gt 0 ]
       then 
          echo "Enter Modified first name, last name mobile"
          read fname lname mobile
          new=`echo $fname $lname $mobile`
          old=`cat $ab | grep $email`

          echo "Old Record : $old"
          echo "New Record : $new "

          sed -i s/"$old"/"$new"/g $ab 
     
          echo "Record Modified!"
        else 
          
           echo "Error : Email not existing!"
        fi
    else 
       echo "Error: file is not existing!"
    fi
}



delete() {
    echo "Enter address book name:"
    read -r ab

    # Check if the address book is available or not in the current working directory
    if [ -f "$ab" ]; then
        echo "Enter email:"
        read -r email

        # Check if the email is present in the address book or not
        if grep -q "$email" "$ab"; then
            sed -i "/$email/d" "$ab"
            echo "Record Deleted!"
        else
            echo "Error: Email not found!"
        fi
    else
        echo "Error: File not found!"
    fi
}


calculator(){
    while [ true ]
do 
  echo "---------MENU-------"
  echo "1. arithmetic "
  echo "2. BMI "
  echo "3. Currency Converter "
  echo "4. Decimal to Binary "
  echo "5.  "
  echo "7. Back "
  echo "Enter Choice"
  read choice

  case $choice in 
         1) create ;;
         2) display ;;
         3) insert ;;
         4) modify ;;
         5) delete ;;
         7) home ;;
         *) echo "Wrong Choice!";;
  esac
done
}
addressBook(){

while [ true ]
do 
  echo "---------MENU-------"
  echo "1. Create "
  echo "2. DIsplay "
  echo "3. Insert Record "
  echo "4. Modify Record "
  echo "5. Delete Record "
  echo "7. Back "
  echo "Enter Choice"
  read choice

  case $choice in 
         1) create ;;
         2) display ;;
         3) insert ;;
         4) modify ;;
         5) delete ;;
         7) home ;;
         *) echo "Wrong Choice!";;
  esac
done
}
home (){
while [ true ]
do 
  echo "---------MENU-------"
  echo "1. Calculator "
  echo "2. Address Book "
  echo "3. Exit "
  echo "Enter Choice"
  read choice

  case $choice in 
         1) calculator ;;
         2) addressBook ;;
         3) exit ;;
         *) echo "Wrong Choice!";;
  esac
done

}
home