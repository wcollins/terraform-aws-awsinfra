output "vpc_name" {
  description = "VPC name"
  value       = var.vpc_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = aws_vpc.vpc.arn
}

output "vpc_cidr" {
  description = "VPC CIDR block ID"
  value       = var.vpc_prefix
}

output "rtb_id" {
  description = "Default route table"
  value       = aws_vpc.vpc.default_route_table_id
}

output "subnet_id" {
  description = "List of subnet IDs"
  value       = aws_subnet.subnet.*.id
}

output "instance_id" {
  description = "List of instance IDs"
  value       = aws_instance.instance.*.id
}

output "instance_arn" {
  description = "List of instance ARNs"
  value       = aws_instance.instance.*.arn
}

output "availability_zone" {
  description = "List of instance availability zones"
  value       = aws_instance.instance.*.availability_zone
}

output "primary_network_interface_id" {
  description = "List of primary interface IDs"
  value       = aws_instance.instance.*.primary_network_interface_id
}

output "private_ip" {
  description = "List of instance private IP addresses"
  value       = aws_instance.instance.*.private_ip
}