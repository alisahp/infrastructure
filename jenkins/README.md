# README.md

# Jenkins Module
## This module is used for creating Jenkins environment

### Steps
* Clone Repo
* cd infrastructure/jenkins/
    * ls configurations      

Choose the region you would like to work with in my case I chose to work with us-east-1. However this is not required you can choose any region 
* vi configurations/us-east-1/jenkins.tfvars
* edit Below items only
	* s3_bucket                       =   "acirrustech-iaac"
	* s3_folder_region                =   "us-east-1"
	* vpc_id                          =   "vpc-1471ad6e"
	* zone_id                         =   "Z32OHGRMBVZ9LR"       
	* domain                          =   "acirrustech.com"
	* region                          =   "us-east-1"

