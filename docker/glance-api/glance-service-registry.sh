#!/bin/bash -ex

KEYSTONE_ADDRESS=${1}
KEYSTONE_ADMIN_PORT=${2}

export OS_USERNAME=${3}
export OS_PASSWORD=${4}
export OS_PROJECT_NAME=${5}
export OS_DOMAIN_NAME=${6}

GLANCE_USER=${7}
GLANCE_PASSWORD=${8}

export OS_AUTH_URL=http://${KEYSTONE_ADDRESS}:${KEYSTONE_ADMIN_PORT}/v3
export OS_IDENTITY_API_VERSION=3

openstack user create --domain default --password ${GLANCE_PASSWORD} ${GLANCE_USER}
openstack role add --project ${OS_PROJECT_NAME} --user ${GLANCE_USER} admin
openstack service create --name glance --description "OpenStack Image service" image
openstack endpoint create --region RegionOne image public http://glance-api:9292
openstack endpoint create --region RegionOne image internal http://glance-api:9292
openstack endpoint create --region RegionOne image admin http://glance-api:9292
