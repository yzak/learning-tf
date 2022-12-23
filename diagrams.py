from diagrams import Cluster, Diagram, Edge
from diagrams.aws.network import InternetGateway
from diagrams.aws.network import RouteTable

with Diagram("learning-tf", show=False, direction="TB"):
    with Cluster("Region ap-northeast-1"):
        with Cluster("VPC 10.0.0.0/21"):
            InternetGateway("InternetGateway")
            with Cluster("AvalibitilyZone \n1c"):
                with Cluster("PublicSubnet \n10.0.1.0/24"):
                    RouteTable("RouteTable\n1c")
            with Cluster("AvalibitilyZone \n1a"):
                with Cluster("PublicSubnet \n10.0.0.0/24"):
                    RouteTable("RouteTable\n1a")
