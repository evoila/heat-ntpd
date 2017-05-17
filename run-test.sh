openstack stack create -t test/ntpd.yaml\
 -e test/lib/heat-iaas/resources.yaml\
 -e test/lib/heat-common/resources-ubuntu.yaml\
 -e resources-ubuntu.yaml\
 --parameter key=$1\
 --parameter image=$2\
 --parameter flavor=$3\
 --parameter public_network=$4\
 --wait\
 test-ntpd
