provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "karthik-instance-1" {
  ami           = "ami-06ca3ca175f37dd66"
  instance_type = "t3.micro"
  key_name      = "karthik-key"

  tags = {
    Name = "ANSIBLE"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("karthik-key.pem")}"
    host        = "${self.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo yum install git -y",
      "git clone {url} /tmp/git-dir-clone",
      "ansible-playbook /tmp/git-dir-clone/configurations.yaml"
    ]
  }
}
