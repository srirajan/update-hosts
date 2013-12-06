#
# Cookbook Name:: update_hosts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

hosts = partial_search(:node, '*:*',
   :keys => {
              'domain' => ['domain'],
              'fqdn' => [ 'fqdn' ],
              'hostname'   => [ 'hostname' ],
              'ip'   => [ 'ipaddress' ]
            })

template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :hosts => hosts
  )
end

# Add itself if missing
hostsfile_entry node['ipaddress'] do
  hostname node['hostname']
  action    :create_if_missing
end