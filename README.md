# Terraform config aws-webapp

Provisions a simple nginx webserver with sample HashiCafe website in AWS EC2, using a base AMI registered in [HCP Packer](https://cloud.hashicorp.com/products/packer).

Default Packer bucket name matches the Ubuntu 22.04 Nginx image built with my [Packer example](https://github.com/danbarr/hcp-packer-ubuntu22).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.82 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | ~> 0.82 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.2 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route_table.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.hashicafe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [null_resource.configure-web-app](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_integer.product](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [tls_private_key.hashicafe](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [hcp_packer_artifact.ubuntu-webserver](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/packer_artifact) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_department"></a> [department](#input\_department) | Value for the department tag. | `string` | `"WebDev"` | no |
| <a name="input_env"></a> [env](#input\_env) | Value for the environment tag. | `string` | n/a | yes |
| <a name="input_hashi_products"></a> [hashi\_products](#input\_hashi\_products) | n/a | <pre>list(object({<br>    name       = string<br>    color      = string<br>    image_file = string<br>  }))</pre> | <pre>[<br>  {<br>    "color": "#dc477d",<br>    "image_file": "hashicafe_art_consul.png",<br>    "name": "Consul"<br>  },<br>  {<br>    "color": "#ffffff",<br>    "image_file": "hashicafe_art_hcp.png",<br>    "name": "HCP"<br>  },<br>  {<br>    "color": "#60dea9",<br>    "image_file": "hashicafe_art_nomad.png",<br>    "name": "Nomad"<br>  },<br>  {<br>    "color": "#63d0ff",<br>    "image_file": "hashicafe_art_packer.png",<br>    "name": "Packer"<br>  },<br>  {<br>    "color": "#844fba",<br>    "image_file": "hashicafe_art_terraform.png",<br>    "name": "Terraform"<br>  },<br>  {<br>    "color": "#2e71e5",<br>    "image_file": "hashicafe_art_vagrant.png",<br>    "name": "Vagrant"<br>  },<br>  {<br>    "color": "#ffec6e",<br>    "image_file": "hashicafe_art_vault.png",<br>    "name": "Vault"<br>  }<br>]</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Specifies the AWS instance type. | `string` | `"t3.micro"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Value for the owner tag. | `string` | `"web.developer"` | no |
| <a name="input_packer_bucket"></a> [packer\_bucket](#input\_packer\_bucket) | HCP Packer bucket name containing the source image. | `string` | `"ubuntu22-nginx"` | no |
| <a name="input_packer_channel"></a> [packer\_channel](#input\_packer\_channel) | HCP Packer image channel. | `string` | `"production"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This prefix will be included in the name of most resources. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the resources are created. | `string` | `"us-east-2"` | no |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | The address prefix to use for the subnet. | `string` | `"10.0.10.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | ID of the AMI resolved from HCP Packer. |
| <a name="output_app_url"></a> [app\_url](#output\_app\_url) | URL of the deployed webapp. |
| <a name="output_product"></a> [product](#output\_product) | The product which was randomly selected. |
<!-- END_TF_DOCS -->