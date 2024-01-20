service=$1

mkdir -p "${XDG_CACHE_HOME}/service-status"

if [ ! -f "${XDG_CACHE_HOME}/service-status/status.json" ]; then
  echo '{}' >"${XDG_CACHE_HOME}/service-status/status.json"
fi

time=$(date +"%a %m-%d %H:%M")

jq \
  --arg service "$service" \
  --arg status "$EXIT_STATUS" \
  --arg result "$SERVICE_RESULT" \
  --arg time "$time" \
  '.[$service] = { "status": $status, "time": $time, "result": $result }' \
  "${XDG_CACHE_HOME}/service-status/status.json" | sponge "${XDG_CACHE_HOME}/service-status/status.json"

all_successful=$(jq '. | all(.status == "0")' "${XDG_CACHE_HOME}/service-status/status.json")

if [ "$all_successful" = "true" ]; then
  echo '{"icon":"net_bridge","state":"Good"}' >"${XDG_CACHE_HOME}/service-status/icon.json"
else
  echo '{"icon":"net_bridge","state":"Critical"}' >"${XDG_CACHE_HOME}/service-status/icon.json"
fi
