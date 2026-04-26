variable "instancias" {
    description = "nombre de las intancias"
    type = list(string)
    default = ["apache"]
  
}

resource "aws_instance" "public_instance" {
    #count         = length(var.instancias)
    for_each = toset(var.instancias)
    ami           = var.ec2_specs.ami
    instance_type = var.ec2_specs.instance_type
    subnet_id     = aws_subnet.public_subnet_virginia.id
    key_name = data.aws_key_pair.key.key_name
    vpc_security_group_ids = [ aws_security_group.sg_public_instance.id ]
    tags = {
      #  Name = var.instancias[count.index]
         Name = "${each.value} - ${local.sufix}"
    }
    user_data = file("${path.module}/scripts/userdata.sh")
}

resource "aws_instance" "monitoring_instance" {
    count         = var.enable_monitoreo ? 1 : 0
    ami           = var.ec2_specs.ami
    instance_type = var.ec2_specs.instance_type
    subnet_id     = aws_subnet.public_subnet_virginia.id
    key_name = data.aws_key_pair.key.key_name
    vpc_security_group_ids = [ aws_security_group.sg_public_instance.id ]
    user_data = file("${path.module}/scripts/userdata.sh")
    
    tags = {
         Name = "Monitoreo - ${local.sufix}"
    }
    
}

#practica con funciones de terraform
/*
variable "cadena" {
    description = "cadena de texto"
    type = string
    default = "ami-123, AMI-AAV, ami-12f"
  
}


variable "palabra" {
  type = list(string)
  default = ["hola", "mundo", "terraform"]
}

variable "entornos" {
    type = map(string)
    default = {
        "prod" = "10.10.0.0/16"
        "dev" = "172.16.0.0/16"
    }
  
}
*/