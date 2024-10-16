# Packer plugin for AWS
# https://www.packer.io/plugins/builders/amazon

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Define the source AMI and where to save it
source "amazon-ebs" "amazon-linux" {
  region            = "us-east-1"
  ami_name          = "ami-version-1.0.1-f-{timestamp}"
  instance_type     = "t2.micro"
  source_ami_filter {
    filters = {
        name                 = "al2023-ami-2023.6.20241010.0-kernel-6.1-x86_64"
        root-device-type     = "ebs"
        virtualization-type  = "hvm"
    }
  }

    most_recent = true
    owners      = ["137112412989"]
  ssh_username      = "ec2-user"
  ami_regions       = ["us-east-1"]
}

# Define the build block with provisioners
build {
  name    = "hq-packer"
  sources = ["source.amazon-ebs.amazon-linux"]

  # Copy provisioner script to the instance
  provisioner "file" {
    source      = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  # Make the provisioner script executable
  provisioner "shell" {
    inline = ["chmod a+x /tmp/provisioner.sh"]
  }

  # List the files in the /tmp directory
  provisioner "shell" {
    inline = ["ls -la /tmp"]
  }

  # Print the working directory
  provisioner "shell" {
    inline = ["pwd"]
  }

  # Execute the provisioner script
  provisioner "shell" {
    inline = ["/tmp/provisioner.sh"]
  }
}