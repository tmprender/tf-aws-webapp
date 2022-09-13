# Outputs file
output "app_url" {
  value = "http://${aws_instance.hashiapp[0].public_dns}"
}

output "ami_id" {
  value = aws_instance.hashiapp[0].ami
}