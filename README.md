This repository contains solutions for all five tasks of the AWS Cloud Assessment. Each task has been implemented using AWS Free Tier, and Infrastructure as Code (IaC) using Terraform.
A separate folder is created for each question, containing:

Terraform code

Task-specific README.md

AWS screenshots

This root README provides a consolidated overview of the entire project.


📌 Repository Structure
/
|-- Task1_VPC/
|   |-- main.tf
|   |-- README.md
|   |-- screenshots
|
|-- Task2_EC2_StaticWebsite/
|   |-- main.tf
|   |-- user_data.sh
|   |-- README.md
|   |-- screenshots
|
|-- Task3_HA_ALB_ASG/
|   |-- main.tf
|   |-- README.md
|   |-- screenshots
|
|-- Task4_Billing_Alerts/
|   |-- steps.md
|   |-- screenshots
|
|-- Task5_ArchitectureDiagram/
|   |-- architecture.png
|   |-- architecture.drawio
|   |-- README.md
|
|-- README.md   ← (this file)




📘 Task 1: Networking & Subnetting (AWS VPC Setup)

Created a custom VPC with public and private subnets across two Availability Zones. 
Attached an Internet Gateway and created a NAT Gateway for secure outbound traffic from private subnets.
Each resource is tagged with the prefix FirstName_LastName_.

Deliverables

✔ 1 VPC
✔ 2 Public Subnets
✔ 2 Private Subnets
✔ Internet Gateway
✔ NAT Gateway
✔ Route Tables
✔ Terraform code
✔ Screenshots

CIDR Ranges Used
Resource	CIDR
VPC	10.0.0.0/16
Public Subnet 1	10.0.1.0/24
Public Subnet 2	10.0.2.0/24
Private Subnet 1	10.0.3.0/24
Private Subnet 2	10.0.4.0/24

📘 Task 2: EC2 Static Website Hosting

Launched a free-tier EC2 instance in the public subnet, installed Nginx using a user-data script, and deployed a static resume website.
Configured Security Groups and followed hardening steps.

Hardening Steps

Allowed only port 22 (SSH) & 80 (HTTP)

Disabled password SSH login

Applied least privilege SG rules

Enabled automatic OS updates

Deliverables

✔ EC2 instance screenshot
✔ Security Group screenshot
✔ Website browser screenshot
✔ Terraform code + user-data script

📘 Task 3: High Availability + Auto Scaling

Migrated EC2 setup to private subnets and deployed an Application Load Balancer (ALB) in public subnets. Created an Auto Scaling Group (ASG) across two AZs for high availability.

Traffic Flow

Public User → ALB → Target Group → Private EC2 Instances (via ASG)

Deliverables

✔ ALB configuration
✔ Target group screenshot
✔ Auto Scaling Group
✔ EC2 instances launched via ASG
✔ Terraform code

📘 Task 4: Billing & Free Tier Cost Monitoring

Created a CloudWatch Billing Alarm at ₹100 and enabled Free Tier usage alerts to avoid unexpected charges.

Why cost monitoring is important?

Prevents accidental charges

Detects unused running resources

Helps beginners avoid surprise bills

What causes sudden bill increases?

EC2 left running

NAT Gateway costs

Data transfer

Paid RDS instances

Load balancers

S3 PUT/GET operations at scale

Deliverables

✔ Billing alarm screenshot
✔ Free Tier usage alerts screenshot

📘 Task 5: Architecture Diagram (draw.io)


Designed a scalable 3-tier architecture supporting 10,000 concurrent users. 
Includes ALB, ASG, RDS, ElastiCache, security layers, and observability services.

Deliverables

✔ draw.io source file
✔ PNG/PDF diagram
✔ Short architecture explanation


### 🔗 Project Repository  
👉 [Click Here to View the GitHub Repo](https://github.com/akshayyadav63/aws-assessment-akshay-kumar-)


🧹 Cleanup
All AWS resources were deleted after completion to avoid charges.



