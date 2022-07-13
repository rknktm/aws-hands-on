In these Hands-on, we haben a Custom VPC with two Availability Zones.Each Availability Zone has a public subnet.
There are two EC2 instances, which are in public subnets and the Application Load Balancer is attached to two public subnets.
ALB is coupled with Auto Scaling.There is one Target Group connecting both the EC2 instances
EC2 Apache installation happens with user- data while Launch Template is created.

Steps
Step 1: Create a Custom VPC

Create the Custom VPC with two public subnets in two Availability Zones.

Step 2: Create a Target Group

Target Group Name: <TG-1>
Target Type: <Instance>
Protocol: <HTTP>
Port: <80>
VPC: <Select the Custom VPC>
Health Check Settings:
Protocol: <HTTP>
Path: </>

Step 3: Create an Application Load Balancer (ALB)

Name: <ALB-1>
Scheme: Select Internet Facing
IP address type : ipv4
Network mapping: Custom VPC
Mappings:Choose public subnets in custom VPC
Security groups:Create a New Security Group for the Load Balancer (ALB-sg) 
    Add rule, HTTP Port 80.
Listeners and routing: Open port 80 (HTTP)
Default action:select target group---> TG-1
Click Next to create the Load Balancer.


Step 4: Create a Launch Template

Name: <LT-1> 
Instance type:t2.micro
Secrutiy Group: select the SG that you have created before to this.
Advanced details:
  User-data:
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
      ec2id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
      echo "<center><h1>The Instance Id of Amazom Linux is ec2id</h1></center>" > /var/www/html/index.txt
      sed "s/ec2id/$ec2id/" /var/www/html/index.txt > /var/www/html/index.html

Then click Confirm to create the LT-1.


Step 5: Create the Auto Scaling Group (ASG)

Go to EC2 -> Select Auto Scaling -> Click Create Auto Scaling Group button
Name:ASG-1
Launch template:LT-1
VPC: Custom VPC
Availability Zones and subnets: Public Subnets in two AZs.
Click, Attach to an existing load balancer
    Click, Choose from your load balancer target groups
        Existing load balancer target groups:TG-1
Health checks:default
Monitoring: Enable group metrics collection within CloudWatch

Configure group size and scaling policies:
    Specify the size of the Auto Scaling group by changing the desired capacity. You can also specify minimum and maximum capacity limits. Your desired capacity must be within the limit range.
Scaling policies:
choose Target tracking scaling policy
    Metric type: Average CPU Utilization
