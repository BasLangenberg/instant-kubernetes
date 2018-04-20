# "Instant Kubernetes"
An experiment with Digital Ocean, Terraform and Ansible. The idea is to setup a multi-system Kubernetes cluster on Digital Ocean to get familiar with the systems and experiment.

I'm doing this on Arch Linux, but the tools should be well available among Linux / OSX systems

## Why Are you doing this?
For fun, and to get some experience with Kubernetes. And to play with Terraform. And to play with Ansible. There are many reasons.

Main reason is that I want to be able to quickly provision a K8S cluster using a toolset I am comfortable with on a platform I like.

## Out of scope

Things currently out of scope, but might be added in the future:

 - HA of masters
 - Other stuff I did not think of

## Step 0: Software used
 - Doctl
 - Ansible
 - Terraform
 - Python 3

All installed using my system package manager.

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

### Provision servers

Pretty simple with terraform installed!

```
terraform apply -var "do_token=${DO_ACCESS_TOKEN}" -var "ssh_fingerprint=${DO_SSH_FINGERPRINT}"
```

### Destroy servers

```
terraform destroy -var "do_token=${DO_ACCESS_TOKEN}" -var "ssh_fingerprint=${DO_SSH_FINGERPRINT}"
```

Do this to preserve costs or when you want to reprovision.

## Step 2: Setup Kubernetes

Setup Ansible to ignore host keys

```
ANSIBLE_HOST_KEY_CHECKING=False
```

Start your ssh agent and add your key

```
eval $(ssh-agent)
ssh-add ~/.ssh/do_k8s
```

Now, generate your inventory

```
python generate_hosts_file.py > hosts
```

... And run Ansible

```
ansible-playbook -i hosts site.yml
```

After 15 minutes or so Kubernetes should be setup. During the provisioning of the initial master node, the playbook will pause for 5 minutes. In this time, you can check if the master is up in READY state (using kubectl locally, which will be setup) or you can just believe all is working and continue doing something else while the remainder of the cluster provisions.

## Step 3: Setup Client

This is done by the Ansible code! Your local machine will be able to use kubectl against the cluster immediately after the initial master is provisioned.

## Step 4: Setup Kubernetes Dashboard
First, deploy the Kubernetes dashboard.

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
```

After which you can start a local proxy

```
kubectl proxy
```

Make sure you [create a sample user](https://github.com/kubernetes/dashboard/wiki/Creating-sample-user) with a token to use with the dashboard.

## Step 5: Do some test deployment
TBD

## Step 6: Destroy all that just was
```
terraform destroy -var "do_token=${DO_ACCESS_TOKEN}" -var "ssh_fingerprint=${DO_SSH_FINGERPRINT}"
```

# Resources
[Doctl Cheat Sheet](https://www.digitalocean.com/community/tutorials/how-to-use-doctl-the-official-digitalocean-command-line-client)
[Kubernetes HA Guide](https://kubernetes.io/docs/setup/independent/high-availability/)
