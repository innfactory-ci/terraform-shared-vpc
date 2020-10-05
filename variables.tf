variable "host_project_name" {
  description = "The shared VPC host project name"
}

variable "service_projects" {
  description = "map of service project names to project IDs"
  type        = map(string)
}

variable "service_networks" {
  description = "map of service project names to associated subnetworks"
  type        = map(string)
}
