#!/bin/bash

SERVERS=${SERVERS}

cat <<EOF > /etc/ntp.conf
driftfile /var/lib/ntp/ntp.drift
statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

EOF

LENGTH=$(echo ${SERVERS} | jq 'length')
LAST_INDEX=$((LENGTH-1))

for I in `seq 0 $LAST_INDEX`; do
  ADDR=$(echo $SERVERS | jq -r ".[$I]" )

  cat <<EOF >> /etc/ntp.conf
pool $ADDR iburst
EOF
done

cat <<EOF >> /etc/ntp.conf

restrict -4 default kod notrap nomodify nopeer noquery limited
restrict -6 default kod notrap nomodify nopeer noquery limited

restrict 127.0.0.1
restrict ::1

restrict source notrap nomodify noquery
EOF

service ntp restart
