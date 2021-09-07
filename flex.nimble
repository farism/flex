# Package

version       = "0.1.0"
author        = "Faris Mustafa"
description   = "Bindings to Xamarin/flex"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.4.8"
requires "sdl2 >= 2.0.1"

task docs, "Generate API documents":
  exec "nim doc --out:index.html --hints:off src/flex.nim"

task sdl, "sdl example":
  exec "nim c -f examples/sdl && examples/sdl"