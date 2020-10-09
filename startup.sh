#!/bin/bash
sleep 60
## Print out island container Service IP and public keys into ssh_known_hosts file
{ echo -n "open-ondemand,"; \
printenv -0 $(echo -n "$INSTANCE_NAME" | tr [:lower:] [:upper:] | tr '-' '_' && echo -n "_CLUSTER_IP_SERVICE_HOST") && \
cat /etc/ssh/ssh_host_ecdsa_key.pub ;} >> /etc/ssh/ssh_known_hosts
{ echo -n "open-ondemand,"; \
printenv -0 $(echo -n "$INSTANCE_NAME" | tr [:lower:] [:upper:] | tr '-' '_' && echo -n "_CLUSTER_IP_SERVICE_HOST") && \
cat /etc/ssh/ssh_host_ed25519_key.pub ;} >> /etc/ssh/ssh_known_hosts
{ echo -n "open-ondemand,"; \
printenv -0 $(echo -n "$INSTANCE_NAME" | tr [:lower:] [:upper:] | tr '-' '_' && echo -n "_CLUSTER_IP_SERVICE_HOST") && \
cat /etc/ssh/ssh_host_rsa_key.pub ;} >> /etc/ssh/ssh_known_hosts

## Print out ondemand container Service IP and public keys into ssh_known_hosts file
{ echo -n "ondemand-island,"; \
ssh-keyscan -t ecdsa 2> /dev/null \
$(printenv $(echo -n "$INSTANCE_NAME" | tr [:lower:] [:upper:] | tr '-' '_' && echo -n "_ISLAND_SERVICE_HOST")) ;} >> /etc/ssh/ssh_known_hosts
{ echo -n "ondemand-island,"; \
ssh-keyscan -t ssh_host_ed25519_key 2> /dev/null \
$(printenv $(echo -n "$INSTANCE_NAME" | tr [:lower:] [:upper:] | tr '-' '_' && echo -n "_ISLAND_SERVICE_HOST")) ;} >> /etc/ssh/ssh_known_hosts
{ echo -n "ondemand-island,"; \
ssh-keyscan -t rsa 2> /dev/null \
$(printenv $(echo -n "$INSTANCE_NAME" | tr [:lower:] [:upper:] | tr '-' '_' && echo -n "_ISLAND_SERVICE_HOST")) ;} >> /etc/ssh/ssh_known_hosts

## Disable SSHD
sleep 60
supervisorctl stop sshd