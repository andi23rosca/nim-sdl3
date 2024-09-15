# Use the callbacks method so that it's compatible with more platforms
# https://wiki.libsdl.org/SDL3/README/main-functions#main-callbacks-in-sdl3
template defineSDLCallbacks*(AppInitProc, AppEventProc, AppIterateProc, AppQuitProc: untyped) =
  {.emit: """
    #define SDL_MAIN_USE_CALLBACKS 1
    #include <SDL3/SDL_main.h>
    
    SDL_AppResult SDL_AppInit(void **appstate, int argc, char *argv[]) { return """ & AppInitProc & """(appstate, argc, argv); }
    SDL_AppResult SDL_AppEvent(void *appstate, SDL_Event *event) { return """ & AppEventProc & """(appstate, event); }
    SDL_AppResult SDL_AppIterate(void *appstate) { return """ & AppIterateProc & """(appstate); }
    void SDL_AppQuit(void *appstate) { return """ & AppQuitProc & """(appstate); }
    """
  .}

template defineSharedLibraryPragmas*() =
  # Make sure to have a shared library file under ./shared
  # On MacOS you need a `libSDL3.dylib` and to also symlink that to `libSDL3.0.dylib` with `lb -s libSDL3.dylib libSDL3.0.dylib`
  {.passL: "-Wl,-rpath,@executable_path/shared".}
  {.passL: "-L./shared/".} 
  {.passL: "-lSDL3".}
  # Copy paste the header files from the sdl repo /include into ./include/SDL3
  {.passC: "-I./include/".}