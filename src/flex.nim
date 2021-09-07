{.compile: "flex.c".}

type
  FlexAlign* {.size: sizeof(cint).} = enum
    Auto = 0
    Stretch
    Center
    Start
    End
    SpaceBetween
    SpaceAround
    SpaceEvenly

  FlexPosition* {.size: sizeof(cint).} = enum
    Relative = 0
    Absolute

  FlexDirection* {.size: sizeof(cint).} = enum
    Row = 0
    RowReverse
    Column
    ColumnReverse

  FlexWrap* {.size: sizeof(cint).} = enum
    NoWrap = 0
    Wrap
    WrapReverse

  FlexItemObj* = object
    width*: float32
    height*: float32

    left*: float32
    right*: float32
    top*: float32
    bottom*: float32

    paddingLeft*: float32
    paddingRight*: float32
    paddingTop*: float32
    paddingBottom*: float32

    marginLeft*: float32
    marginRight*: float32
    marginTop*: float32
    marginBottom*: float32

    justifyContent*: FlexAlign
    alignContent*: FlexAlign
    alignItems*: FlexAlign
    alignSelf*: FlexAlign

    position*: FlexPosition
    direction*: FlexDirection
    wrap*: FlexWrap

    grow*: float32
    shrink*: float32
    order*: int
    basis*: float32

    frame: array[4, float32]
    parent: FlexItem

  FlexItem* = ptr FlexItemObj

proc flex_item_new(): FlexItem {.importc: "flex_item_new".}

proc flex_item_free(item: FlexItem) {.importc: "flex_item_free", .}

proc flex_item_add(item: FlexItem, child: FlexItem) {.
    importc: "flex_item_add".}

proc flex_item_insert(item: FlexItem, index: cuint,
    child: FlexItem) {.importc: "flex_item_insert".}

proc flex_item_delete(item: FlexItem, index: cuint): FlexItem {.
    importc: "flex_item_delete".}

proc flex_item_count(item: FlexItem): cuint {.importc: "flex_item_count".}

proc flex_item_child(item: FlexItem, index: cuint): FlexItem {.
    importc: "flex_item_child".}

proc flex_item_root(item: FlexItem): FlexItem {.
    importc: "flex_item_root".}

proc flex_layout(item: FlexItem) {.importc: "flex_layout".}

proc flex_item_get_frame_x(item: FlexItem): cfloat {.
    importc: "flex_item_get_frame_x".}

proc flex_item_get_frame_y(item: FlexItem): cfloat {.
    importc: "flex_item_get_frame_y".}

proc flex_item_get_frame_width(item: FlexItem): cfloat {.
    importc: "flex_item_get_frame_width".}

proc flex_item_get_frame_height(item: FlexItem): cfloat {.
    importc: "flex_item_get_frame_height".}

proc newFlexItem*(
  width,
  height,
  left,
  right,
  top,
  bottom,
  paddingLeft,
  paddingRight,
  paddingTop,
  paddingBottom,
  marginLeft,
  marginRight,
  marginTop,
  marginBottom,
  grow: float32 = 0.0,
  shrink: float32 = 1,
  order: cint = 0,
  justifyContent: FlexAlign = Start,
  alignContent: FlexAlign = Stretch,
  alignItems: FlexAlign = Stretch,
  alignSelf: FlexAlign = Auto,
  position: FlexPosition = Relative,
  direction: FlexDirection = Row,
  wrap: FlexWrap = NoWrap,
): FlexItem =
  result = flex_item_new()
  result.width = width
  result.height = height
  result.left = left
  result.right = right
  result.top = top
  result.bottom = bottom
  result.paddingLeft = paddingLeft
  result.paddingRight = paddingRight
  result.paddingTop = paddingTop
  result.paddingBottom = paddingBottom
  result.marginLeft = marginLeft
  result.marginRight = marginRight
  result.marginTop = marginTop
  result.marginBottom = marginBottom
  result.grow = grow
  result.shrink = shrink
  # result.order = order.cint
  result.justifyContent = justifyContent
  result.alignContent = alignContent
  result.alignItems = alignItems
  result.alignSelf = alignSelf
  result.position = position
  result.direction = direction
  result.wrap = wrap

proc add*(item: FlexItem, child: FlexItem): FlexItem {.discardable.} =
  ## Adds a child to a FlexItem. Returns the parent item for convenience chaining.
  item.flex_item_add(child)
  result = item

proc insert*(item: FlexItem, child: FlexItem, index: int): FlexItem {.discardable.} =
  ## Inserts a child at `index`. Returns the parent item as for convenience chaining.
  item.flex_item_insert(index.cuint, child)
  result = item

proc delete*(item: FlexItem, index: int): FlexItem =
  ## Deletes a child at `index`, returning the deleted item.
  item.flex_item_delete(index.cuint)

proc child*(item: FlexItem, index: int): FlexItem =
  ## Retrieves child at `index`.
  item.flex_item_child(index.cuint)

proc len*(item: FlexItem, index: int): int =
  ## Returns the number of children added to `item`.
  item.flex_item_count().int

proc root*(item: FlexItem): FlexItem =
  ## Starting at `item`, traverses up to find the root FlexItem.
  item.flex_item_root()

proc layout*(item: FlexItem) {.discardable.} =
  ## Starting at root node `item`, recursively calculates the layout for all children.
  item.flex_layout()

proc x*(item: FlexItem): float32 =
  ## Get the item's frame `x` position. This should only be used after calling `layout` on the root FlexItem.
  item.flex_item_get_frame_x().float32

proc y*(item: FlexItem): float32 =
  ## Get the item's frame `y` position. This should only be used after calling `layout` on the root FlexItem.
  item.flex_item_get_frame_y().float32

proc w*(item: FlexItem): float32 =
  ## Get the item's frame `width`. This should only be used after calling `layout` on the root FlexItem.
  item.flex_item_get_frame_width().float32

proc h*(item: FlexItem): float32 =
  ## Get the item's `height`. This should only be used after calling `layout` on the root FlexItem.
  item.flex_item_get_frame_height().float32
