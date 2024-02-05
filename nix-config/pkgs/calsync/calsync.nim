import os
import osproc
import std/net
import std/parseopt
import system

proc main() =

  var p = initOptParser()
  p.next()
  let noninteractive = p.key == "noninteractive"


  const opts = {poUsePath, poStdErrToStdOut}
  let davmailProc = startProcess("davmail", options = opts)

  let socket = newSocket()
  while true:
    try:
      socket.connect("localhost", Port(1080))
      break
    except OSError:
      sleep(500)
      continue

  let exitCode = execCmd("vdirsyncer sync")
  if exitCode != 0:
    let exitCode = execCmd("vdirsyncer discover calendar_wrk_dw")
    if exitCode != 0:
      terminate(davmailProc)
      quit(QuitFailure)

  if not noninteractive:
    discard execCmd("khal list")

  terminate(davmailProc)
  discard waitForExit(davmailProc, 1000)
  if running(davmailProc):
    echo "failed to terminate davmail proc"
    quit(QuitFailure)


when isMainModule:
  main()
