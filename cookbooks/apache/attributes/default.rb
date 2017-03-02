default["apache"]["sites"]["vv25592"] = {"site_title" => "vv25592 website", "port" => 80, "domain" => "vv25592.mylabserver.com" }
default["apache"]["sites"]["vv25592b"] = { "site_title" => "vv25592b website", "port" => 80, "domain" => "vv25592b.mylabserver.com" }
default["apache"]["sites"]["local"] = { "site_title" => "local website", "port" => 80, "domain" => "192.168.56.101" }
default["apache"]["sites"]["vv25593"] = { "site_title" => "vv25593 website", "port" => 80, "domain" => "vv25593.mylabserver.com" }

case node["platform"]
when "centos"
	default["apache"]["package"] = "httpd"
when "ubuntu"
	default["apache"]["package"] = "apache2"
end
