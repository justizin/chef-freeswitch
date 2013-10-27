#
# Cookbook Name:: freeswitch
# Recipe:: apt_repo
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

# Following http://wiki.freeswitch.org/wiki/Installation_Guide#Debian

file 'apt_freeswitch_list' do
  path    '/etc/apt/sources.list.d/freeswitch.list'
  content "deb http://files.freeswitch.org/repo/deb/debian/ #{node.lsb_codename} main"
end

execute 'curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add -'

