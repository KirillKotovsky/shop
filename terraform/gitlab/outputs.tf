output "external_ip_address_gitlab" {
  value = yandex_compute_instance.gitlabci.network_interface.0.nat_ip_address
}
