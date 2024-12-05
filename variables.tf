# variables.tf
variable "project_name" {
  description = "A projekt neve, ami az erőforrások elnevezésében is megjelenik"
  type        = string
  default     = "quiz_game"
}

variable "db_port" {
  description = "A MongoDB portja"
  type        = number
  default     = 27017
}

variable "server_port" {
  description = "Az NodeJS szerver portja"
  type        = number
  default     = 5000
}

variable "client_port" {
  description = "Az Angular alkalmazás portja"
  type        = number
  default     = 4200
}

