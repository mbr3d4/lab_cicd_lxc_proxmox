sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config   
systemctl restart sshd.service

sudo passwd root
ssh-copy-id root@192.168.0.148
ansible-playbook playbook.yml -i hosts