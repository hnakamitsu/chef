#!/bin/sh -x
#
# Just to create ${WORKDIR}/hello.txt
#
. env.sh
mkdir ${WORKDIR}
cd ${WORKDIR}
cat > ${WORKDIR}/hello.rb <<EOF
file "${WORKDIR}/hello.txt" do
  content "Welcome to Chef\n2nd line"
end
EOF
chef-apply ${WORKDIR}/hello.rb
ls -la ${WORKDIR}/hello.txt
cat ${WORKDIR}/hello.txt
