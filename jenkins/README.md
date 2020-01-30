# Jenkins Module
![JenkinsLogo](https://github.com/farrukh90/infrastructure/blob/master/jenkins/images/Jenkinslogo.png)
### This module is used for creating Jenkins environment
## Prerequisites
1. Terraform 0.11.14

### Steps

```
git clone https://github.com/farrukh90/infrastructure.git
cd infrastructure/jenkins/
ls configurations
```

### Region
Choose the region you would like to work with. In my case I chose to work with us-east-1. However this is not required you can choose any region. Change below items according to your own AWS account


```
vi configurations/YOUR_REGION/jenkins.tfvars

s3_bucket                       =   "YOUR_BUCKET"         
s3_folder_region                =   "YOUR_BUCKET_REGION"               
vpc_id                          =   "YOUR_VPC_ID"            
zone_id                         =   "YOUR_Z32OHGRMBVZ9LR"       
domain                          =   "YOUR_DOMAIN"
region                          =   "YOUR_REGION"
```





### Environment Setup
Once above changes are done save the file and run 
```
source setenv.sh configurations/YOUR_REGION/jenkins.tfvars
```

It will set a proper backend.tf file for us. Next run (by changing region of course):


```
terraform apply -var-file configurations/YOUR_REGION/jenkins.tfvars
```




### Output
![Output](https://github.com/farrukh90/infrastructure/blob/master/jenkins/images/output.png)



## Known Errors
---
### Error 1
![Output](https://github.com/farrukh90/infrastructure/blob/master/jenkins/images/Errors.JPG)
#### When you see Above error, please run 
```
ssh-keygen      #Enter 4 times
```




---
### Error 2 
![Output](https://github.com/farrukh90/infrastructure/blob/master/jenkins/images/RegionError.PNG)

#### When you see above error it means you gave the wrong region for the bucket. Please check bucket's region

---
### Error 3
![Output](https://github.com/farrukh90/infrastructure/blob/master/jenkins/images/TerraforVersionError.png)
#### When you see above error it means you are using the wrong version of terraform. Please download 0.11.14 [link is here](https://releases.hashicorp.com/terraform/0.11.14/)

---


### Error 4
![Output](https://github.com/farrukh90/infrastructure/blob/master/jenkins/images/Timeout.png)
#### When you see above error it means AWS is taking some time to update Route53 entry. It is safe to rerun apply command. Also verify if you put the proper domain in tfvars file

---