resource "aws_iam_instance_profile" "main_drupal" {
  name = "main-drupal-instance-profile"
  role = aws_iam_role.main_drupal.name
}

resource "aws_iam_role" "main_drupal" {
  name = "main_drupal_test_role"

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
    tag-key = "drupal-boom-test"
  }
}

resource "aws_iam_role_policy" "drupal_efs_policy" {
  name = "drupal_efs_policy"
  role = aws_iam_role.main_drupal.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "elasticfilesystem:*",
        "ec2:*",
        "elasticache:Describe*",
				"elasticache:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# resource "aws_iam_role" "main_drupal" {
#   name               = "main-drupal-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     # effect  = "Allow"
#     # actions = ["sts:AssumeRole"]
#     effect = "Allow"
#     actions = [
#       "elasticfilesystem:DescribeAccessPoints",
#       "elasticfilesystem:DescribeFileSystems",
#       "elasticfilesystem:DescribeMountTargets"
#     ]
#     # principals {
#     #   type        = "Service"
#     #   identifiers = ["ec2.amazonaws.com"]
#     # }
#   }
# }

