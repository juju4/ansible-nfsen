require 'serverspec'

# Required by serverspec
set :backend, :exec

describe process('nfcapd') do
  its(:user) { should eq "netflow" }
end
#describe process('perl') do
#  its(:user) { should eq "netflow" }
#  its(:args) { should match /-w \/usr\/local\/bin\/nfsend/ }
#end
describe service('nfsen') do
  it { should be_enabled }
  it { should be_running }
end

describe port(9995) do
  it { should be_listening.with('udp') }
end

describe file('/var/www/nfsen/nfsen.php') do
  it { should be_file }
  it { should be_readable.by('others') }
end
describe file('/etc/nfsen.conf') do
  it { should be_file }
end
describe file('/usr/local/bin/nfsen') do
  it { should be_file }
  it { should be_executable }
end

describe command('wget -O - http://localhost/nfsen/nfsen.php') do
  its(:stdout) { should match /<title>NFSEN - Profile live <\/title>/ }
end

describe file('/var/run/nfsen/nfsen.comm') do
  it { should be_socket }
  it { should be_writable.by('owner') }
  it { should be_writable.by('group') }
end

#describe command('wget -O - http://localhost/nfsen/nfsight/index.php') do
describe command('wget -O - http://localhost/nfsen/plugins/nfsight/index.php') do
  its(:stdout) { should match /Nfsight: Network Visualization Application/ }
end

describe command('/usr/local/bin/nfsen --get-profile live') do
  its(:stdout) { should match /tstart/ }
  its(:stdout) { should match /updated/ }
end
