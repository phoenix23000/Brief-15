resource "azurerm_resource_group" "Kubernetes" {
   name = "LAST-cluster-Centos"
   location = var.location
}

# Create (and display) an SSH key
resource "tls_private_key" "SSH" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#### 2 Workers VM
 resource "azurerm_linux_virtual_machine" "test" {
    count                 = 2
    name                  = "worker${count.index}"
    location              = azurerm_resource_group.Kubernetes.location
    resource_group_name   = azurerm_resource_group.Kubernetes.name
    size                  = "Standard_D2ds_v4"
    network_interface_ids = [
     azurerm_network_interface.test["${count.index}"].id
    ]

 source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5"
    version   = "latest"
  }

    computer_name                   = "worker-${count.index}"
    admin_username                  = "momo"
    disable_password_authentication = true

    admin_ssh_key {
      username   = "momo"
      public_key = tls_private_key.SSH.public_key_openssh
   }

    os_disk {
      name = "OSdisk${count.index}"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
#   provisioner "file" {
#     content = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjsp8WwG5UMRWeWiNokvM60aXpl/C7pe+VFOOmFV4m+8ijupzeeGkGj7lJuwTft424DTQY/rvynfJuuc8BC9cFdrN1LbEZNq9alUaAR9klcLIVMWrUtU2UfCO6TA5RZ7Bcz7D+ENWkXZVFn0jzWlo1ILwQlY60hGdadW6gLgUBbgN7mLAz6v+cHoEnWjY6JOvGGL6sfU5C9f1/XYJVkZAJsGYKn67FH1idMuRM2B1P0l8cCcQaoPDi5cf3bPHj428ZGALA0StSr9didnyJ12ANzqzqt2wTEElcplEgIgs7JK50he1wtSAcmkF0ggdewt3vbRSuwUKxxDfKDgPtvyCcBIG107IvczXnPfYnF3Meul9LOeVE1sGAT8KmMFFnFk0eirAyuTY+63YvRydkr395O0Y/Tv7vKHW9HFvwc7864x1xq2/tkA0kTdgHRjJMHKLY8yoDTugB2L2ZY6Tl87CwQxmBAltznJ0vZHgBl7bxDZcjB0WwypRcNklffyxIe4U= momo@Jenkins2"
#     destination = "/home/momo/.ssh/authorized_keys"
#  }
#  connection {
#    type     = "ssh"
#    user     = "momo"
#    host     = azurerm_public_ip.test["${count.index}"].ip_address
#    private_key = tls_private_key.SSH.private_key_pem
#  }
}

 resource "azurerm_linux_virtual_machine" "Manager" {
    name                  = "manager"
    location              = azurerm_resource_group.Kubernetes.location
    resource_group_name   = azurerm_resource_group.Kubernetes.name
    size                  = "Standard_D2ds_v4"
    network_interface_ids = [
     azurerm_network_interface.test["${2}"].id
     ]

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5"
    version   = "latest"
  }

    computer_name                   = "manager"
    admin_username                  = "momo"
    disable_password_authentication = true

    admin_ssh_key {
     username   = "momo"
     public_key = tls_private_key.SSH.public_key_openssh
    }

    os_disk {
      name = "OSdisk"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
  
#  provisioner "file" {
#     content = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjsp8WwG5UMRWeWiNokvM60aXpl/C7pe+VFOOmFV4m+8ijupzeeGkGj7lJuwTft424DTQY/rvynfJuuc8BC9cFdrN1LbEZNq9alUaAR9klcLIVMWrUtU2UfCO6TA5RZ7Bcz7D+ENWkXZVFn0jzWlo1ILwQlY60hGdadW6gLgUBbgN7mLAz6v+cHoEnWjY6JOvGGL6sfU5C9f1/XYJVkZAJsGYKn67FH1idMuRM2B1P0l8cCcQaoPDi5cf3bPHj428ZGALA0StSr9didnyJ12ANzqzqt2wTEElcplEgIgs7JK50he1wtSAcmkF0ggdewt3vbRSuwUKxxDfKDgPtvyCcBIG107IvczXnPfYnF3Meul9LOeVE1sGAT8KmMFFnFk0eirAyuTY+63YvRydkr395O0Y/Tv7vKHW9HFvwc7864x1xq2/tkA0kTdgHRjJMHKLY8yoDTugB2L2ZY6Tl87CwQxmBAltznJ0vZHgBl7bxDZcjB0WwypRcNklffyxIe4U= momo@Jenkins2"
#     destination = "/home/momo/.ssh/authorized_keys"
#  }

#    connection {
#    type     = "ssh"
#    user     = "momo"
#    host     = azurerm_public_ip.test[2].ip_address
#    private_key = tls_private_key.SSH.private_key_pem
#  }
    depends_on = [azurerm_resource_group.Kubernetes]
}
