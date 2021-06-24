data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_prefix
  tags       = merge({ "Name" = var.vpc_name }, var.vpc_tags)
}

resource "aws_subnet" "subnet" {
  count                   = length(var.subnet_names)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_prefixes[count.index]
  tags                    = merge({ "Name" = var.subnet_names[count.index] }, var.subnet_tags)
}

resource "aws_network_interface" "interface" {
  count                   = length(var.subnet_names)
  subnet_id               = aws_subnet.subnet.*.id[count.index]
  security_groups         = [aws_security_group.allow-all.id]

  tags = {
    Name = "primary-network-interface"
  }
}

resource "random_id" "id" {
  byte_length = 8
}

resource "aws_key_pair" "key_pair" {
  key_name   = random_id.id.hex
  public_key = var.ssh_key
}

resource "aws_instance" "instance" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  count                       = length(var.instance_names)
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name

  network_interface {
    network_interface_id = aws_network_interface.interface.*.id[count.index]
    device_index         = 0
  }

  tags = merge({ "Name" = var.instance_names[count.index] }, var.subnet_tags) 

  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_security_group" "allow-all" {
  name   = "allow-all"
  description = "Allow all ingress/egress"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }
}
