import strformat, defs/templates, defs/events, defs/init, defs/video, defs/render

defineSharedLibraryPragmas()

type AppState = ref object
  color: uint8


var window: ptr SDL_Window = nil
var renderer: ptr SDL_Renderer = nil
var red: uint8 = 0
var fadeDir = 1

proc AppInit*(appstate: ptr AppState, argc: cint, argv: UncheckedArray[cstring]): SDL_AppResult {.exportc, cdecl, dynlib.} =
  echo "Init"
  appstate[] = new AppState
  appstate[].color = 255

  if not SDL_Init(SDL_INIT_VIDEO):
    return SDL_APP_FAILURE
  
  if not SDL_CreateWindowAndRenderer("testing", 640, 480, SDL_WINDOW_RESIZABLE, addr window, addr renderer):
    return SDL_APP_FAILURE

  discard renderer.SDL_SetRenderVSync(1)

  return SDL_APP_CONTINUE

proc AppIterate*(appstate: AppState): SDL_AppResult {.exportc, cdecl, dynlib.} =
  discard renderer.SDL_SetRenderDrawColor(red, 0, 0, 255)
  discard renderer.SDL_RenderClear()
  discard renderer.SDL_RenderPresent()
  if fadeDir > 0:
    if red == 255:
      fadeDir = -1
    else:
      red += 1
  else:
    if red == 0:
      fadeDir = 1
    else:
      red -= 1

  result = SDL_APP_CONTINUE

proc AppEvent*(appstate: AppState, event: ptr SDL_Event): SDL_AppResult {.exportc, cdecl, dynlib.} =
  case event.`type`:
  of SDL_EVENT_QUIT:
    result = SDL_APP_SUCCESS
  else:
    result = SDL_APP_CONTINUE

proc AppQuit*(appstate: AppState) {.exportc, cdecl, dynlib.} =
  echo "Quit"

defineSDLCallbacks("AppInit", "AppEvent", "AppIterate", "AppQuit")
