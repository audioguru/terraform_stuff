#VNet Stuff
resource "azurerm_virtual_network" "mynet"{
  name="table3jsvnet"
  address_space=["10.0.0.0/16"]
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  tags{
    envrionment="Testing"
  }
}
resource "azurerm_subnet" "mysub"{
  name="table3jssubnet"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  virtual_network_name="${azurerm_virtual_network.mynet.name}"
  address_prefix="10.0.1.0/24"
}
resource "azurerm_public_ip" "myip"{
  name="table3jspublicip"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  public_ip_address_allocation="static"
  tags{
    environment="Testing"
  }
  provisioner "local-exec" {
    command = "echo ${self.ip_address}"
    on_failure = "continue"
  }
  provisioner "local-exec" {
    command = "echo 'Adios Pub Ip'"
    when = "destroy"
  }
}
resource "azurerm_network_security_group" "secgroup" {
  name="${var.sec_group_name}"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  security_rule{
    name="SSH"
    priority=1003
    direction="Inbound"
    access="Allow"
    protocol="Tcp"
    source_port_range="*"
    destination_port_range="22"
    source_address_prefix="*"
    destination_address_prefix="*"
  }
  security_rule{
    name="HTTP"
    priority=1004
    direction="Inbound"
    access="Allow"
    protocol="Tcp"
    source_port_range="*"
    destination_port_range="80"
    source_address_prefix="*"
    destination_address_prefix="*"
  }
  tags{
    environment="Testing"
  }
}  
