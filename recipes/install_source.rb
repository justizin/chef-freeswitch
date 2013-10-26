#
# Cookbook Name:: freeswitch
# Recipe:: install-source
#
# Author:: Justin Alan Ryan (<bitmonk@bitmonk.net>)
#
# Copyright 2013, Justin Alan Ryan
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


# Roughly following http://wiki.freeswitch.org/wiki/Linux_Quick_Install_Guide

include_recipe 'build-essential'

# totally debuntufied and flat right now

package 'libjpeg-dev'
package 'libncurses-dev'

# deps for optional features

%w{ libcurl4-openssl-dev libexpat1-dev libssl-dev libtiff4-dev libx11-dev unixodbc-dev
    python-dev zlib1g-dev libzrtpcpp-dev libasound2-dev libogg-dev libvorbis-dev libperl-dev
    libgdbm-dev libdb-dev python-dev uuid-dev bison autoconf g++ libncurses-dev }.each do |pkgname|
  package pkgname
end

# considering using the application cookbook / resource for this, keeping it simple for now

git 'freeswitch_source_git' do
#  destination "#{Chef::Config[:file_cache_path]}/freeswitch"
  destination '/srv/freeswitch'
  repository node['freeswitch']['git_repository']
  reference  node['freeswitch']['git_revision']
  action :sync
  notifies :run, 'bash[compile_freeswitch]'
end

bash 'compile_freeswitch' do
  cwd '/srv/freeswitch'
  command 'sh ./bootstrap.sh && ./configure --prefix=/opt/freeswitch/ && make && make all install cd-sounds-install cd-moh-install'
end
