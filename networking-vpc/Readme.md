Create a single VPC with a /16 CIDR to allow many subnets. Make two public subnets (one per AZ) and two private subnets (one per AZ). Attach an Internet Gateway for public internet access and provide outbound internet access from private subnets using a NAT Gateway (costly) or an optional NAT instance (free-tier friendly). Create route tables and associate them to subnets.


CIDR choices (exact)

VPC: 10.0.0.0/16 — plenty of address space in a private RFC1918 block.

Public Subnet A: 10.0.1.0/24

Public Subnet B: 10.0.2.0/24

Private Subnet A: 10.0.101.0/24

Private Subnet B: 10.0.102.0/24

Why: /16 for flexibility; /24 per subnet is simple and isolates public vs private addresses. Public subnets in lower /24s, private in 101/102 to make them distinctive.