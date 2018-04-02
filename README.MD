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

In order to setup your infrastructure, you need to authenticate with your DigitalOcean account using the API. For this, we need an API key. We will also setup ssh keys which Ansible will use to connect to the Droplets to provision Kubernetes on them.

### DigitalOcean Key

In the DigitalOcean interface, click API. Create a read/write key to access the API.

Personally, I list a bunch of variables in a ~/.secrets file which I import in my shell if it exists. (For portability)

```
DO_ACCESS_TOKEN=IWONTTELLYOU
DO_SSH_FINGERPRINT="I ALSO WILL NOT TELL YOU"

export DO_ACCESS_TOKEN
export DO_SSH_FINGERPRINT
```

In my .zshrc, I have the following lines:

```
# Add secrets if present
if [[ -f ~/.secrets ]]; then
  source ~/.secrets
fi
```

### SSH Key

Generate a ssh key. On a Linux system this is easy.

```
ssh-keygen -t rsa
```

After this, put it into your DO account.

```
doctl compute ssh-key import dok8s --public-key-file ~/.ssh/do_k8s.pub
```

The output of the command will list the fingerprint of the key. Put it in your ~/.secrets file. Do not forget to source it.

### Provision test server

Explan how to test what was just build and provision a sample server to test all

### Destroy test server

Destroy the test server

### provision the 'real' servers

Repeat some earlier instructions

## Step 2: Setup Kubernetes

## Step 3: Setup Client

## Step 4: Setup Kubernetes Dashboard

## Step 5: Do some test deployment

## Step ?: Destroy all that just was

# Resources
(Doctl Cheat Sheet)[https://www.digitalocean.com/community/tutorials/how-to-use-doctl-the-official-digitalocean-command-line-client]
