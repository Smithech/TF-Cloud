resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id

  cidr_block = var.subnets[0]

  map_public_ip_on_launch = true # permite asignar IP publica, por defecto es false

  tags = {
    Name = "Public Subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id

  cidr_block = var.subnets[1]

  tags = {
    Name = "Private Subnet-${local.sufix}"
  }

  depends_on = [
    aws_instance.public_instance
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

# Grupo de seguridad
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  # AVERIGUAR BIEN SOBRE BLOQUES DINÁMICOS
  # dynamic "ingress" {
  #   for_each = var.ingress_ports_list
  #   content {
  #     from_port   = ingress.value
  #     to_port     = ingres.value
  #     ip_protocol = "tcp"
  #     cidr_ipv4   = var.sg_ingress_cidr
  #   }
  # }

  tags = {
    Name = "SG Public Instance-${local.sufix}"
  }
}

# Reglas del grupo de seguridad sg_public_instance
# Ingreso
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = var.sg_ingress_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "allow_ssh_ingress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = var.sg_ingress_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "allow_http_ingress"
  }
}

# Egreso
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  tags = {
    Name = "allow_all_traffic_ipv4_egress"
  }
}
