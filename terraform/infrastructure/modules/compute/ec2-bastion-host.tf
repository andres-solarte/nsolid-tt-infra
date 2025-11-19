resource "aws_iam_role" "bastion_host" {
  name = "${var.project_name}-${var.environment_name}-bastion-host"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bastion_host" {
  role       = aws_iam_role.bastion_host.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "bastion_host" {
  name = "${var.project_name}-${var.environment_name}-bastion-host"
  role = aws_iam_role.bastion_host.name
}

resource "aws_security_group" "bastion_host" {
  name        = "${var.project_name}-${var.environment_name}-bastion-host"
  description = "Security group for the bastion host"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "bastion_host" {
  security_group_id = aws_security_group.bastion_host.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ssm_parameter.bastion_host_ami.value
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.bastion_host.id]
  subnet_id              = var.private_subnet_ids[0]
  iam_instance_profile   = aws_iam_instance_profile.bastion_host.name

  associate_public_ip_address = false
  monitoring                  = true
  ebs_optimized               = true

  root_block_device {
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${var.project_name}-${var.environment_name}-bastion-host"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}
