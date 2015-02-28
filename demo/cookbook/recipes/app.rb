execute 'pkg update'

package 'ruby'

user 'hello' do
  system true
  home '/usr/local/opt/hello'
end

directory '/usr/local/opt/hello' do
  owner 'hello'
  action :create
  recursive true
end

cookbook_file '/tmp/hello.tar.gz' do
  source 'hello.tar.gz'
end

ohai 'grab the user' do
  action :reload
end

execute 'tar xzf hello.tar.gz' do
  user 'hello'
  cwd '/usr/local/opt'
  command '/usr/bin/tar xzf /tmp/hello.tar.gz'
end

file '/usr/local/etc/rc.d/hello' do
  group 'wheel'
  mode '0755'
  content <<-eos
#!/bin/sh

. /etc/rc.subr

name=hello
start_cmd="${name}_start"
pidfile=/usr/local/opt/hello/hello.pid
stop_cmd="kill $(cat ${pidfile})"

hello_start()
{
  export GEM_HOME=/usr/local/opt/hello/vendor/bundle/ruby/2.2.0
  su -l hello -c "GEM_HOME=$GEM_HOME exec $GEM_HOME/bin/rackup -I./lib -E production -D -P hello.pid -o 0.0.0.0"
}

load_rc_config $name
run_rc_command $1
  eos
end

service 'hello' do
  action %w(enable start)
end
