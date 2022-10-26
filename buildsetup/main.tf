provider "aws" {
    region= "ap-south-1"
}

variable "BuildAMI" {
    description = "Build Server AMI"
    default = "ami-062df10d14676e201"
  
}

variable "BuildType" {
    description = "Build Server type"
    default = "t2.micro"
  
}

variable "BuildKey" {
    description = "Build Server key"
    default = "vivek"
  
}

variable "BuildUser" {
    description = "Build Server User"
    default = "ubuntu"
  
}

resource "aws_instance" "testing" {
    ami = var.BuildAMI
    instance_type = var.BuildType
    key_name = var.BuildKey
provisioner "local-exec" {
    command="export ANSIBLE_HOST_KEY_CHECKING=False;sleep 30; ansible-playbook buildsetup.yml -i ${aws_instance.testing.private_ip}, -u ${var.BuildUser} --key-file /etc/ansible/${var.BuildKey}.pem"

  }
}
