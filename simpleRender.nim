import defs/templates, defs/events, defs/init, defs/video, defs/render

defineSharedLibraryPragmas()

type AppState = ref object
  red: uint8
  fadeDir: bool # true is up, false is down
  window: ptr SDL_Window
  renderer: ptr SDL_Renderer
  height: cint
  width: cint

proc AppInit*(app: ptr AppState, argc: cint, argv: UncheckedArray[cstring]): SDL_AppResult {.exportc, cdecl, dynlib.} =
  app[] = new AppState
  app.red = 0
  app.fadeDir = true
  app.window = nil
  app.renderer = nil
  app.height = 480
  app.width = 640

  if not SDL_Init(SDL_INIT_VIDEO):
    return SDL_APP_FAILURE
  
  if not SDL_CreateWindowAndRenderer("testing", app.width, app.height, SDL_WINDOW_RESIZABLE, addr app.window, addr app.renderer):
    return SDL_APP_FAILURE

  discard app.renderer.SDL_SetRenderVSync(1)

  return SDL_APP_CONTINUE

proc AppIterate*(app: AppState): SDL_AppResult {.exportc, cdecl, dynlib.} =
  discard app.renderer.SDL_SetRenderDrawColor(app.red, 0, 0, 255)
  discard app.renderer.SDL_RenderClear()

  discard app.renderer.SDL_SetRenderDrawColor(255, 255, 255, 255)

  discard app.renderer.SDL_RenderLine(0, cfloat(app.red) / 255 * app.height.cfloat, cfloat(app.red) / 255 * app.width.cfloat, 80)

  discard app.renderer.SDL_RenderPresent()
  if app.fadeDir:
    if app.red == 255:
      app.fadeDir = false
    else:
      app.red += 1
  else:
    if app.red == 0:
      app.fadeDir = true
    else:
      app.red -= 1

  result = SDL_APP_CONTINUE

proc AppEvent*(app: AppState, event: ptr SDL_Event): SDL_AppResult {.exportc, cdecl, dynlib.} =
  case event.`type`:
  of SDL_EVENT_QUIT:
    result = SDL_APP_SUCCESS
  else:
    result = SDL_APP_CONTINUE

proc AppQuit*(app: AppState) {.exportc, cdecl, dynlib.} =
  discard

defineSDLCallbacks("AppInit", "AppEvent", "AppIterate", "AppQuit")
