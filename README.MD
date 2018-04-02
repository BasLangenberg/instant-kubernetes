# "Instant Kubernetes"
An experiment with Digital Ocean, Terraform and Ansible. The idea is to setup a multi-system Kubernetes cluster on Digital Ocean to get familiar with the systems and experiment.

I'm doing this on Arch Linux, but the tools should be well available among Linux / OSX systems

## Step 0: Software used
 - Doctl
 - Ansible
 - Terraform

All installed using my systems package manager.

```
trizen -S doctl-bin terraform ansible
```

## Step 1: Bring up infrastructure using terraform

Some intro story

### DigitalOcean Key

Explain you need to setup a secret file which is included in your shell or import it automatically

### SSH Key

Explain how to setup ssh keys with doctl and ssh-keygen and how to add the fingerprint to your secret file

### Provision test server

Explan how to test what was just build and provision a sample server to test all

### Destroy test server

Destroy the test server

### provision the 'real' servers

Repeat some earlier instructions

## Step 2: Setup Kubernetes

## Step 2: Setup Client

## Step 4: Setup Kubernetes Dashboard

## Step 5: Do some test deployment

## Step ?: Destroy all that just was
