import sdl2, os
import ../src/flex

discard sdl2.init(INIT_EVERYTHING)

var
  window: WindowPtr
  render: RendererPtr

window = createWindow("SDL Skeleton", 100, 100, 640, 480, SDL_WINDOW_SHOWN or SDL_WINDOW_RESIZABLE)
render = createRenderer(window, -1, Renderer_Accelerated or
    Renderer_PresentVsync or Renderer_TargetTexture)

var
  evt = sdl2.defaultEvent
  userdata = sdl2.defaultEvent
  runGame = true
  root = newFlexItem(640, 480, direction = Column, justifyContent = SpaceBetween) # black
  topRow = newFlexItem(0, 300, direction = Row, paddingTop = 20, paddingBottom = 20) # blue
  bottomRow = newFlexItem(0, 100, direction = Row) # teal
  leftChild = newFlexItem(0, 0, grow = 1)          # red
  rightChild = newFlexItem(0, 0, grow = 1)         # green

topRow.add(leftChild)
topRow.add(rightChild)
root.add(topRow)
root.add(bottomRow)

let drawables = @[
  (root, 0, 0, 0),
  (topRow, 0, 0, 255),
  (bottomRow, 0, 255, 255),
  (leftChild, 255, 0, 0),
  (rightChild, 0, 255, 0)
]

proc draw() =
  render.setDrawColor(0, 0, 0, 255)
  render.clear()

  root.layout()

  for d in drawables:
    var rect = rect(d[0].x.cint, d[0].y.cint, d[0].w.cint, d[0].h.cint)
    render.setDrawColor(d[1].uint8, d[2].uint8, d[3].uint8, 255)
    render.fillRect(rect)

  render.present()

proc filter(userdata: pointer, evt: ptr Event): Bool32 {.cdecl.} =
  case evt.kind
  of WindowEvent:
    case evt[].window.event
      of WindowEvent_SizeChanged:
        root.width = window.getSize().x.float32
        root.height = window.getSize().y.float32
        draw()
      else: discard
  else: discard

  True32

sdl2.setEventFilter(filter, addr(userdata))

while runGame:
  while pollEvent(evt):
    case evt.kind
      of QuitEvent:
        runGame = false
        break
      else: discard

  draw()
  sleep(15)

destroy render
destroy window
