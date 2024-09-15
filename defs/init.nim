type SDL_InitFlags = distinct cuint

const
  SDL_INIT_TIMER* = SDL_InitFlags(0x00000001'u32)
  SDL_INIT_AUDIO* = SDL_InitFlags(0x00000010'u32)
  SDL_INIT_VIDEO* = SDL_InitFlags(0x00000020'u32)
  SDL_INIT_JOYSTICK* = SDL_InitFlags(0x00000200'u32)
  SDL_INIT_HAPTIC* = SDL_InitFlags(0x00001000'u32)
  SDL_INIT_GAMEPAD* =  SDL_InitFlags(0x00002000'u32)
  SDL_INIT_EVENTS* = SDL_InitFlags(0x00004000'u32)
  SDL_INIT_SENSOR* = SDL_InitFlags(0x00008000'u32)
  SDL_INIT_CAMERA* = SDL_InitFlags(0x00010000'u32)

type SDL_AppResult* = enum
  SDL_APP_CONTINUE
  SDL_APP_SUCCESS
  SDL_APP_FAILURE

proc SDL_Init*(flags: SDL_InitFlags): bool {.importc.}
proc SDL_InitSubSystem*(flags: SDL_InitFlags): bool {.importc.}
proc SDL_Quit*(): void {.importc.}
proc SDL_QuitSubSystem*(): void {.importc.}
proc SDL_GetAppMetadataProperty*(name: cstring): cstring {.importc.}
proc SDL_SetAppMetadata*(appname: cstring, appversion: cstring, appidentifier: cstring): bool {.importc.}
proc SDL_SetAppMetadataProperty*(name: cstring, value: cstring): bool {.importc.}
proc SDL_WasInit*(flags: SDL_InitFlags): SDL_InitFlags {.importc.}

