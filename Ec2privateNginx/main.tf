resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instType
  count                  = length(var.subnet_ids)
  subnet_id              = var.subnet_ids[count.index]
  vpc_security_group_ids = [var.secg_id]
  key_name               = var.key_name
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo chmod 777 /var/www/html
    sudo chmod 777 /var/www/html/index.nginx-debian.html
    sudo echo '<h1>Hi from private Instance ${count.index +1} </h1>' > /var/www/html/index.nginx-debian.html
    sudo systemctl restart nginx
  EOF
  

  provisioner "local-exec" {
    command = "echo Private-ip ${count.index}: ${self.private_ip} >> ./all-ips.txt"
  }
  tags = {
    Name = "${var.name} ${count.index + 1}"
  }
}

