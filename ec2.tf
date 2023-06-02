

resource "aws_instance" "demo"{
    instance_type="t2.micro"
    ami="*****"

    subnet_id= aws_subnet.PrivSubnet.id
   
    tags={
        Name="EC2_instance"

    }

}