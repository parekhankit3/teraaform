resource "aws_instance" "terraform_server" {
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}