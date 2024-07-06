import os, json, strformat, times

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


# update the status from systemd-provided env vars
statusJson[service] = %*{
  "time": getTime().format("ddd MM-dd HH:mm"),
  "status": getEnv("EXIT_STATUS"),
  "result": getEnv("SERVICE_RESULT"),
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
