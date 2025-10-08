
 resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.PublicEC2SG.id]

  tags = {
    Name = "DatabaseServer"
  }
}

