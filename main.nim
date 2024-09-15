import strformat, os

{.passL: "-Wl,-rpath,@executable_path/shared".}
{.passL: "-L./shared/".} 
{.passL: "-lSDL3".}
{.passC: "-I./include/".}

type 
  SDL_bool = distinct cint
  SDL_InitFlags = distinct cuint
  SDL_Window = pointer
  SDL_MetalView = pointer
  SDL_EventType = cuint
  SDL_Event = object
    `type`: SDL_EventType
const
  SDL_FALSE* = SDL_bool(0)
  SDL_TRUE* = SDL_bool(1)

  SDL_INIT_TIMER* = SDL_InitFlags(0x00000001'u32)
  SDL_INIT_AUDIO* = SDL_InitFlags(0x00000010'u32)
  SDL_INIT_VIDEO* = SDL_InitFlags(0x00000020'u32)

proc `==`(x, y: SDL_bool): bool =
  cuint(x) == cuint(y)

proc SDL_Init(flags: SDL_InitFlags): SDL_bool {.importc.}
proc SDL_Quit(): void {.importc.}
proc SDL_CreateWindow(title: cstring, w: cint, h: cint, flags: cuint): SDL_Window {.importc.}
proc SDL_DestroyWindow(window: SDL_Window): void {.importc.}
proc SDL_ShowWindow(window: SDL_Window): SDL_bool {.importc.}
proc SDL_PollEvent(event: ptr[SDL_Event]): SDL_bool {.importc.}
proc SDL_GetError(): cstring {.importc.}


proc main() =
  if SDL_Init(SDL_INIT_VIDEO) == SDL_FALSE:
    raise Exception.newException("Init error")
  defer: SDL_Quit()

  let window = SDL_CreateWindow("Cool!", 600, 300, 0)
  defer: SDL_DestroyWindow(window)

  discard window.SDL_ShowWindow()

  var isRunning = true

  while isRunning:
    echo "loop"
    # var event: SDL_Event
    # while SDL_PollEvent(event.addr) == SDL_TRUE:
    #   echo "polling"
    #   if event.`type` == 0x100:
    #     isRunning = false
    #     break
    sleep(200)



when isMainModule:
  main()



# SDL3 Can't call the nim functions directly so a bit of glue code is required
# {.emit: """
# SDL_AppResult SDL_AppInit(void **appstate, int argc, char *argv[]) { return AppInit(appstate, argc, argv); }
# SDL_AppResult SDL_AppEvent(void *appstate, SDL_Event *event) { return AppEvent(appstate, event); }
# SDL_AppResult SDL_AppIterate(void *appstate) { return AppIterate(appstate); }
# void SDL_AppQuit(void *appstate) { return AppQuit(appstate); }
# """.}
