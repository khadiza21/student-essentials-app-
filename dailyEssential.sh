# !/bin/bash
# cd Desktop/GUB/OS_course/project/student_essentials_app/

FILE="admin.log"
LOGGEDIN="loggedin.log"

centerline(){
        local line="$1"
        local cli_w=$(tput cols)
        local t_len=${#line}
        local center=$(( (cli_w - t_len) / 2 ))
        printf "%*s" $center
        echo "$line"

}


create(){
    echo $liens
    centerline  "---Crete A New Book---"
    echo $lines
    read -p "Enter address book name: " ab
    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       echo "Error : file is already existing! "
    else 
       touch $ab 
       echo "Adress book created as $ab!"
    fi
}

display(){
    echo $liens
    centerline  "---Display Infor of a Book---"
    echo $lines
    read -p "Enter address book name: " ab
    echo $lines
    res=`ls | grep $ab | wc -w`
    echo $lines
    if [ $res -gt 0 ]
    then 
       cat $ab #display the content of the address book
    else 
       echo "Error: file is not existing!"
    fi
    echo $lies
}

insert(){
    echo $liens
    centerline  "---Insert new Info in a Book---"
    echo $lines
    read -p "Enter address book name: " ab
    #check address book is available or not in current working dir
    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       read -p "Enter email: " email
 


       #check email is present in address book or not
       len=`cat $ab | grep $email | wc -w`
       if [ $len -gt 0 ]
       then 
           echo "Error : Email already existing!"
        else 
           echo $lines
           echo "Enter First name , Last Name, Mobile number, Address, Blood Group, Relation with you"
           read fname lname mobile address bldgrp rltn
           record=`echo $fname $lname $mobile $address $bldgrp $rltn $email `
           echo $record >> $ab
           echo $lines
           echo "Record Inserted"
        fi
    else 
       echo "Error: file is not existing!"
    fi
}


modify(){
    echo $lines
    centerline  "---Modify data From a Book---"
    echo $lines
    read -p "Enter address book name: " ab

    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       echo $lines
       read -p "Enter email: " email

       len=`cat $ab | grep $email | wc -w`
       if [ $len -gt 0 ]
       then 
          echo "Enter Modified First name , Last Name, Mobile number, Address, Blood Group, Relation with you"
          read fname lname mobile address bldgrp rltn
          new=`echo $fname $lname $mobile $address $bldgrp $rltn $email`
          old=`cat $ab | grep $email`

          echo "Old Record : $old"
          echo "New Record : $new "

          sed -i s/"$old"/"$new"/g $ab 
          echo $lines
          echo "Record Modified!"
        else 
          
           echo "Error : Email not existing!"
        fi
    else 
       echo "Error: file is not existing!"
    fi
}



delete() {
    echo $liens
    centerline  "---Delete Info---"
    echo $lines
    read  -p "Enter address book name :" ab

    if [ -f "$ab" ]; then
        echo "Enter email:"
        read -r email

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


calorie(){
    echo $liens
    centerline  "---Calorie Measure---"
    echo $lines

    read -p "Enter age: " age
    read -p "Enter gender (male/female): " gender
    read -p "Enter height in centimeters: " height
    read -p "Enter weight in kilograms: " weight
    read -p "Enter activity level (sedentary/lightly active/moderately active/very active/extra active): " activity
    

    if [ "$gender" == "male" ]; then
        bmr=$(echo "scale=2; 66 + (6.23 * $weight) + (12.7 * $height) - (6.8 * $age)" | bc)
    else
        bmr=$(echo "scale=2; 655 + (4.35 * $weight) + (4.7 * $height) - (4.7 * $age)" | bc)
    fi
    
 
    case $activity in
        "sedentary")
            calories=$(echo "scale=2; $bmr * 1.2" | bc)
            ;;
        "lightly active")
            calories=$(echo "scale=2; $bmr * 1.375" | bc)
            ;;
        "moderately active")
            calories=$(echo "scale=2; $bmr * 1.55" | bc)
            ;;
        "very active")
            calories=$(echo "scale=2; $bmr * 1.725" | bc)
            ;;
        "extra active")
            calories=$(echo "scale=2; $bmr * 1.9" | bc)
            ;;
        *)
            echo "Invalid activity level."
            return
            ;;
    esac
    echo $lines
    echo "Your Daily calorie requirement: $calories calories"
    echo $lines


}

bmi(){
    echo $liens
    centerline  "---BMI Measure---"
    echo $lines
    read -p "Enter weight in kilograms: " weight
    read -p "Enter height in centimeters: " height
    bmi=$(echo "scale=2; $weight / (($height/100) * ($height/100))" | bc)
    echo $lines
    echo "Your BMI IS: $bmi"
    echo $lines

}


dectobin(){
    echo $liens
    centerline  "---Decimal TO Binary---"
    echo $lines
    read -p "Enter a decimal number: " decimal
    decimal_to_binary() {
    local num=$1
    local binary="" 
    while [ $num -gt 0 ]; do
        remainder=$((num % 2))
        binary="$remainder$binary"
        num=$((num / 2))
    done
    echo "$binary"
}
binary=$(decimal_to_binary $decimal)
echo $lines
echo "Binary representation the givig decimal vlaue: $binary"
echo $lines
}


tax(){
   echo $liens
   centerline  "---Tax Measure---"
   echo $lines
   read -p "Enter country: " country
   read -p "Enter tax rate: " tax_rate
   read -p "Enter income amount: " income  
   tax_amount=$(echo "scale=2; $income * $tax_rate / 100" | bc)  
   echo $lines
   echo "Tax amount for your $country is : $tax_amount"
   echo $lines
}



# currency_converter(){
# api_endpoint="https://v6.exchangerate-api.com/v6/a9b41dccb85d975339bc9553/latest/USD"
# api_key="a9b41dccb85d975339bc9553"

# get_exchange_rate() {
#   local base_currency=$1
#   local target_currency=$2
#   local api_url="${api_endpoint}?base=${base_currency}&symbols=${target_currency}&access_key=${api_key}"
#   local exchange_rate=$(curl -s "$api_url" | jq -r ".rates.${target_currency}")
#   echo "$exchange_rate"
# }
# }







calculator(){
    while [ true ]
do 
  echo $liens
  centerline  "---Calculator---"
  echo $lines
  echo "1. Calorie "
  echo "2. BMI "
  echo "3. Decimal to Binary "
  echo "4. Tax Calculator"
  echo "5. Back "
  echo $lines
  read -p "Enter Choice: " choice
  echo $lines

  echo $lines

  case $choice in 
         1) calorie ;;
         2) bmi ;;
         3) dectobin ;;
         4) tax ;;
         5) home ;;
         *) echo "Wrong Choice!";;
  esac
  echo $lines
done
}


addressBook(){

while [ true ]
do 
  echo $lines
  centerline "---Address Book---"
  echo $lines
  echo "1. Create Book "
  echo "2. DIsplay Info of a Book"
  echo "3. Insert Info in a Book "
  echo "4. Modify Info in a Book "
  echo "5. Delete Info in a Book "
  echo "6. Back "
  echo $lines
  read  -p "Enter Choice: " choice
  echo $lines

  case $choice in 
         1) create ;;
         2) display ;;
         3) insert ;;
         4) modify ;;
         5) delete ;;
         6) home ;;
         *) echo "Wrong Choice!";;
  esac

  echo $lines
done
}



home (){
    echo $lines
    FILE=$(pwd)/admin.log
    LOGGEDIN=$(pwd)/loggedin.log
    date=$(date +"%d-%m-%y")
    time=$(date +"%H:%M:%S")

     echo "Date of Today: $date"
     echo "Now Time is $time" 
    echo $lines

while [ true ]
do 
  echo $liens
  echo $liens
  echo $liens
  centerline "---MENU---"
  echo "1. Calculator "
  echo "2. Address Book "
  echo "3. Exit "
  echo $liens
  echo $lines 
  read -p "Enter Choice: " choice
  echo $lines
  echo $lines
  case $choice in 
         1) calculator ;;
         2) addressBook ;;
         3) exit ;;
         *) echo "Wrong Choice!";;
  esac
  echo $lines 
  echo $lines
  
done

}



echo $lines


function login() {
    echo $lines
    echo $liens
    echo $lines
    
    centerline "--Login on your accout--"
    echo $lines
    read -p "Enter your email:" email
    read -s -p "Enter your password:" password
    echo $lines 
    echo "Your typed email is = $email"
    echo "Your typed password is = $password"
    echo $lines

    if  grep -q "$email:$password" admin.log; then
        echo $lines
        echo "Login Successful"
        echo "$email:$password" > loggedin.log
        echo $lines
        echo $lines
        centerline "--Welcome to daily life essential tools--"
        home
    else
        echo $lines
        echo "Login Failed!"
        echo "Wrong email or password"
        echo $lines
        login
    fi

}

function signUp() {
    echo $lines
    echo $lines
    echo $lines
    
    centerline "---Create An Account---"
    echo $lines
    read -p  "Enter your email:" email
    read -s -p "Enter your password:" password
    echo $lines
    echo $lines
    echo "Your Email = $email"
    echo "Your Password = $password"
    echo "$email:$password" >> admin.log
    echo $liens
    echo "Congratulations!! Signup Successful!!"
    echo $lines
    echo $liens
    echo $lines
    login
}



if [ -f "$FILE" ]; then
    # while :
    # do
    #     if [ -f "$LOGGEDIN" ]; then
    #         echo "User already logged in"
    #         home
    #     else
    #         login
    #     fi
    # done
    login
else
    signUp
fi


