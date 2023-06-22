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
           echo "Enter First name , Last Name, Mobile number, Address, Blood Group, Relation with you"
           read fname lname mobile address bldgrp rltn
           record=`echo $fname $lname $email $mobile $address $bldgrp $rltn`
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

    res=`ls | grep $ab | wc -w`

    if [ $res -gt 0 ]
    then 
       echo "Enter email"
       read email

       len=`cat $ab | grep $email | wc -w`
       if [ $len -gt 0 ]
       then 
          echo "Enter Modified First name , Last Name, Mobile number, Address, Blood Group, Relation with you"
          read fname lname mobile address bldgrp rltn
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
    
    echo "Estimated daily calorie requirement: $calories calories"



}

bmi(){
    read -p "Enter weight in kilograms: " weight
    read -p "Enter height in centimeters: " height
    bmi=$(echo "scale=2; $weight / (($height/100) * ($height/100))" | bc)
    echo "Your BMI IS: $bmi"
}


dectobin(){
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
echo "Binary representation the givig decimal vlaue: $binary"
}


tax(){
   read -p "Enter country: " country
   read -p "Enter tax rate: " tax_rate
   read -p "Enter income amount: " income  
   tax_amount=$(echo "scale=2; $income * $tax_rate / 100" | bc)
    
   echo "Tax amount for your $country is : $tax_amount"
}



# currency(){
# api_endpoint="https://v6.exchangerate-api.com/v6/a9b41dccb85d975339bc9553/latest/USD"
# api_key="a9b41dccb85d975339bc9553"

# get_exchange_rate() {
#   local base_currency=$1
#   local target_currency=$2
#   local api_url="${api_endpoint}?base=${base_currency}&symbols=${target_currency}&access_key=${api_key}"
#   local exchange_rate=$(curl -s "$api_url" | jq -r ".rates.${target_currency}")
#   echo "$exchange_rate"
# }

# show_conversion_dialog() {
#   local country_list=("Country 1" "Country 2" "Country 3")  
#   local selected_country
#   local base_currency
#   local target_currency
#   local amount

#   selected_country=$(yad --title "Currency Converter" --text "Select your country:" --list --column="Country" "${country_list[@]}" --width 300 --height 200)

#   if [[ $? -ne 0 ]]; then
#     exit
#   fi

#   amount=$(yad --title "Currency Converter" --text "Enter amount in your local currency:" --entry --width 300)


#   if [[ $? -ne 0 ]]; then
#     exit
#   fi

#   case $selected_country in
#     "Country 1")
#       base_currency="USD"
#       target_currency="EUR"
#       ;;
#     "Country 2")
#       base_currency="USD"
#       target_currency="GBP"
#       ;;
#     "Country 3")
#       base_currency="USD"
#       target_currency="JPY"
#       ;;
#     *)  # Default values if no match is found
#       base_currency="USD"
#       target_currency="EUR"
#       ;;
#   esac
#   exchange_rate=$(get_exchange_rate "$base_currency" "$target_currency")
#   converted_amount=$(bc <<< "$amount * $exchange_rate")
#   yad --title "Currency Converter" --text "Conversion Result:\n$amount $base_currency = $converted_amount $target_currency" --width 400 --height 200 --button="OK:0"
# }
# show_conversion_dialog
# }






calculator(){
    while [ true ]
do 
  echo "---------MENU-------"
  echo "1. Calorie "
  echo "2. BMI "
  echo "3. Decimal to Binary "
  echo "4. Tax Calculator"
  echo "5. Back "
  echo "Enter Choice"
  read choice

  case $choice in 
         1) calorie ;;
         2) bmi ;;
         3) dectobin ;;
         4) tax ;;
         5) home ;;
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
  echo "6. Back "
  echo "Enter Choice"
  read choice

  case $choice in 
         1) create ;;
         2) display ;;
         3) insert ;;
         4) modify ;;
         5) delete ;;
         6) home ;;
         *) echo "Wrong Choice!";;
  esac
done
}



home (){
    date=$(date +"%d-%m-%y")
    time=$(date +"%H:%M:%S")

     echo "Date of Today: $date"
     echo "Now Time is $time" 


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

echo "Welcome to daily life essential tools"
home