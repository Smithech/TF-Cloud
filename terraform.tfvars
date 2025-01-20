virginia_cidr = "10.10.0.0/16"

# variables type string
# public_subnet = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

# variable list(string)
subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"     = "dev"
  "owner"   = "Johan"
  "cloud"   = "aws"
  "IAC"     = "Terraform"
  "project" = "cerberus"
  "region"  = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami" = "ami-0454e52560c7f5c55" # us-east-1 


  "instance_type" = "t2.micro"
}

enable_monitoring = 0

ingress_ports_list = [22, 80, 443]
