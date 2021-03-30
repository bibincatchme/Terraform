provider "aws" {
	region = "us-west-2"
}

resource "aws_instance" "web" {
	ami           = "ami-003634241a8fcdec0"
	instance_type = "t2.micro"
	key_name      = "william"

	tags = {
		Name = "Tuts test"
	}

	connection {
		type        = "ssh"
		host        = self.public_ip
		user        = "ubuntu"
		private_key = file("/home/focus/Downloads/william.pem")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}

	provisioner "file" {
		content     = "Hello there"
		destination = "/home/ubuntu/tuts.txt"
	}

	provisioner "local-exec" {
		command = "echo ${self.public_ip} > instance-ip.txt"
	}

	provisioner "remote-exec" {
		inline = [
			"touch /home/ubuntu/tuts-remote-exec.txt"
		]
	}
}


/*

provisioner "remote-exec" {
    connection {
        type = "ssh"
        host = "127.0.0.1"
        user = "ec2-user"
        private_key = file("/home/focus/Downloads/terraform-key.pem")
        # Default timeout is 5 minutes
        timeout     = "4m"

    inline = {
      "touch /home/ec2-user.new.txt"

    }
	    
provisioner "remote-exec" {
when = destroy
    inline = {
      "touch /home/ec2-user.new.txt"

    }	

	
	when = on_failure

*/
		    
	    
	    
