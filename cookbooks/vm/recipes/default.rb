#
# Cookbook Name:: elastic-test
# Recipe:: default
#
# Author: var
#
# Copyright (c) 2015 Zühlke, All Rights Reserved.

#This frst, otherwise installation fails because the apt cache is not updated
include_recipe "apt"
include_recipe 'elasticsearch'
