# How to Install Nginx Web Server on EC2 Linux 2

## Outline

- Part 1 - Launching an Amazon Linux 2 EC2 instance and Connect with SSH

- Part 2 - Installing and Configuring Nginx Web Server to Run `Hello World` Page

- Part 3 - Automation of Web Server Installation through Bash Script


## Part 1 - Launching an Amazon Linux 2 EC2 instance and Connect with SSH

1. Launch an Amazon EC2 instance with setting seen below: 

AMI: "Amazon Linux 2"
Instance Type : "t2.micro"
Region: "N.Virginia"
VPC: "Default VPC"
Securtiy Group: "0.0.0.0/0-----> Port 22"

2. Connect to your instance with SSH.

ssh -i .....pem ec2-user@


## Part 3 - Installing and Configuring Nginx Web Server to Run `Hello World` Page

# STEP_1_ Default Nginx Web Server

3. Update the installed packages and package cache on your instance.


sudo yum update -y


4. Install the Nginx Web Server-default page


amazon-linux-extras install nginx1.12


5. Check status of the Nginx Web Server.

sudo systemctl status nginx
sudo systemctl start nginx


6. Enable the Nginx Web Server to survive the restarts then Check from browser with DNS.  Since the security group is available only for add HTTP add port 80 and show again.

sudo systemctl enable nginx

Securtiy Group: "0.0.0.0/0-----> Port 80"

# STEP_2_ Basic Customization of  Nginx Web Server

8. Set permission of the files and folders under `/usr/share/nginx/html` folder to everyone.


sudo chmod -R 777 /usr/share/nginx/html


9. Go to the /usr/share/nginx/html

cd /usr/share/nginx/html

10. Create a custom `index.html` file under `/usr/share/nginx/html` folder to be served on the Server.

echo "HELLO WORLD" > /usr/share/nginx/html/index.html

11. check the index.html
ls 
cat index.html

12. Restart the nginx server and `check` from browser.

sudo systemctl restart nginx


# STEP_3- Customization of  Nginx Web Server with HTML format

13. open index.html  file with nano editor.

cd /usr/share/nginx/html
nano index.html

14. clean the existing messsage then paste the html formatted code.

<html>
<head>
    <title> My First Web Server</title>
</head>
<body style="background-color:powderblue;">
    <center><h1>Hello to Everyone from My First Web Server</h1></center>
</body>
</html>

15. Save and exit and show with cat command

press Ctrl+X
      yes
cat index.html

16. Restart the Nginx Web Server.

sudo systemctl restart nginx

17. Check if the Web Server is working properly from the browser.

## Part 4 - Automation of Web Server Installation through Bash Script

18. Configure an Amazon EC2 instance with AMI as `Amazon Linux 2`, instance type as `t2.micro`, default VPC security group which allows connections from anywhere and any port.

19. Configure instance to automate web server installation with `user data` script.

#!/bin/bash
yum update -y
amazon-linux-extras install nginx1.12
yum install -y wget
cd /usr/share/nginx/html
rm index.html
wget https://raw.githubusercontent.com/rknktm/Html-Css/main/index.html
wget https://raw.githubusercontent.com/rknktm/Html-Css/main/contact.html
wget https://raw.githubusercontent.com/rknktm/Html-Css/main/about.html
wget https://raw.githubusercontent.com/rknktm/Html-Css/main/k8s.png
systemctl start nginx
systemctl enable nginx


20. Review and launch the EC2 Instance

21. Once Instance is on, check if the nginx Web Server is working from the web browser.

22. Connect the Nginx Web Server from the local terminal with `curl` command.


curl http://ec2-?-?-?-?.us-east-2.compute.amazonaws.com8.us-east-2.compute.amazonaws.com

