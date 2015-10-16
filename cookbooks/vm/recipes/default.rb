#
# Cookbook Name:: elastic-test
# Recipe:: default
#
# Author: var
#
# Copyright (c) 2015 Zühlke, All Rights Reserved.

#This frst, otherwise installation fails because the apt cache is not updated
include_recipe "apt"

node.set['java']['install_flavor'] = "oracle"
node.set['java']['jdk_version'] = "8"
node.set['java']['oracle']['accept_oracle_download_terms'] = "true"
include_recipe "java"

node.set['elasticsearch']['install_type'] = "package"
include_recipe 'elasticsearch'

node.set['kibana']['version'] = "3"
include_recipe 'kibana'

