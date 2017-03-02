#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "php" do
	package_name node["php"]["package"]
end
cookbook_file "etc/php.ini" do
	source "php.ini"
	mode "0644"
	end
