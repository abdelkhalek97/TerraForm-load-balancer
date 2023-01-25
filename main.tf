module "vpc" {
  source               = "./Vpc"
  vpc-cidr             = "10.0.0.0/16"
  vpc-name             = "terraform"
  subnet_cidrs_public  = { public1 : "10.0.0.0/24", public2 : "10.0.1.0/24" }
  subnet_cidrs_private = { private1 : "10.0.2.0/24", private2 : "10.0.3.0/24" }

}
module "internetgateway1" {
  source              = "./internetGateway"
  internetgatewayName = "Terraform internetgateway"
  vpcid               = module.vpc.vpc_id

}

module "natG" {
  source         = "./natGateway"
  dependency     = module.internetgateway1.ig-id
  publicSubnetId = module.vpc.pup_subnet_id[0]

}

module "routing_public" {
  source              = "./routeTablePublic"
  vpcid               = module.vpc.vpc_id
  internetGatewayName = module.internetgateway1.ig-id
  tableName           = "public Route Table"
  subnet_ids          = module.vpc.pup_subnet_id
}

module "routing_private" {
  source         = "./routeTablePrivate"
  vpcid          = module.vpc.vpc_id
  natGatewayName = module.natG.nat_id
  tableName      = "private Route Table"
  subnet_ids     = module.vpc.priv_subnet_id
}

module "securityGroup" {
  source               = "./SecurityGroup"
  vpcid                = module.vpc.vpc_id
  pup-cidr             = "0.0.0.0/0"
  sg_name              = "security_group"
  sg_description       = "security_group"
  sg_from_port_ingress = 22
  sg_to_port_ingress   = 80
  sg_protocol_ingress  = "tcp"
  sg_from_port_egress  = 0
  sg_to_port_egress    = 0
  sg_protocol_egress   = "-1"
}

module "Nginx_public" {
  source                 = "./Ec2nginx"
  ami_id                 = "ami-06878d265978313ca"
  instType               = "t2.micro"
  subnet_ids             = module.vpc.pup_subnet_id
  secg_id                = module.securityGroup.sg_id
  name                   = "proxy"
  key_name               = "iti"
  connection_type        = "ssh"
  connection_user        = "ubuntu"
  connection_private_key = "./iti.pem"
  file_source            = "./nginx.sh"
  file_destination       = "/tmp/nginx.sh"
  inline                 = ["chmod 777 /tmp/nginx.sh", "/tmp/nginx.sh ${module.NetwowrkLB.Load_Balancer_DNS}"]

}

module "appTargetGroup" {
  source             = "./TargetGroup"
  ec2ids             = module.Nginx_public.instance_id
  vpcid              = module.vpc.vpc_id
  attach_target_port = 80
  target_name        = "application"
  target_port        = 80
  target_protocol    = "HTTP"
  health_protocol    = "HTTP"

  depends_on = [
    module.Nginx_public
  ]
}

module "ApplicationLB" {
  source            = "./APPloadBalancer"
  name              = "ALB"
  sg_id             = module.securityGroup.sg_id
  subnets           = module.vpc.pup_subnet_id
  target_group_arn  = module.appTargetGroup.Targetgroup_arn
  lb_internal       = false
  listener_port     = 80
  listener_protocol = "HTTP"

  depends_on = [
    module.appTargetGroup.Targetgroup_arn
  ]
}


module "nginx_private" {
  source          = "./Ec2nginx"
  ami_id_priv     = "ami-06878d265978313ca"
  instType_priv   = "t2.micro"
  subnet_ids_priv = module.vpc.priv_subnet_id
  secg_id_priv    = module.securityGroup.sg_id
  name_priv       = "private"
  key_name_priv   = "iti"


}

module "netTargetGroup" {
  source             = "./TargetGroup"
  ec2ids             = module.nginx_private.instance_id_priv
  vpcid              = module.vpc.vpc_id
  attach_target_port = 80
  target_name        = "network"
  target_port        = 80
  target_protocol    = "TCP"
  health_protocol    = "TCP"
  depends_on = [
    module.nginx_private
  ]
}



module "NetwowrkLB" {
  source            = "./NetloadBalancer"
  name              = "NLB"
  subnets           = module.vpc.priv_subnet_id
  target_group_arn  = module.netTargetGroup.Targetgroup_arn
  lb_internal       = true
  listener_port     = 80
  listener_protocol = "TCP"

  depends_on = [
    module.netTargetGroup.Targetgroup_arn
  ]

}
