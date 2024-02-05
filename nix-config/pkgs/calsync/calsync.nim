import os
import osproc
import std/net
import std/parseopt
import system

proc terminateProc(p: Process) =
  terminate(p)
  discard waitForExit(p, 1000)
  if running(p):
    echo "failed to terminate davmail proc"
    quit(QuitFailure)


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
      sleep(100)
      continue

  let exitCode = execCmd("vdirsyncer sync")
  if exitCode != 0:
    let exitCode = execCmd("vdirsyncer discover calendar_wrk_dw")
    if exitCode != 0:
      terminateProc(davmailProc)
      quit(QuitFailure)

  if not noninteractive:
    discard execCmd("khal list")

  terminateProc(davmailProc)

when isMainModule:
  main()
