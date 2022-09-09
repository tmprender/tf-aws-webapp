# Outputs file
output "app_url" {
  value = "http://${aws_instance.hashiapp[0].public_dns}"
}
