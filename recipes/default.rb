#
# Cookbook Name:: elastic-test
# Recipe:: default
#
# Author: zena
#
# Copyright (c) 2015 Zuehlke, All Rights Reserved.

# This frst, otherwise installation fails because the apt cache is not updated
include_recipe 'apt'

node.set['java']['install_flavor'] = 'oracle'
node.set['java']['jdk_version'] = '8'
node.set['java']['oracle']['accept_oracle_download_terms'] = 'true'
include_recipe 'java'

node.set['elasticsearch']['install_type'] = 'package'
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

# declared here so we can notify it
service 'procps'
service 'rsyslog'

# disable ipv6
file '/etc/sysctl.d/60-disable-ipv6.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  content <<-EOF
    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
    EOF
  notifies :restart, 'service[procps]', :immediately
end

file '/etc/rsyslog.d/60-fwd-remote.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  content <<-EOF
    local0.* @@127.0.0.1:10514
    EOF
  notifies :restart, 'service[rsyslog]', :immediately
end

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

# initialize logstash / kibana with an initial log message
file '/var/run/elk-stack.firstrun' do
  notifies :restart, 'logstash_service[logstash]', :immediately
  notifies :restart, 'runit_service[kibana]', :immediately
  notifies :run, 'execute[first-log]', :delayed
end
execute 'first-log' do
  command 'sleep 5 && logger -p local0.info "very first log message to kick things off"'
  action :nothing
end
