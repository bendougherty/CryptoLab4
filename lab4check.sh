#!/bin/bash

#display help information
help()
{
echo
echo "This script should be in the same directory as your students' namemessage.txt.sha256 and namepubkey.pem files. In the parent directory there should be a directory called lab1docs which contains your students' namemessage.txt files (submitted to you by students after Crypto Lab 1, and the txt file was decrypted). This script takes one argument which should be a text file that contains the names of your students (the name they are using for naming their files) one per line. The script will iterate through the student names in the file verifying the digital signatures; it will display name: Verified OK if it works or name: Not Verified if it does not work."
echo
echo "Syntax: lab2check.sh [-h] namefile"
echo
echo "options:"
echo
echo "h      Print this help"
echo
}

#Get options
while getopts ":h" option; do
   case $option in
      h) #Display help
         help
         exit;;
     \?) #incorrect option
         echo "Error: Invalid option"
	 exit;;
   esac
done

if [[ $# -eq 0 ]]
then
   echo "You must provide a file with a list of student names. See -h for more information."
   exit 1
fi

filename=$1
while read line; do
fileone="${line}pubkey.pem"
filetwo="${line}message.txt.sha256"
filethree="${line}message.txt"
cp ../lab1docs/$filethree ./
echo -n "${line}: " >> classLab4Results.txt
openssl dgst -sha256 -verify $fileone -signature $filetwo $filethree >> classLab4Results.txt
echo >> classLab4Results.txt
rm $filethree
done < $filename
