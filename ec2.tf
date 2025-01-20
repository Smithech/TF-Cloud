# Usando for-each
# El tipo de variable debe ser map o set

variable "instancias" {
  description = "Nombre de las instancias"
  type        = set(string)
  default     = ["apache"]
}

resource "aws_instance" "public_instance" {
  for_each               = var.instancias
  ami                    = var.ec2_specs.ami # us-east-1
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

  # Solo se ejecuta en la creaci[on de la instancia 
  user_data = file("scripts/user_data.sh")

  tags = {
    Name = "${each.value}-${local.sufix}"
  }
}

# Usando count

# variable "instancias" {
#   description = "Nombre de las instancias"
#   type        = list(string)
#   default     = ["apache", "mysql", "jumpserver"]
# }

# resource "aws_instance" "public_instance" {
#   count                  = length(var.instancias)
#   ami                    = var.ec2_specs.ami # us-east-1
#   instance_type          = var.ec2_specs.instance_type
#   subnet_id              = aws_subnet.public_subnet.id
#   key_name               = data.aws_key_pair.key.key_name
#   vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

#   # Solo se ejecuta en la creaci[on de la instancia 
#   user_data = file("scripts/user_data.sh")

#   tags = {
#     Name = var.instancias[count.index]
#   }
# }

resource "aws_instance" "monitoring_instance" {
  count = var.enable_monitoring == 1 ? 1 : 0
  # Variable de tipo bool
  # count                  = var.enable_monitoring
  ami                    = var.ec2_specs.ami # us-east-1
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

  # Solo se ejecuta en la creaci[on de la instancia 
  user_data = file("scripts/user_data.sh")

  tags = {
    Name = "Monitoreo-$[local.sufix]"
  }
}
