#!/bin/bash
#
# Run this script with root privileges. Report bugs at: https://github.com/IBM/csm-dach-cloud-native-labs/issues
#
# Choose how many users you want and their password. Replace PW with your password
NUMBER_USERS=15
PASSWORD=PW
#
# Install podman
yum install -y podman git
# Copy the download link for your operating system from the web console.
OC_DOWNLOAD_LINK=https://downloads-openshift-console.externaldemo-5115c94768819e85b5dd426c66340439-0000.eu-de.containers.appdomain.cloud/amd64/linux/oc.tar
#
# Get oc binary
wget $OC_DOWNLOAD_LINK
tar -xf oc.tar
chmod 777 oc
mv oc /usr/bin/
#
# Add auto completion
oc completion bash > /etc/bash_completion.d/oc_bash_completion
#
# Create group + user
groupadd devUsers
chown root:devUsers /usr/bin/oc
for NUM in $(seq 1 $NUMBER_USERS)
	do
	useradd -G devUsers user$NUM
	echo user${NUM}:${PASSWORD} | chpasswd
	echo "Created user${NUM}"
	done
