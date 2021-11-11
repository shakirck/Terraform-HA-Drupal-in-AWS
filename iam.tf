resource "aws_iam_instance_profile" "main_drupal" {
  name = var.IAMInstanceProfileName
  role = aws_iam_role.main_drupal.name
}

resource "aws_iam_role" "main_drupal" {
  name = var.IAMRoleName

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

  tags = var.IAMRoleTags
}


