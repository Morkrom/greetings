module AppleaseInfiniteGallery exposing ()

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Html.Lazy as Lazy
import Json.Decode as Decode

type State
  = State Index TransitionState

-- only X axis this is merely a gallery.
type Drag
  = Drag Position Position

type TransitionState
  =
  | Resting
  | Dragging Drag
  | InTransition TransitionType

type TransitionType
  = ToPrevious
  | ToCurrent
  | ToNext

type alias Index = Int

type alias Position = Int


type Msg
  = DragStart Position
  | DragAt Position
  | DragEnd


init : State
init =
  State 0 Resting

type Config
  = Config {
  id : String
  , width : Length,
  , height : Length
}

---> Config
config : { id : String, width : Length, height : Length} -> Config
config {id, width, height} =
  Config {
    id = id
    , width = width
    , height = height
  }

update : Msg -> State -> State
update msg ((State index_ drag transitionState) as state =
  case msg of
    DragStart position ->
      State index_ (Dragging (Drag position position))
    DragAt position ->
      let dragP (Drag start _) =
       start
--      let updatePosition current_ (Drag start _) =
--        Drag start current_
      in
      State index_ (Dragging (Drag dragP position)--(updatePosition position))
    DragEnd ->
      case drag of
        Drag beginning current_ ->
          if beginning - current_ > 100 then
            --next state
            State index+1 (InTransition ToNext)
          else if beginning - current_ < -100 then
            --previous state
            State index-1 (InTransition ToPrevious)
          else
            State index_ (InTransition ToCurrent)

--getName : UserName -> String
--getName userName =
--    case userName of
--        UserName s ->
--            s
--
--
{- ..Style.. -}
type Length
    = Px Float
    | Pct Float
    | Rem Float
    | Em Float
    | Vh Float
    | Vw Float
    | Unset
