variable "virginia_cidr" {
  description = "CIDR de Virginia"
  type        = string
}

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}

variable "enable_monitoring" {
  type = number
}

variable "ingress_ports_list" {
  description = "Lista de puertos de ingreso"
  type        = list(number)
}

variable "access_key" {}

variable "secret_key" {}
