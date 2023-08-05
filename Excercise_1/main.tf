terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  profile = "default"
  access_key = "ASIA2J6TPJERA5LQT2TS"
  secret_key = "ME0ZEV4VTc9vDSiDqsR51BdIJTP9IJ/ZpZbIK7Ki"
  token = "FwoGZXIvYXdzEKj//////////wEaDO5Z1KtR1G6xDGdwSiLVAUhnI48YR0nX+kVkepbH0vYUDn5uGC0aOi+P746lI0cA4ur0k2Apw8Y+ujJ04cOi5QFVWXWovw7CFMYyjdEWlE1/2f0fXrgsXBYfVgieHwmAoARTDSACy5KARww2j/YYTdcAHKl2mS4iJq4d+/0Y+mY5cl5rSFl9mNmZ30ZToTnyhLD8tW4bvNc2CGNOtqiBEPNSU4UWQCa1UI/X55X6eXKRW/nURxVtoiPu3T7WcwfN9lXGMEhaItWk/uoKEfXOEQNyccTfsAJjkr3Im+vTrc91+nS6xCi14LemBjIt1m7oH97pqFQKLtIY+eMDUppn+7iJx49vDb6gYVh9K8hlQ0KJ2xM5Sc+s5zaL"
  region  = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count         = "4"
  ami           = "ami-09538990a0c4fe9be"
  instance_type = "t2.micro"
  tags = {
    Name = "Udacity T2"
  }
}

## TODO: provision 2 m4.large EC2 instances named Udacity M4
#resource "aws_instance" "Udacity_M4" {
#  count         = "2"
#  ami           = "ami-09538990a0c4fe9be"
#  instance_type = "m4.large"
#  tags = {
#    Name = "Udacity M4"
#  }
#}

