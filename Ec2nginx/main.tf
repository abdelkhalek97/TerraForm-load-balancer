resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instType
  count                       = length(var.subnet_ids)
  subnet_id                   = var.subnet_ids[count.index]
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.secg_id]
  associate_public_ip_address = "true"

  connection {
    type        = var.connection_type
    user        = var.connection_user
    private_key = file(var.connection_private_key)
    host        = self.public_ip
  }

  provisioner "file" {
    source      = var.file_source
    destination = var.file_destination
  }

  provisioner "remote-exec" {
    inline = var.inline
  }

  provisioner "local-exec" {
    command = "echo Public-ip ${count.index}: ${self.public_ip} >> ./all-ips.txt"
  }

  tags = {
    Name = "${var.name} ${count.index + 1}"
  }
}
