
# Create a VPC
resource "aws_vpc" "vpc_virginia" {
  cidr_block =  var.viginia_cidr
  #para trabajar con terraform workspace y asi tener diferentes CIDR para cada ambiente
  #cidr_block = lookup(var.viginia_cidr, terraform.workspace)

 /* tags = {
    Name = "VPC_VIRGINIA"
    name = "prueba"
    env = "DEV"
  }*/
  tags = {
    "Name" = "VPC_VIRGINIA - ${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet_virginia" {
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = var.subnet[0]
  map_public_ip_on_launch = true
   tags = {
    "Name" = "public_subnet_virginia - ${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet_virginia" {
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = var.subnet[1]
   tags = {
    "Name" = "private_subnet_virginia - ${local.sufix}"
  }
  depends_on = [ aws_subnet.public_subnet_virginia ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia - ${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public CRT - ${local.sufix}"
  }
}

resource "aws_route_table_association" "association_public_subnet" {
  subnet_id      = aws_subnet.public_subnet_virginia.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "allow_tls"
  description = "Allow SSH inbound traffic ALL egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

 dynamic "ingress" {
   for_each = var.ingress_ports_list
   content {
     description      = "Allow traffic on port ${ingress.value}"
     from_port        = ingress.value
     to_port          = ingress.value
     protocol         = "tcp"
     cidr_blocks      = [var.sg_ingress_cidr]
   }
 }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public Instance SG - ${local.sufix}"
  }
}