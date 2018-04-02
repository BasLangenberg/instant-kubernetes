# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}
variable "ssh_fingerprint" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create Kubernetes first master
resource "digitalocean_droplet" "k8s-primary-master" {
  image = "ubuntu-16-04-x64"
  name = "k8s-primary-master"
  region = "ams3"
  size = "1gb"
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
}

# Create Kuberneter additional masters
#resource "digitalocean_droplet" "k8s-primary-master" {
#  image = "ubuntu-16-04-x64"
#  name = "k8s-primary-master"
#  region = "ams3"
#  size = "1gb"
#  ssh_keys = [
#    "${var.ssh_fingerprint}"
#  ]
#}
#resource "vsphere_virtual_machine" "some-vm" {
#  count = "3"
#  name   = "test-vm-${cound.index + 1}"
#  vcpu   = 2
#  memory = 4096
#  # ...
#}
# Create Kubernetes compute nodes
