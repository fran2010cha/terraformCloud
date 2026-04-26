viginia_cidr = "10.10.0.0/16"
#para trabajar con terraform workspace y asi tener diferentes CIDR para cada ambiente
/*viginia_cidr = {
  "prod" = "10.10.0.0/16"
  "dev" = "172.16.0.0/16"
}*/
#public_subnet = "10.10.0.0/24"
#private_subnet = "10.10.1.0/24"

subnet = [ "10.10.0.0/24" , "10.10.1.0/24" ]

tags = {
  "env" = "dev"
  "owner" = "Francisco"
  "cloud" = "AWS"
  "IAC" = "Terraform"
  "IAC_Version" = "1.14.0"
  "project" = "cerberus"
  "region" = "virginia"
  
}
sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "instance_type" = "t2.micro"
  "ami" = "ami-01b14b7ad41e17ba4"
}

enable_monitoreo = false

ingress_ports_list = [ 22, 80, 443 ]