#!/bin/bash

#############################################################################################
# author: Asel Sathkumara
# date: 02/13/2021
#
# Usage
# --------
# If you do not have permission to execute this bash, run the following command:
#	chmod +x create_Makefile.sh
#
# After permission is granted, you can either:
#	1) Run it in the same directory as your program, and pass in the name of your assembly#		 file (without the .s extension)
#	        create_Makefile.sh (assembly file name)
#
#	2) Run it, and pass in the name of your assembly file (without the .s extension) and 
#	   pass in the path for the Makefile
#		create_Makefile.sh (assembly file name) (destination)
#	
#
#
#############################################################################################

# Creates a makefile for the given src file in the working directory, or the given the destination.
create_Makefile()
{
	fileName=$1
	filePath=$2

	declare -a Lines

	Lines+=("all:$fileName")
	Lines+=("")

	Lines+=("add:$fileName.o")
	Lines+=("	gcc -o $fileName $fileName.o")

	Lines+=("add.o:$fileName.s")
	Lines+=("	as -o $fileName.o $fileName.s")

	Lines+=("clean:")
	Lines+=("	rm -rf $fileName *.o")

	printf "%s\n" "${Lines[@]}" > $filePath
}

if [ $# -eq 0 ]; then
	echo "Error: Must pass one paramater at minimum."

elif [ $# -eq 1 ]; then
	fileName=$1
	filePath=$(pwd)/Makefile
	
	create_Makefile $fileName $filePath

elif [ $# -eq 2 ]; then
	fileName=$1
	filePath=$2/Makefile
	
	create_Makefile $fileName $filePath

else
	echo "Error: Invalid number of arguments. Only two arguments allowed."

fi
