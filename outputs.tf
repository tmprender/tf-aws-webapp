# Outputs file
output "app_url" {
  value = "http://${aws_instance.hashiapp.public_dns}"
}

output "ami_id" {
  value = aws_instance.hashiapp.ami
}