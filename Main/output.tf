output "Cle_publique" {
  value     = module.ChildResources.pub   # appel des outputs enfants
  sensitive = true
}

output "Cle_privee" {
    value   = module.ChildResources.private
    sensitive = true
}

output "IP_worker_0" {
  value = module.ChildResources.IP_pub_worker_0
}

output "IP_worker_1" {
  value = module.ChildResources.IP_pub_worker_1
}

output "IP_manager" {
  value = module.ChildResources.IP_pub_manager
}
