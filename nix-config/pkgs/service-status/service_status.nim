import os, json, strformat, times
import notify

let service = paramStr(1)
let cacheDir = getEnv("XDG_CACHE_HOME") / "service-status"
let statusFile = cacheDir / "status.json"
let iconFile = cacheDir / "icon.json"

createDir(cacheDir)

var statusJson = %*{}
try:
  let jsonString = readFile(statusFile)
  statusJson = parseJson(jsonString)
except: discard


# https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#Environment%20Variables%20Set%20or%20Propagated%20by%20the%20Service%20Manager
let exitStatus = getEnv("EXIT_STATUS")
let result = getEnv("SERVICE_RESULT")

if exitStatus != "0":
  let n = newNotifyClient("foo")
  n.send_new_notification(service & " failed", "", "",
      urgency = NotificationUrgency.Critical, timeout = 5000)
  n.uninit()


statusJson[service] = %*{
  "time": getTime().format("ddd MM-dd HH:mm"),
  "status": exitStatus,
  "result": result,
}


case service:
  of "backup":
    var details = readFile(expandTilde("~/.local/state/backup-status.json"))
    var detailsJson = parseJson(details)
    statusJson[service]["details"] = detailsJson


writeFile(statusFile, statusJson.pretty())

var allSuccessful = true
for key, value in statusJson.pairs:
  if value["status"].getStr != "0":
    allSuccessful = false
    break

# update the icon.json file based on the status of all services
let iconJson = %*{
  "icon": "net_bridge",
  "state": if allSuccessful: "Good" else: "Critical"
}
writeFile(iconFile, $iconJson)
