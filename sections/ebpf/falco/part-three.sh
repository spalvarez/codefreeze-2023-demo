vim /etc/systemd/system/k3s.service
# add these lines to after the k3s server command.
# --kube-apiserver-arg=audit-log-path=/var/lib/rancher/audit/audit.log
# --kube-apiserver-arg=audit-policy-file=/var/lib/rancher/audit/audit-policy.yaml
# --kube-apiserver-arg=audit-webhook-config-file=/var/lib/rancher/audit/webhook-config.yaml

sudo systemctl daemon-reload &&  sudo systemctl restart k3s
sudo systemctl status k3s.service


#### This is what the final k3s.service looks like
# [Unit]
# Description=Lightweight Kubernetes
# Documentation=https://k3s.io
# Wants=network-online.target
# After=network-online.target

# [Install]
# WantedBy=multi-user.target

# [Service]
# Type=notify
# EnvironmentFile=-/etc/default/%N
# EnvironmentFile=-/etc/sysconfig/%N
# EnvironmentFile=-/etc/systemd/system/k3s.service.env
# KillMode=process
# Delegate=yes
# # Having non-zero Limit*s causes performance problems due to accounting overhead
# # in the kernel. We recommend using cgroups to do container-local accounting.
# LimitNOFILE=1048576
# LimitNPROC=infinity
# LimitCORE=infinity
# TasksMax=infinity
# TimeoutStartSec=0
# Restart=always
# RestartSec=5s
# ExecStartPre=-/sbin/modprobe br_netfilter
# ExecStartPre=-/sbin/modprobe overlay
# ExecStart=/usr/local/bin/k3s \
#     server \
#         '--tls-san' \
#         '192.168.64.26' \
#         '--cluster-init' \
#         '--kube-apiserver-arg=audit-log-path=/var/lib/rancher/audit/audit.log' \
#         '--kube-apiserver-arg=audit-policy-file=/var/lib/rancher/audit/audit-policy.yaml' \
#         '--kube-apiserver-arg=audit-webhook-config-file=/var/lib/rancher/audit/webhook-config.yaml'
