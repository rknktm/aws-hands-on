1-Web-Tier-Sec-Group ......Inbound::HTTP-SSH-IPCM4    Source:0.0.0.0
2-App-Tier-Sec-Group ......Inbound::SSH-IPCM4         Source:Web-Tier-Sec-Group
3-Database-Sec-Group ......Inbound::SSH-IPCM4         App-Tier-Sec-Group
4-
LT for web-tier
TG
ELB
ASG

5-
LT for app-tier
TG
ELB
ASG

<!-- Windows Connection -->

1- open puttygen application
  1.1 Load maykey.pem 
  1.2 Click private key button
2- open pageant application
  2.1add mykey.pkk
3-First connect public Instance via puty
  3.1 Host Name: ec2-user@publicip
  3.2 SSH auth.... click add forwarding
  3.3 connect ec2
In Public Ec2
4- ssh ec2-user@privateIp of EC2 in private subnet

<!-- linux Connection -->
1- In terminal write command
   eval 'ssh-agent' bash              
2- ssh-add mykey.pem
3- ssh -A ec2-use@public instance ip
4- ssh ec2-user@private instance

or

user$ cd desktop/key

eval "$(ssh-agent)"
ssh-add -K key.pem
ssh -A ec2-user@publicip
ssh ec2-user@privateip