# AWS CLI

# Installation

# Win:
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

# Linux:
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip  #install "unzip" if not installed
sudo ./aws/install


# Configuration

aws configure

cat .aws/config
cat .aws/credentials

aws configure --profile user1

export AWS_PROFILE=user1
export AWS_PROFILE=default

aws configure list-profiles

aws sts get-caller-identity

# IAM
aws iam list-users

aws iam create-user --user-name aws-cli-user

aws iam delete-user --user-name aws-cli-user


# S3
aws s3 ls

aws s3 mb s3://eco-bucket  #mb:make bucket

aws s3 cp test.yaml s3://eco-bucket

aws s3 ls s3://eco-bucket

aws s3 rm s3://eco-bucket/test.yaml

aws s3 rb s3://eco-bucket   #remove bucket

aws s3 rb s3://eco-bucket --force #  first remove all of the objects in the bucket and then remove the bucket itself

aws s3 sync . s3://mybucket

# user syncs the bucket --mybucket-- to the local current directory. 
# The local current directory contains the files test.txt and test2.txt. 
# The bucket mybucket contains no objects

Output:
# upload: test.txt to s3://mybucket/test.txt
# upload: test2.txt to s3://mybucket/test2.txt

# Sync from S3 bucket to another S3 bucket
aws s3 sync s3://mybucket s3://mybucket2

# Sync from S3 bucket to local directory
aws s3 sync s3://mybucket .

# EC2
aws ec2 describe-instances

aws ec2 run-instances \
   --image-id ami-0022f774911c1d690 \
   --count 1 \
   --instance-type t2.micro \
   --key-name virgin KEY_NAME_HERE # put your key name

aws ec2 describe-instances \
   --filters "Name = key-name, Values = KEY_NAME_HERE" # put your key name

aws ec2 describe-instances --query "Reservations[].Instances[].PublicIpAddress[]"

aws ec2 describe-instances \
   --filters "Name = key-name, Values = KEY_NAME_HERE" --query "Reservations[].Instances[].PublicIpAddress[]" # put your key name

aws ec2 describe-instances \
   --filters "Name = instance-type, Values = t2.micro" --query "Reservations[].Instances[].InstanceId[]"

aws ec2 describe-instances --query "Reservations[].Instances[].State[].Name[]" --output text

# To filter for instances with the specified type and Availability Zone
aws ec2 describe-instances \
    --filters Name=instance-type,Values=t2.micro,t3.micro Name=availability-zone,Values=us-east-1a

# To filter for instances with the specified my-team tag value
aws ec2 describe-instances \
    --filters "Name=tag-value,Values=my-team"

# To filter instances of the specified type and only display their instance IDs

# to stop instance
aws ec2 stop-instances --instance-ids INSTANCE_ID_HERE # put your instance id
# or
aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --query "Reservations[].Instances[].InstanceId[]" --output text)

#to statrt instance
aws ec2 start-instances --instance-ids $(aws ec2 describe-instances \
   --filters "Name = instance-type, Values = t2.micro" --query "Reservations[].Instances[].InstanceId[]" --output text)

#to terminate instance
aws ec2 terminate-instances --instance-ids INSTANCE_ID_HERE # put your instance id
# or
aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances \
   --filters "Name = instance-type, Values = t2.micro" --query "Reservations[].Instances[].InstanceId[]" --output text)

# Working with the latest Amazon Linux AMI
aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1

aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text


aws ec2 run-instances \
   --image-id $(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text) \
   --count 1 \
   --instance-type t2.micro



# Update AWS CLI Version 1 on Amazon Linux (comes default) to Version 2
# Remove AWS CLI Version 1
sudo yum remove awscli -y # pip uninstall awscli/pip3 uninstall awscli might also work depending on the image

# Install AWS CLI Version 2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip  #install "unzip" if not installed
sudo ./aws/install

# Update the path accordingly if needed
export PATH=$PATH:/usr/local/bin/aws