resource "aws_security_group" "allow_ssh_and_jenkins" {
  name        = "allow_ssh_and_jenkins"
  description = "Allow SSH and jenkins"
  vpc_id      = "${var.vpc_id}"


  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group_rule" "allow_all_ingress" {
  type            = "ingress"
  from_port       = 0
  to_port         = 65535
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]                            
  security_group_id = "${aws_security_group.allow_ssh_and_jenkins.id}"
}
