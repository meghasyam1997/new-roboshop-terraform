resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]
 iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  tags = {
    Name = local.name
  }
}
resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance, aws_route53_record.record]

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = var.app_type == "db" ? local.db_command : local.app_command
  }
}

resource "aws_route53_record" "record" {
  zone_id = "Z06713411IASYL5XZHSG8"
  name    = "${var.component_name}-${var.env}.msdevops72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}


resource "aws_iam_role" "ssm_role" {
  name = "${var.component_name}-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    tag-key = "${var.component_name}-${var.env}"
  }
}

resource "aws_iam_role_policy" "ssm_policy" {
  name = "${var.component_name}-${var.env}-ssm_policy"
  role = aws_iam_role.ssm_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": [
          "arn:aws:kms:us-east-1:844746520101:key/f2e4231a-4405-4fcc-9d18-bb7c5e81348f",
          "arn:aws:ssm:us-east-1:844746520101:parameter/${var.env}.${var.component_name}.*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.component_name}-${var.env}-ssm_profile"
  role = aws_iam_role.ssm_role.name
}
