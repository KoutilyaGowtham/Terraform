## Input variables for creating ASG

# Assinging aws region to the ASG
variable "region" {
  default = "us-east-1"
  }
variable "stack_item_name" {
  description = "Fullname of Stack item. The value is used to create the application resource tag"
  type= "string"
  }
variable "stack_item_shortname" {
  description = "This is the short form of the tag"
  type = "string"
  }
variable "asg_name_override" {
  type = "string"
  description = " To override the ASG name"
  default = ""
  }
variable "lc_sg_name_override" {
  type = "string"
  
  

