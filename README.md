### This script is used to perform the below activities. 

## 1. Create the pull request
## 2. Update the body of the created pull request with the PR number generated above.
## 3. Merge the pull request to destination branch.

### We have used Github provided APIs on this.  We are using Github personal access token to access the Github resources.

##---------------------------------------##
PREREQUISITES BEFORE EXECUTING THE SCRIPT
##---------------------------------------##

1. A github account 

2. Personal access token generated for your account (check below for the steps) 

### [Go to your GitHub profile --> settings --> developer settings --> Personal access token --> Generate new token]

3. A repository where you want to perform these activities. 

4. Make sure you have the Source and destination branches created inside the repo (For example master branch might be the destination & feature branch might be the source)

5. Make sure you install the utilities 'dos2unix' , 'jq' in your local laptop where you run this script


##------------##
EXECUTION STEPS
##------------##


1. Replace every keyword 'token' in your script with your PAT token generated above

3. Run the script as per the format below


### Use the below command to execute the script, this script takes three command line aruguments, those are github owner, repo name, and Branch name(i.e, the branch from which you want to create the pull request)

` sh create_update_merge_pull_request.sh <github owner name> <repo name> <source branch name> <destination name> `

