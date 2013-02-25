#!/bin/bash
# This script moves larges numbers of files to a destination
# folder based off of an expression
#
# WILL NOT MOVE FOLDERS
#
# parameter 1: directory containing files
# parameter 2: destination folder
# parameter 3: file expression
#
# AUTHOR: JONNY YORK 02/10/13
# VERSION 1.1
#
# If by some magic you have obtained a copy of this script,
# you may modify and redistribute it as you see fit.
#
# This software comes with no warantee or any garauntee.
# Use with caution. The author will not be held liable
# for any damages or loss of data that may occur when using
# this software.

DIRECTORY=$1
DESTINATION=$2
EXPRESSION=$3

# check to see if the specified directory exists
if [ -d $DIRECTORY ] ; then
	if [ ! -d $DESTINATION ] ; then
		# directory does not exist
		echo "$DESTINATION, does not exist."
                echo "would you like to create the directory? (y/n)"
                read ANS
                if [ $ANS == y ] ; then
			# create the directory for the user
                        echo "creating directory $DESTINATION"
			mkdir -pv $DESTINATION
                fi
	fi
	if [ -d $DESTINATION ] ; then
		# the destination exists so moving files
		echo "moving files for you"
		echo "destination: $DESTINATION"
		for i in $DIRECTORY/* ; do
			if [ -z $EXPRESSION ] ; then
				# move all files in folder
				# don't want to move directories
				if [ -e "$i" ] ; then
					mv "$i" $DESTINATION
					echo "MOVED: $i"
				else
					echo "cannot move $i"
				fi
			else
				# move only files that have the regex
				if [ -e "$i" ] ; then
					# the filename has to have the exact expression
					# somewhere in the file
					file=$(echo "$i" | sed -n /$EXPRESSION/p)
					if [ ! -z "$file" ] ; then 
						mv "$file" $DESTINATION
						echo "MOVED: $file"; fi
				else
					echo "cannot move $i"
				fi
			fi
		done
	fi
else
	echo "$DIRECTORY, does not exist."
	echo "stopping script"
fi

echo "exiting"
