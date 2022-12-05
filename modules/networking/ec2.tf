resource "aws_instance" "web_instance" {
  ami           = "ami-02045ebddb047018b"
  instance_type = "t2.micro"
  key_name      = "tf-key-dev1"
  subnet_id                   = element(aws_subnet.public_subnet.*.id, 0)
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
      #!/bin/bash -ex

      #amazon-linux-extras install nginx1 -y
      echo "<h4>Nyobi dev 0-1</h4>\n <h1>$(curl https://api.kanye.rest/?format=text)</h1>" >  /home/ubuntu/index.html 
      #systemctl enable nginx
      #systemctl start nginx

      # Adds the GPG key for the official Docker repository to the system
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

      # Add Docker repository to APT sources
      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

      # Update the packages
      apt-get update

      # Making sure installing Docker from Repo instead of default Ubuntu 16.04 repo
      apt-cache policy docker-ce

      # Install Docker Community Edition
      apt-get install -y docker-ce

      # Pull the lastest Nginx image
      docker pull nginx:latest
      sudo usermod -a -G docker ubuntu

      # Run the nginx container on port 80
      docker run -d -p 80:80 --name nginx --mount type=bind,source=/home/ubuntu/index.html,target=/usr/share/nginx/html
      EOF

  tags = {
    "Name" : "web-ubuntu-dev1"
  }
}
