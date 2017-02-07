#
# Cookbook Name:: bts-siem
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

# Is this running in TCD or TCX?
net = node['default_gateway'].split(".")

case net[1]
when "60"
  site = "tcd"
when "61"
  site = "tcx"
else
  return
end

# Process configuration files
node['siem']['config_files'].each do |cfg|
  execute "siem_create_backup" do
    command "cp -pR #{cfg} #{cfg}.`date '+%d%b%Y__%H%M'`"
    only_if { ::File.exist?(cfg) }
  end
  
  # Download site-specific configuration
  path = File.dirname(cfg)
  filename = "#{site}." + File.basename(cfg)
  
  # Copy to original path
  remote_file "#{path}/#{filename}" do
    source "#{node['siem']['config_repo']}/#{filename}"
  end
end

