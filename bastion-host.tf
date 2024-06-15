resource "aws_instance" "bastion" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type = "t2.micro"
    key_name = aws_key_pair.projectkey.key_name
    subnet_id = module.vpc.public_subnets[0]
    count = var.instance_count
    vpc_security_group_ids = [aws_security_group.bastion-sg.id] 

    tags = {
        Name = "bastion"
    }

    provisioner "file" {
      content = templatefile("templates/db-deploy.tmpl",{rds-endpoint = aws_db_instance.project-rds.address, dbuser = var.dbuser, dbpass = var.dbpass})
      destination = "/tmp/Terraform-project-dbdeploy.sh"
    } 

    provisioner "remote-exec" {
      inline = [ 
        "chmod +x /tmp/Terraform-project-dbdeploy.sh",
        "sudo /tmp/Terraform-project-dbdeploy.sh"
       ]
    }
    connection {
      user = var.USERNAME
      private_key = file(var.PRIV_KEY_PATH)
      host = self.public_ip
    }
    depends_on = [aws_db_instance.project-rds]
}