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

fsbase = node[:freeswitch][:base_dir]
fsinst = node[:freeswitch][:install_dir]
fssrc = node[:freeswitch][:src_dir]

directory 'create_freeswitch_base' do
  path  fsbase
  mode  '0700'
  owner :freeswitch
  group :freeswitch
end

directory 'create_freeswitch_conf' do
  path  "#{fsbase}/conf/" # use path joining methods
  mode  '0700'
  owner :freeswitch
  group :freeswitch
end

template 'fs_conf_freeswitch_xml' do
  path   "#{fsbase}/conf/freeswitch.xml"
  source 'freeswitch.xml.erb'
end

directory 'create_freeswitch_directories_parent' do
  path  "#{fsbase}/conf/directory/"
  mode  '0700'
  owner :freeswitch
  group :freeswitch
end

directory 'create_freeswitch_customers_data_dir' do
  path  "#{fsbase}/customers/"
  mode  '0700'
  owner :freeswitch
  group :freeswitch
end

search(:freeswitch_customers, "*:*").each do |customer|

  cust_data_dir = "#{fsbase}/customers/#{customer.hostname}"
  cust_conf_dir = "#{fsbase}/customers/#{customer.hostname}"

  directory 'create_freeswitch_customer_conf_dir' do
    path  cust_conf_dir
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_data_dir' do
    path  cust_data_dir
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_dialplan_default_dir' do
    path  "#{cust_data_dir}/dialplan/ivr"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_dialplan_dialplan_dir' do
    path  "#{cust_data_dir}/dialplan/dialplan"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_dialplan_ivr_dir' do
    path  "#{cust_data_dir}/dialplan/ivr"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_dialplan_public_dir' do
    path  "#{cust_data_dir}/dialplan/public"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_dialplan_dir' do
    path  "#{cust_data_dir}/dialplan"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_directory_dir' do
    path  "#{cust_data_dir}/directory"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_ivr_dir' do
    path  "#{cust_data_dir}/ivr"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_recordings_dir' do
    path  "#{cust_data_dir}/recordings"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_scripts_dir' do
    path  "#{cust_data_dir}/scripts"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_sounds_dir' do
    path  "#{cust_data_dir}/sounds"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  directory 'create_freeswitch_customer_voicemail_dir' do
    path  "#{cust_data_dir}/voicemail"
    mode  '0700'
    owner :freeswitch
    group :freeswitch
  end

  customer[:extensions].each do |extension|

    template "create_freeswitch_customer_extension_#{extension.number}@#{customer.hostname}" do
      path   "#{fsbase}/conf/directory/#{customer.hostname}/#{extension.number}.xml"
      source 'freeswitch_customer_extension.xml.erb'
      mode   '0700'
      owner  :freeswitch
      group  :freeswitch
      variables({
        :extension => extension[:number],
        :customer_hostname => customer[:hostname]
      })
    end

  end

end
