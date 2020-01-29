# Below code is used to set backend only
environment                     =   "tools"
s3_bucket                       =   "acirrustech-iaac"
s3_folder_project               =   "jenkins"
s3_folder_region                =   "us-east-1"
s3_folder_type                  =   "tools"
s3_tfstate_file                 =   "jenkins.tfstate"


instance_type		            =	"t2.medium"
key_name	    	            =	"jenkins"
vpc_id		    	            =	"vpc-1471ad6e"
user		    	            =	"centos"
ssh_key_location	            =	"/root/.ssh/id_rsa"        #Import pub key pair to aws as "terraform"
zone_id			                =	"Z32OHGRMBVZ9LR"	   #Add hosted DNS zone ID here
domain			                =	"acirrustech.com"
region 			                = 	"us-east-1"
