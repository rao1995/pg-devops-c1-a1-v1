provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "karthik-instance-1" {
  ami           = "ami-04823729c75214919"
  instance_type = "t3.medium"
  key_name      = "karthik-test-1"

  tags = {
    Name = "ANSIBLE"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("/tmp/kraov-test-1.pem")}"
    host        = "${self.public_ip}"
    timeout     = "2m"
  }

  provisioner "remote-exec" {  
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo yum install git -y",
      "git clone https://github.com/rao1995/pg-devops-c1-a1-v1.git /tmp/git-dir-clone",
      "ansible-playbook /tmp/git-dir-clone/ansible/test-1.yaml"
    ]
  }
}
