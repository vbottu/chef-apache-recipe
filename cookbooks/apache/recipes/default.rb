#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2017, vv2599
#
# All rights reserved - Do Not Redistribute
#
if node["platforn"] == "ubuntu"
	execute "apt-get update -y" do
	end	
end
package "httpd" do
	package_name node["apache"]["package"]
end
if node["platform"] == "centos"
package "epel-release" do
	action :install
end
end
#package "nginx" do
#	action :install
#end

node["apache"]["sites"].each do |sitename, data|
	document_root = "/content/sites/#{sitename}"
	directory document_root do
		mode "0755"
		recursive true
	end
if node["platform"] == "ubuntu"
	template_location ="/etc/apache2/sites-enabled/#{sitename}.conf"
elsif node["platform"] == "centos"
	template_location = "/etc/httpd/conf.d/#{sitename}.conf"
end
if node["platform"]=="ubuntu"
template template_location  do

	source "vhost.erb"
	mode "0644"
	variables(
		 :document_root => document_root,
		 :port  => data["port"],	
		 :domain => data["domain"]
	)
	notifies :restart, "service[httpd]"
	end
elsif node["platform"]=="centos"
template template_location  do

        source "vhostc.erb"
        mode "0644"
        variables(
                 :document_root => document_root,
                 :port  => data["port"],        
                 :domain => data["domain"]
        )
        notifies :restart, "service[httpd]"
        end
end
template "/content/sites/#{sitename}/index.html" do
	source "index.html.erb"
	mode "0644"
	variables(
		:site_title => data["site_title"],
		:comingsoon => "Coming Soon!"
	)
	end
end

execute "rm /etc/httpd/conf.d/welcome.conf" do
	only_if do
		File.exist?("/etc/httpd/conf.d/welcome.conf")
	end
	notifies :restart, "service[httpd]"
	end
service "httpd" do
	service_name node["apache"]["package"]
	action [:enable, :start]
end
include_recipe "php::default"
