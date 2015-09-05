#
# Cookbook Name:: apache2
# Attributes:: apache
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node["platform"] == "ubuntu" && node["platform_version"].to_f >= 13.10
  default["apache"]["version"] = "2.4"
elsif node["platform"] == "debian" && node["platform_version"].to_f >= 8.0
  default["apache"]["version"] = "2.4"
elsif node["platform"] == "redhat" && node["platform_version"].to_f >= 7.0
  default["apache"]["version"] = "2.4"
elsif node["platform"] == "centos" && node["platform_version"].to_f >= 7.0
  default["apache"]["version"] = "2.4"
elsif node["platform"] == "fedora" && node["platform_version"].to_f >= 18
  default["apache"]["version"] = "2.4"
elsif node["platform"] == "opensuse" && node["platform_version"].to_f >= 13.1
  default["apache"]["version"] = "2.4"
elsif node["platform"] == "suse" && node["platform_version"].to_f >= 12
  default["apache"]["version"] = "2.4"
elsif node["platform"] == "freebsd" && node["platform_version"].to_f >= 10.0
  default["apache"]["version"] = "2.4"
else
  default["apache"]["version"] = "2.2"
end

# Where the various parts of apache are
case platform
when "redhat","centos","fedora"
  set[:apache][:dir]     = "/etc/httpd"
  set[:apache][:log_dir] = "/var/log/httpd"
  set[:apache][:user]    = "apache"
  set[:apache][:group]   = "apache"
  set[:apache][:binary]  = "/usr/sbin/httpd"
  set[:apache][:icondir] = "/var/www/icons/"
  set[:apache][:cache_dir] = "/var/cache/httpd"
when "suse"
  set[:apache][:dir]     = "/etc/apache2"
  set[:apache][:log_dir] = "/var/log/apache2"
  set[:apache][:user]    = "wwwrun"
  set[:apache][:group]   = "www"
  set[:apache][:binary]  = "/usr/sbin/httpd2"
  set[:apache][:icondir] = "/usr/share/apache2/icons/"
  set[:apache][:cache_dir] = "/var/cache/apache2"
when "debian","ubuntu"
  set[:apache][:dir]     = "/etc/apache2"
  set[:apache][:log_dir] = "/var/log/apache2"
  set[:apache][:user]    = "www-data"
  set[:apache][:group]   = "www-data"
  set[:apache][:binary]  = "/usr/sbin/apache2"
  set[:apache][:icondir] = "/usr/share/apache2/icons"
  set[:apache][:cache_dir] = "/var/cache/apache2"
when "arch"
  set[:apache][:dir]     = "/etc/httpd"
  set[:apache][:log_dir] = "/var/log/httpd"
  set[:apache][:user]    = "http"
  set[:apache][:group]   = "http"
  set[:apache][:binary]  = "/usr/sbin/httpd"
  set[:apache][:icondir] = "/usr/share/httpd/icons"
  set[:apache][:cache_dir] = "/var/cache/httpd"
else
  set[:apache][:dir]     = "/etc/apache2"
  set[:apache][:log_dir] = "/var/log/apache2"
  set[:apache][:user]    = "www-data"
  set[:apache][:group]   = "www-data"
  set[:apache][:binary]  = "/usr/sbin/apache2"
  set[:apache][:icondir] = "/usr/share/apache2/icons"
  set[:apache][:cache_dir] = "/var/cache/apache2"
end

###
# These settings need the unless, since we want them to be tunable,
# and we don't want to override the tunings.
###

# General settings
default[:apache][:listen_ports] = ["80","443"]
default[:apache][:contact] = "ops@example.com"
default[:apache][:timeout] = 300
default[:apache][:keepalive] = "On"
default[:apache][:keepaliverequests] = 100
default[:apache][:keepalivetimeout] = 5

# Security
default[:apache][:servertokens] = "Prod"
default[:apache][:serversignature] = "On"
default[:apache][:traceenable] = "On"

# mod_auth_openids
default[:apache][:allowed_openids] = Array.new

# Prefork Attributes
default[:apache][:prefork][:startservers] = 4
default[:apache][:prefork][:minspareservers] = 2
default[:apache][:prefork][:maxspareservers] = 32
default[:apache][:prefork][:serverlimit] = 400
default[:apache][:prefork][:maxclients] = 400
default[:apache][:prefork][:maxrequestsperchild] = 10000

# Worker Attributes
default[:apache][:worker][:startservers] = 4
default[:apache][:worker][:maxclients] = 1024
default[:apache][:worker][:minsparethreads] = 64
default[:apache][:worker][:maxsparethreads] = 192
default[:apache][:worker][:threadsperchild] = 64
default[:apache][:worker][:maxrequestsperchild] = 0