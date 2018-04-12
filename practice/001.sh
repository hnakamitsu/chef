#!/bin/sh -x
#
# Just to create ${WORKDIR}/hello.txt
#
. env.sh
mkdir ${WORKDIR}
cd ${WORKDIR}
cat > ${WORKDIR}/hello.rb <<EOF
file '${WORKDIR}/hello.txt' do
  content 'Welcome to Chef\n2nd line'
end
EOF
chef-apply ${WORKDIR}/hello.rb
ls -la ${WORKDIR}/hello.txt
cat ${WORKDIR}/hello.txt
sleep 10

# Syntax check
cookstyle ${WORKDIR}/hello.rb
sleep 10

# inspec(unittest)
cat > ${WORKDIR}/hello_test.rb <<EOF
describe file('${WORKDIR}/hello.txt') do
  it {should be_file}
  its('content') {should match('Welcome to Chef')}
end
EOF
inspec exec hello_test.rb
sleep 10

# uninstall
cat > ${WORKDIR}/hello.rb <<EOF
file '${WORKDIR}/hello.txt' do
  action :delete
end
EOF
chef-apply ${WORKDIR}/hello.rb
ls -la ${WORKDIR}/hello.txt
