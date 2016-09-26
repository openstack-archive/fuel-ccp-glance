set -ex

wget {{ cirros_image_url }} -O /tmp/cirros.img
openstack image create --public --disk-format qcow2 --file /tmp/cirros.img cirros
rm /tmp/cirros.img
