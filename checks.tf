check "web_health" {
  data "http" "example" {
    url = "http://${aws_eip.hashicafe.public_dns}"
  }
  assert {
    condition     = data.http.example.status_code == 200
    error_message = "${data.http.example.url} returned an unhealthy status code."
  }

  assert {
    condition     = aws_instance.hashicafe.instance_state == "running"
    error_message = "The EC2 instance is not running."
  }
  assert {
    condition     = data.hcp_packer_artifact.ubuntu-webserver.revoke_at == null
    error_message = "The image referenced in the Packer bucket is scheduled for revocation."
  }
  assert {
    condition     = timecmp(plantimestamp(), timeadd(data.hcp_packer_artifact.ubuntu-webserver.created_at, "720h")) < 0
    error_message = "The image referenced in the Packer bucket is more than 30 days old."
  }
}

check "dns_health" {
  data "dns_a_record_set" "example" {
    host = aws_eip.hashicafe.public_dns
  }

  assert {
    condition     = data.dns_a_record_set.example.addrs[0] == aws_eip.hashicafe.public_ip
    error_message = "The EIP public DNS record is not resolving to the EIP address."
  }
}
