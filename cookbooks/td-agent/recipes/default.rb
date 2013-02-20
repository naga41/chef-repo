#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2011, Treasure Data, Inc.
#
package "curl" do
  action :install
end

group 'td-agent' do
  group_name 'td-agent'
  gid        403
  action     [:create]
end

user 'td-agent' do
  comment  'td-agent'
  uid      403
  group    'td-agent'
  home     '/var/run/td-agent'
  shell    '/bin/false'
  password nil
  supports :manage_home => true
  action   [:create, :manage]
end

directories = %w(/etc/td-agent /etc/td-agent/plugin)
directories.each do |name|
  directory '#{name}' do
    owner  'td-agent'
    group  'td-agent'
    mode   '0755'
    action :create
  end
end

case node['platform']
when "ubuntu"
  dist = 'lucid'
  dist = 'precise' if node['lsb']['codename'] == 'precise'

  execute "install from script" do
    command "curl -L http://toolbelt.treasure-data.com/sh/install-ubuntu-#{dist}.sh | sh"
  end
when "centos", "redhat"
  yum_repository "treasure-data" do
    url    "http://packages.treasure-data.com/redhat/$basearch"
    action :add
  end
end

template "/etc/td-agent/td-agent.conf" do
  mode   "0644"
  source "td-agent.conf.erb"
end

plugins = %w(mytail.rb in_tail_labeled_tsv.rb)
plugins.each do |plugin|
  template "/etc/td-agent/plugin/#{plugin}" do
    mode   "0644"
    source "#{plugin}.erb"
  end
end

package "td-agent" do
  options "-f --force-yes"
  action  :upgrade
end

service "td-agent" do
  action     [ :enable, :start ]
  subscribes :restart, resources(:template => "/etc/td-agent/td-agent.conf")
end
