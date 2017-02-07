default['siem']['repo']         = "http://xpvlap2123.tfs.toyota.com/tfsrepo"
default['siem']['config_repo']  = "#{node['siem']['repo']}/ks/configs"
default['siem']['config_files'] = [ "/etc/rsyslog.conf" ] 
