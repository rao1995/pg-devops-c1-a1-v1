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

  

  provisioner "remote-exec" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("karthik-key.pem")}"
    host        = "${self.public_ip}"
  }

    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo yum install git -y",
      "git clone https://github.com/rao1995/pg-devops-c1-a1-v1.git /tmp/git-dir-clone",
      "ansible-playbook /tmp/git-dir-clone/ansible/test-1.yaml"
    ]
  }
}
