# Package

version       = "0.1.0"
author        = "Faris Mustafa"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.4.8"
requires "sdl2 >= 2.0.1"

task basic, "basic example":
  exec "nim c -f examples/basic && examples/basic"