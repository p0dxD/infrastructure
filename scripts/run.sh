echo "Turning swap off"
swapoff -a
cat /proc/meminfo | grep 'SwapTotal'
echo "Finished."
sleep 2

echo "Will install docker"
apt remove docker docker-engine docker.io
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"
apt update
apt install -y docker-ce
usermod -aG docker $USER
docker run hello-world
echo "Finished installing docker."
sleep 2

bash -c 'cat > /etc/docker/daemon.json <<EOF
{
	  "exec-opts": ["native.cgroupdriver=systemd"],
	    "log-driver": "json-file",
	      "log-opts": {
	          "max-size": "100m"
		    },
	      "storage-driver": "overlay2"
      }
EOF'

mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload
systemctl restart docker

echo "Finixhed setting up docker."
sleep 2
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
bash -c "cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF"

apt-get update
apt-get upgrade
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
kubeadm version
kubelet --version
kubectl version

echo "Finished installation you can join cluster now."

