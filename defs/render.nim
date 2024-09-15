import video

type SDL_Renderer* = ptr object

proc SDL_CreateWindowAndRenderer*(title: cstring, width: cint, height: cint, windowFlags: SDL_WindowFlags, window: ptr ptr SDL_Window, renderer: ptr ptr SDL_Renderer): bool {.importc.}

proc SDL_SetRenderVSync*(renderer: ptr SDL_Renderer, vsync: cint): bool {.importc.};

proc SDL_SetRenderDrawColor*(renderer: ptr SDL_Renderer, r,g,b,a: uint8): bool {.importc.};

proc SDL_RenderClear*(renderer: ptr SDL_Renderer): bool {.importc.};

proc SDL_RenderPresent*(renderer: ptr SDL_Renderer): bool {.importc.};
