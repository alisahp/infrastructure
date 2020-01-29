resource "aws_iam_role" "jenkins_admin_worker1" {
  name = "jenkins_admin_worker1"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "jenkins_profile_worker1" {
  name = "jenkins_profile_worker1"
  role = "${aws_iam_role.jenkins_admin_worker1.name}"
}

resource "aws_iam_role_policy" "jenkins_admin_policy_worker1" {
  name = "jenkins_admin_policy_worker1"
  role = "${aws_iam_role.jenkins_admin_worker1.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}
