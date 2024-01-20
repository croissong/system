fix=${1:-false}

davmail &
davmailPID=$!
while ! ncat -z localhost 1080; do
  sleep 0.5
done

if [ "$fix" = "fix" ]; then
  vdirsyncer discover calendar_wrk_dw
else
  vdirsyncer sync
fi

# if intercatve
khal list

kill $davmailPID
