data "aws_ami" "ubuntu_latest" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "frontend_nodes" {
  count         = 2
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = "t3.micro"
  subnet_id     = element(var.public_subnets, count.index)
  key_name      = var.key_name
  tags = { Name = "frontend-${count.index + 1}" }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo '<h1>Frontend $(hostname)</h1>' | sudo tee /var/www/html/index.html"
    ]
  }
}

resource "aws_instance" "app_nodes" {
  count         = 2
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = "t3.micro"
  subnet_id     = element(var.private_subnets, count.index)
  key_name      = var.key_name
  tags = { Name = "appserver-${count.index + 1}" }

  provisioner "file" {
    source      = "app/"
    destination = "/home/ubuntu/app"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install python3-flask -y",
      "cd /home/ubuntu/app && nohup python3 app.py &"
    ]
  }
}
