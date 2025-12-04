Launch a Free Tier EC2 (Amazon Linux 2 t3.micro/t2.micro) in a public subnet and use a security group allowing inbound HTTP (80) and SSH (22) only from your IP. Use user_data to install Nginx and place index.html (your resume or a link to S3) in /usr/share/nginx/html. Harden by disabling password auth for SSH (use keypair), limit Security Group ingress to your IP, and enable automatic updates.

