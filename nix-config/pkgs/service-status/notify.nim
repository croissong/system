const libnotify_fn* = "libnotify.so.4"

type Notify = pointer

type NotificationUrgency* = enum
  Low, Normal, Critical

proc notify_init*(name: cstring): bool
  {.importc: "notify_init", dynlib: libnotify_fn.}

proc notify_uninit*(): void {.importc: "notify_uninit",
  dynlib: libnotify_fn.}

proc notify_is_initted(): bool
  {.importc: "notify_is_initted", dynlib: libnotify_fn.}


proc notify_set_app_name(name: cstring): void
  {.importc: "notify_set_app_name", dynlib: libnotify_fn.}

proc notify_notification_new(a, b, c: cstring): Notify
  {.importc: "notify_notification_new", dynlib: libnotify_fn.}

proc notify_notification_show(notification: Notify, gerror: cint): bool
  {.importc: "notify_notification_show", dynlib: libnotify_fn.}

proc notify_notification_set_timeout(notification: Notify, timeout: cint): void
  {.importc: "notify_notification_set_timeout", dynlib: libnotify_fn.}

proc notify_notification_set_urgency(notification: Notify,
    urgency: NotificationUrgency): void
  {.importc: "notify_notification_set_urgency", dynlib: libnotify_fn.}



type NotifyClient* = ref object of RootObj


proc newNotifyClient*(app_name: string): NotifyClient =
  ## Initialize notification client
  if notify_is_initted() == false:
    doAssert notify_init(app_name)
    doAssert notify_is_initted()
  new(NotifyClient)


proc send_new_notification*(self: NotifyClient, summary, body,
    icon_fname: string, timeout = 0, urgency = NotificationUrgency.Normal) =
  ## Show a notification. Optionally specify a timeout in milliseconds and an
  ## urgency as a NotificationUrgency.Low / Normal / Critical
  let n = notify_notification_new(summary.cstring, body.cstring,
      icon_fname.cstring)

  notify_notification_set_urgency(n, urgency)

  if timeout != 0:
    notify_notification_set_timeout(n, timeout.cint)

  let error: cint = 0
  doAssert notify_notification_show(n, error)
  if error != 0:
    raise newException(Exception, "Unhandled exception")

proc uninit*(self: NotifyClient) =
  ## Uninitialize the library
  notify_uninit()
