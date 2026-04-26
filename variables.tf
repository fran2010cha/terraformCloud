variable "viginia_cidr" {
  description = "CIDR block para la VPC de Virginia"
  type = string
 # type        = map(string)  --> para trabjar con terraform workspace y asi tener diferentes CIDR para cada ambiente
}
/*
variable "public_subnet" {
  description = "CIDR public subnet"
  type        = string
}

variable "private_subnet" {
  description = "CIDR private subnet"
  type        = string
}
*/

variable "subnet" {
    description = "Lista subred"
    type        = list(string)
  
}

variable "tags" {
  description = "tags del proyecto"
  type = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for Ingress traffic "
  type = string
  
}

variable "ec2_specs" {
  description = "parametros de la instancia"
  type = map(string)
  
}

variable "enable_monitoreo" {
  description = "Habilitar monitoreo en la instancia"
  type = bool
  
}

variable "ingress_ports_list" {
  description = "Lista de puertos de entrada permitidos"
  type = list(number)
}


variable "access_key" {
  
}

variable "secret_key" {

}
