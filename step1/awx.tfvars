instance_type		=	"t2.medium"
key_name		=	"terraform"
ami			=	"ami-0ff760d16d9497662"    #Use Centos7  image
vpc_id			=	"vpc-908caaf6"
user			=	"centos"
ssh_key_location	=	"/root/.ssh/id_rsa"        #Import pub key pair to aws as "terraform"
