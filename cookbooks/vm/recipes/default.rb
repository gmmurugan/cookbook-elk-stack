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
elasticsearch_plugin 'mobz/elasticsearch-head'
service 'elasticsearch' do
    action :start
end

node.set['kibana']['install_java'] = 'false'
node.set['kibana']['version'] = '4.1.2-linux-x64' 
node.set['kibana']['file']['url'] = 'https://download.elastic.co/kibana/kibana/kibana-4.1.2-linux-x64.tar.gz'
node.set['kibana']['webserver'] = 'nginx'
include_recipe 'kibana_lwrp::install'

include_recipe 'simple-logstash::default'
logstash_service 'logstash'

# example config requires special permissions to read logfile
group 'adm' do
	action :modify
  members 'logstash'
  append true
end
logstash_input 'syslog'
logstash_output 'logstash'
