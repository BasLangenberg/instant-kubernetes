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
  image = "centos-7-x64"
  name = "k8s-primary-master"
  region = "ams3"
  size = "4gb"
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
}

## Create Kubernetes additional masters
#resource "digitalocean_droplet" "k8s-master" {
#  count = 2
#  image = "centos-7-x64"
#  name = "k8s-master-${count.index}"
#  region = "ams3"
#  size = "1gb"
#  ssh_keys = [
#    "${var.ssh_fingerprint}"
#  ]
#}
#
## Create Kubernetes computer nodes
resource "digitalocean_droplet" "k8s-workers" {
  count = 3
  image = "centos-7-x64"
  name = "k8s-worker-${count.index}"
  region = "ams3"
  size = "4gb"
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
}
