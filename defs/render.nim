import video, pixels

type SDL_TextureAccess = enum
  SDL_TEXTUREACCESS_STATIC,
  SDL_TEXTUREACCESS_STREAMING,
  SDL_TEXTUREACCESS_TARGET

type SDL_Renderer* = ptr object
type SDL_Texture* = ptr object

proc SDL_CreateWindowAndRenderer*(title: cstring, width: cint, height: cint, windowFlags: SDL_WindowFlags, window: ptr ptr SDL_Window, renderer: ptr ptr SDL_Renderer): bool {.importc.}

proc SDL_SetRenderVSync*(renderer: ptr SDL_Renderer, vsync: cint): bool {.importc.};

proc SDL_SetRenderDrawColor*(renderer: ptr SDL_Renderer, r,g,b,a: uint8): bool {.importc.};

proc SDL_RenderClear*(renderer: ptr SDL_Renderer): bool {.importc.};

proc SDL_RenderPresent*(renderer: ptr SDL_Renderer): bool {.importc.};

proc SDL_RenderLine*(renderer: ptr SDL_Renderer, x1, y1, x2, y2: cfloat): bool {.importc.}

proc SDL_CreateTexture*(renderer: ptr SDL_Renderer, format: SDL_PixelFormat, access: SDL_TextureAccess, w: cint, h: cint): ptr SDL_Texture {.importc.}
