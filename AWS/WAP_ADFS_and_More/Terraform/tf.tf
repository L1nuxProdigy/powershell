##################################################################################
# VARIABLES
##################################################################################
### Connection Vars ###
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {
  default = "NadavFrankfurt"
}
### Networking Vars ###
variable "availability_zone_1a" {default = "eu-central-1a"}

### AMI Vars ###
variable "ubuntu_image_18-04" {default = "ami-0ac05733838eabc06"}
variable "ms_2012_base" {default = "ami-09a023d2317d65420"}
variable "ms_2016_base" {default = "ami-0c162e79e019adc1f"}
variable "ms_2019_base" {default = "ami-0091012d8fbe033f5"}

### Snapshots Vars ###
variable "win_2016_snapshot_id" {default = "snap-a7ab05de"}

### Machines Configurations Scripts ###
variable "dc_adfs" {}
variable "ca" {}
variable "iis_claimapp" {}
variable "wap" {}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-central-1"
}

##################################################################################
# VPC Resources
##################################################################################
resource "aws_vpc" "VPC_main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
	Name = "Terraform_VPC"
  }
}

resource "aws_subnet" "Subnet_main" {
  vpc_id     = "${aws_vpc.VPC_main.id}"
  availability_zone = "${var.availability_zone_1a}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
	Name = "Terraform_Subnet"
  }
}

resource "aws_internet_gateway" "IG_main" {
  vpc_id = "${aws_vpc.VPC_main.id}"

  tags = {
    Name = "Terraform_IG"
  }
}

resource "aws_route_table" "Route_Table_main" {
  vpc_id = "${aws_vpc.VPC_main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IG_main.id}"
  }

  tags = {
    Name = "Terraform_Route"
  }
}

resource "aws_main_route_table_association" "VPC_Route_Association" {
  vpc_id         = "${aws_vpc.VPC_main.id}"
  route_table_id = "${aws_route_table.Route_Table_main.id}"
}

resource "aws_route_table_association" "VPC_Subnet_Association" {
  subnet_id      = "${aws_subnet.Subnet_main.id}"
  route_table_id = "${aws_route_table.Route_Table_main.id}"
}

	
resource "aws_security_group" "Windows_SG" {
	name        = "Terraform_SG"
	description = "Terraform_SG_Configuration_For_Nginx"
	vpc_id      = "${aws_vpc.VPC_main.id}"

	ingress {
		from_port   = 3389
		to_port     = 3389
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
		description = "RDP"
      }
	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
		description = "HTTP"
      }
	ingress {
		from_port   = 443
		to_port     = 443
		protocol    = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
		description = "HTTPS"
      }
	  
	ingress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		self        = true
		description = "Allows Internal Traffic"
      }
	  
	egress {
		from_port       = 0
		to_port         = 0
		protocol        = "-1"
		cidr_blocks     = ["0.0.0.0/0"]
        
	}
	
	tags = {
    Name = "Windows SG"
	Description = "Created by Terraform for MS Machines"
  }
}

##################################################################################
# EBS Resources
##################################################################################

resource "aws_ebs_volume" "win_2016_snapshot" {
  availability_zone = "${var.availability_zone_1a}"
  snapshot_id       = "${var.win_2016_snapshot_id}"

  tags = {
    Name = "Server2016 ISO"
	Owner = "Nadav"
	CreatedBy = "Terraform"
  }
}

##################################################################################
# EC2 Resources
##################################################################################

resource "aws_instance" "DC_ADFS_2016" {
	ami           = "${var.ms_2016_base}"
	instance_type = "t2.large"
	key_name        = "${var.aws_key_name}"
	subnet_id = "${aws_subnet.Subnet_main.id}"
	vpc_security_group_ids = ["${aws_security_group.Windows_SG.id}"]

	private_ip = "10.0.1.4"

	tags = {
	Name = "DC/ADFS 2016"
	Owner = "Nadav"
	Service = "DC/ADFS"
	OS = "Win 2016"
	CreatedBy = "Terraform"
	}
	
	user_data = "${file(var.dc_adfs)}"
}

resource "aws_instance" "CA" {
	ami           = "${var.ms_2016_base}"
	instance_type = "t2.large"
	key_name        = "${var.aws_key_name}"
	subnet_id = "${aws_subnet.Subnet_main.id}"
	vpc_security_group_ids = ["${aws_security_group.Windows_SG.id}"]

	private_ip = "10.0.1.5"

	tags = {
	Name = "CA"
	Owner = "Nadav"
	Service = "Certificate Authority"
	OS = "Win 2016"
	CreatedBy = "Terraform"
	}
	
	user_data = "${file(var.ca)}"
}

resource "aws_instance" "IIS_ClaimApp" {
	ami           = "${var.ms_2016_base}"
	instance_type = "t2.large"
	key_name        = "${var.aws_key_name}"
	subnet_id = "${aws_subnet.Subnet_main.id}"
	vpc_security_group_ids = ["${aws_security_group.Windows_SG.id}"]

	private_ip = "10.0.1.6"

	tags = {
	Name = "IIS ClaimApp"
	Owner = "Nadav"
	Service = "IIS + ClaimApp"
	OS = "Win 2016"
	CreatedBy = "Terraform"
	}
	
	user_data = "${file(var.iis_claimapp)}"
}

resource "aws_instance" "WAP" {
	ami           = "${var.ms_2016_base}"
	instance_type = "t2.large"
	key_name        = "${var.aws_key_name}"
	subnet_id = "${aws_subnet.Subnet_main.id}"
	vpc_security_group_ids = ["${aws_security_group.Windows_SG.id}"]

	private_ip = "10.0.1.7"

	tags = {
	Name = "WAP"
	Owner = "Nadav"
	Service = "WAP"
	OS = "Win 2016"
	CreatedBy = "Terraform"
	}
	
	user_data = "${file(var.wap)}"
}

##################################################################################
# EC2 Additional Actions
##################################################################################

resource "aws_volume_attachment" "attach_to_iis" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.win_2016_snapshot.id}"
  instance_id = "${aws_instance.IIS_ClaimApp.id}"
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
	value = "${aws_instance.DC_ADFS_2016}"
}
