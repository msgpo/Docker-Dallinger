#!/bin/bash
# Container script

service postgresql start
runuser -l postgres -c "createuser -ds root"
createuser dallinger
createdb -O dallinger dallinger
sed /etc/postgresql/9.5/main/pg_hba.conf -e 's/md5/trust/g' --in-place
sed -e "s/[#]\?listen_addresses = .*/listen_addresses = '*'/g" -i '/etc/postgresql/9.5/main/postgresql.conf'
service postgresql reload
echo "Setup complete... Running experiment"
cd /home/Dallinger/demos/dlgr/demos/bartlett1932
dallinger debug --verbose
