from diagrams import Cluster, Diagram
from diagrams.aws.network import CF
from diagrams.aws.network import InternetGateway
from diagrams.aws.network import RouteTable
from diagrams.aws.network import ALB
from diagrams.aws.network import Route53
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.aws.storage import EFS
from diagrams.aws.compute import EC2AutoScaling

with Diagram("learning-tf", show=False, direction="TB"):
    with Cluster("AWS for development"):
        r53 = Route53("Route53")
        cdn = CF("CloudFront")
        with Cluster("Region ap-northeast-1"):
            with Cluster("VPC 10.0.0.0/21"):
                igw = InternetGateway("InternetGateway")
                alb = ALB("ALB")
                efs = EFS("EFS")
                scaling = EC2AutoScaling("AutoScaling")
                with Cluster("AvalibitilyZone \n1a"):
                    with Cluster("PrivateSubnet \n10.0.2.0/24"):
                        db = RDS("DB")
                        RouteTable("RouteTable\n1a")
                    with Cluster("PublicSubnet \n10.0.0.0/24"):
                        ec2_1a = EC2("EC2")
                        RouteTable("RouteTable\n1a")
                with Cluster("AvalibitilyZone \n1c"):
                    with Cluster("PublicSubnet \n10.0.1.0/24"):
                        ec2_1c = EC2("EC2")
                        RouteTable("RouteTable\n1c")
                    with Cluster("PrivateSubnet \n10.0.3.0/24"):
                        RouteTable("RouteTable\n1c")
                cdn >> igw >> alb >> scaling
                scaling >> ec2_1a
                scaling >> ec2_1c
                ec2_1a >> efs
                ec2_1c >> efs
