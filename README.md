# Introduction

This repository contains Nim bindings for the [Xamarin/Flex](https://github.com/xamarin/flex) C library.

The API matches the Flexbox CSS API, and is meant to serve as the base building blocks for more complex widgets.

# Installation

```sh
$ nimble install https://github.com/farism/flex.git
```

# Building

The underlying C library is statically linked into the package, providing easy portability.

# Examples

Please see the [SDL2 example]() for a flexbox layout demo. You can resize the window to see real time layouts.