# ELK
# Elasticsearch 

resource "yandex_compute_instance" "elasticsearch" {

  zone = "ru-central1-b"
  name = "elasticsearch"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oshj0osht8svg6rfs"
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-3.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./elastic-install.yaml")}"
  }
}

#Kibana

resource "yandex_compute_instance" "kibana" {

  zone = "ru-central1-b"
  name = "kibana"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oshj0osht8svg6rfs"
      size = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-5.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./kibana-install.yaml")}"
  }
}

output "elastic" {
  value = yandex_compute_instance.elasticsearch.network_interface.0.ip_address
} 

output "kibana" {
  value = yandex_compute_instance.kibana.network_interface.0.ip_address
} 

output "kibana_pub" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}  