#!/bin/bash

# This script is used to create, update and merge the pull request from the feature branch to master branch
# We are using the Github APIs to create,update and merge the pull request

# Use the below command to execute the script, this script takes three command line aruguments, those are github owner, repo name, and Branch name(i.e, the branch from which you want to create the pull request)

# eg: sh create_update_merge_pull_request.sh <github owner> <repo name> <branch name> <destination branch name> 


if [ $# -eq 0 ]
then
	echo "Please run the script with below command line aruguments github owner, repo name, source branch and destination branch as aruguments to the script 
	eg: sh create_update_merge_pull_request.sh <github owner> <repo name> <source branch name> <destination branch>"
else 
		

	## To check the branch 

	curl -s -o /dev/null -I -w "%{http_code}" "Authorization: Bearer <token>" https://api.github.com/repos/$1/$2/branches/$3 > branch_check.txt

	if [ $(cat branch_check.txt | tail -1) == 200 ]
	then
		echo "check if both source and destination branches exists on github"

		# Create the pull request and store the pull request number into a file. 

		curl -X POST -H "Authorization: Bearer <token>" https://api.github.com/repos/$1/$2/pulls -d '{"title":"Pull Request to master","body":"test number","head":"'"$3"'","base":"'"$4"'"}' | jq -r '.number' > pullrequest_number.txt

		# above curl with the jq command writes the output in a CRLF line terminators format, to remove that format and making only ASCII format

		dos2unix pullrequest_number.txt

		# To read the pull request number form the above file 

		pull_request_number=$(cat pullrequest_number.txt)

		echo $pull_request_number

		# To update the above created pull request body

		curl -X POST -H "Authorization: Bearer <token>" https://api.github.com/repos/$1/$2/pulls/$pull_request_number -d '{"title":"Pull Request to master", "body":"'"$pull_request_number"'", "state":"open","base":"'"$4"'"}'

		echo "****************pull request body updated with the pull request number*************"

		# To merge the Pull request 

		echo https://api.github.com/repos/$1/$2/pulls/$pull_request_number/merge

		curl -X PUT -H "Authorization: Bearer <token>" https://api.github.com/repos/$1/$2/pulls/$pull_request_number/merge

		echo "Pull request merged to master branch"

	else
		echo "The source branch doesn't exists on the Github, please make sure to create the branch before executing the script"

	fi

fi
