import strformat, defs/templates, defs/events

defineSharedLibraryPragmas()

type SDL_AppResult* = enum
  SDL_APP_CONTINUE
  SDL_APP_SUCCESS
  SDL_APP_FAILURE

type AppState = ref object
  color: uint8

proc AppInit*(appstate: ptr AppState, argc: cint, argv: UncheckedArray[cstring]): SDL_AppResult {.exportc, cdecl, dynlib.} =
  echo "Init"
  appstate[] = new AppState
  appstate[].color = 255
  result = SDL_APP_CONTINUE

proc AppIterate*(appstate: AppState): SDL_AppResult {.exportc, cdecl, dynlib.} =
  echo fmt"Iterate"
  result = SDL_APP_CONTINUE

proc AppEvent*(appstate: AppState, event: ptr SDL_CommonEvent): SDL_AppResult {.exportc, cdecl, dynlib.} =
  case event.`type`:
  of SDL_EVENT_QUIT:
    echo "Quit event"
    result = SDL_APP_FAILURE
  else:
    echo "Other event"
    result = SDL_APP_CONTINUE

proc AppQuit*(appstate: AppState) {.exportc, cdecl, dynlib.} =
  echo "Quit"

defineSDLCallbacks("AppInit", "AppEvent", "AppIterate", "AppQuit")
