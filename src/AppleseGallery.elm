module AppleseGallery exposing (State, Index, Msg, Config, Length, pct, px, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Html.Lazy as Lazy
import Json.Decode as Decode

type alias Slides =
    List ( Int, Html Msg )

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
  , slides : Slides
}

---> Config
config : { id : String, width : Length, height : Length, slides : Slides} -> Config
config {id, width, height, slides} =
  Config {
    id = id
    , width = width
    , height = height
    , slides = slides
  }


type Length
    = Px Float
    | Pct Float
    | Rem Float
    | Em Float
    | Vh Float
    | Vw Float
    | Unset

className = "AppleseGallery"

update : Msg -> State -> State
update msg ((State index_ drag transitionState) as state) =
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

view : Config -> State -> Html Msg
view config ((State index transitionState) as state) =
  div [ class className,
        id configR.id,
        style "width" config.width,
        style "height" config.height]
        [
          lStyleSheet config transitionState
        , div [ class <| className ++ "__Wrapper"]
            [
              div ([ class <| className ++ "__Slides",
              classList [(className ++ "__Slides--dragging",
                        , isDragging transitionState)
                        ]
              ]
                ++ slides True (isDragging transitionState)) -- events here
                ++ documentDragStyle transitionState
            ) <| slidesForCurrentIndex index config.slides

isDragging : TransitionState -> Bool
isDragging transition =
  case transition of
    Dragging _ ->
      True
    _ ->
      False


documentDragStyle : TransitionState -> (List Html.Attributes)
documentDragStyle transition =
  [
    case t of
      Resting ->
        []
      Dragging startPoints currentPoints ->
        [
        --  style "transform" <| "translateX(" ++ (String.fromInt points) ++ "px" ++  ", 0px)"
        --             [ style "transform" <|
         style "transform" "translateX("(String.fromInt (currentPoints - startPoints)) ++ "px)"
        ]
      InTransition transition ->
        [
          -- "translateX("(String.fromInt (currentPoints - startPoints)) ++ "px)"
        ]
  ]



{-
++ dragOffset dragState currentSlide amountOfSlides
dragOffset : DragState -> CurrentSlide -> Int -> List (Attribute Msg)
dragOffset dragState currentSlide amountOfSlides =
    let
        indexBasedOffset =
            toFloat (-100 * (currentSlide + 1))
                / toFloat amountOfSlides
                |> String.fromFloat
                |> (\x -> x ++ "%")
    in
    case dragState of
        Dragging (PosX startX) (PosX currentX) ->
            [ style "transform" <|
                "translateX( calc("
                    ++ indexBasedOffset
                    ++ " + "
                    ++ String.fromInt (currentX - startX)
                    ++ "px) )"
            ]

        NotDragging ->
            [ style "transform" <| "translateX(" ++ indexBasedOffset ++ ")" ]
-}



--getName : UserName -> String
--getName userName =
--    case userName of
--        UserName s ->
--            s
--
--
{- ..Style.. -}

htmlMatchesIndex : Int -> (Int, Html Msg) -> Bool
htmlMatchesIndex index (elmentIndex _) =
  index == elmentIndex

htmlForIndex : Int -> Slides -> Html Msg
htmlForIndex index insideOf =
  div [
    classList [
      (className ++ "__Slides_Slide")
      ("active", True)
    ]
  ] [
    List.filter (a\ -> (htmlMatchesIndex index a)) insideOf
  ]

slidesForCurrentIndex: Index -> Slides -> List (Html Msg)
slidesForCurrentIndex index all =
  [
   htmlForIndex (index+2 modBy (List.length all))
  , htmlForIndex (index+1 modBy (List.length all))
  , htmlForIndex (index modBy (List.length all))
  , htmlForIndex (index-1 modBy (List.length all))
  , htmlForIndex (index-2 modBy (List.length all))
 ]


lStyleSheet : Config -> TransitionState -> Html Msg
lStyleSheet config transition =
lazy2 (\c, t -> styleSheet c t) config transition

styleSheet : Config -> TransitionState -> Html msg
styleSheet config transition =
  node "style"
    []
    [
     text <|
       """
       #"""
         ++ className
          ++ """__Wrapper {
            position: relative;
            width: 100%;
            height: 100%";
          }

      #"""
        ++ className
        ++ """__Slides {
          position: absolute;
          top: 0;
          width: 500%;
          height: 100%;
          display: flex;
          left: 0;
          padding: 0;
          margin: 0;
          transition: transform 300 ms ease"
          cursor: grab;
        }
      #"""
        ++ className
        ++ """__Slides-dragging {
          transition: none;
        }
      #"""
        className ++ """__Slides_Slide {}
          max-width: 100%;
          max-height: 100%;
          overflow: hidden;
          position: relative;
          user-drag: none;
          user-select: none;
          -webkit-user-select: none;
          -moz-user-select: none;
          -ms-user-select: none;
        }
       """
    ]


events : Bool -> DragState -> List (Attribute Msg)
events enableDrag dragState =
    if not enableDrag then
        []

    else
        [ on "mousedown" (Decode.map DragStart decodePosX)
        , on "touchstart" (Decode.map DragStart decodePosX)
        , on "transitionend" (Decode.succeed Resting)
        ]
            ++ (if isDragging dragState then
                    [ preventDefaultOn "mousemove"
                        (Decode.map (\posX -> ( DragAt posX, True )) decodePosX)
                    , preventDefaultOn "touchmove"
                        (Decode.map (\posX -> ( DragAt posX, True )) decodePosX)
                    , on "mouseup" (Decode.succeed DragEnd)
                    , on "mouseleave" (Decode.succeed DragEnd)
                    , on "touchend" (Decode.succeed DragEnd)
                    , on "touchcancel" (Decode.succeed DragEnd)
                    ]

                else
                    []
               )
