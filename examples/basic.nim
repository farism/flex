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
  runGame = true
  root = newFlexItem(640, 480, direction = Column, justifyContent = SpaceBetween) # black
  row1 = newFlexItem(0, 300, direction = Row, paddingTop = 20, paddingBottom = 20) # blue
  row2 = newFlexItem(0, 100, direction = Row) # teal
  child1 = newFlexItem(20, 0, grow = 1)       # red
  child2 = newFlexItem(0, 0, grow = 1)        # green

row1.add(child1)
row1.add(child2)
root.add(row1)
root.add(row2)

while runGame:
  while pollEvent(evt):
    case evt.kind
      of QuitEvent:
        runGame = false
        break
      of WindowEvent:
        case evt.window.event
          of WindowEvent_Resized:
            root.width = window.getSize().x.float32
            root.height = window.getSize().y.float32
          else:
            discard
      else:
        discard

  root.layout()

  render.setDrawColor(0, 0, 0, 255)
  render.clear()

  var rootrect = rect(root.x.cint, root.y.cint, root.w.cint, root.h.cint)
  render.setDrawColor(255, 50, 50, 255)
  render.fillRect(rootrect)

  var row1rect = rect(row1.x.cint, row1.y.cint, row1.w.cint, row1.h.cint)
  render.setDrawColor(0, 0, 255, 255)
  render.fillRect(row1rect)

  var row2rect = rect(row2.x.cint, row2.y.cint, row2.w.cint, row2.h.cint)
  render.setDrawColor(0, 255, 255, 255)
  render.fillRect(row2rect)

  var child1rect = rect(child1.x.cint, child1.y.cint, child1.w.cint, child1.h.cint)
  render.setDrawColor(255, 0, 0, 255)
  render.fillRect(child1rect)

  var child2rect = rect(child2.x.cint, child2.y.cint, child2.w.cint, child2.h.cint)
  render.setDrawColor(0, 255, 0, 255)
  render.fillRect(child2rect)

  render.present()

  sleep(15)

destroy render
destroy window
