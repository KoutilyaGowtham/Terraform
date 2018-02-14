# Creating Auto-Scaling Group
data "aws_region" "region" {
  default = "${var.region}"
  }
resource "aws_autoscaling_group" "asg_1" {
  
  
