module AppleseGallery exposing
    ( Config
    , Index
    , Length
    , Msg
    , Slides
    , State
    , TransitionState
    , config
    , init
    , pct
    , px
    , update
    , view
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy2)
import Json.Decode as Decode


type alias Slides =
    List ( Int, Html Msg )


type State
    = State Index TransitionState



-- only X axis this is merely a gallery.


type Drag
    = Drag Position Position


type TransitionState
    = Resting
    | Dragging Drag
    | InTransition TransitionType


type TransitionType
    = ToPrevious
    | ToCurrent
    | ToNext


type alias Index =
    Int


type Position
    = Position Int


type Msg
    = DragStart Position
    | DragAt Position
    | DragEnd
    | TransitionEnd


init : State
init =
    State 0 Resting


type Config
    = Config
        { id : String
        , width : Length
        , height : Length
        , slides : Slides
        }



---> Config


config :
    { id : String
    , width : Length
    , height : Length
    , slides : Slides
    }
    -> Config
config { id, width, height, slides } =
    Config
        { id = id
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


{-| -}
px : Float -> Length
px x =
    Px x


{-| -}
pct : Float -> Length
pct x =
    Pct x


className =
    "AppleseGallery"


dragInitialValue : Drag -> Int
dragInitialValue (Drag initial _) =
    positionValue initial


dragInitialValueP : Drag -> Position
dragInitialValueP (Drag initial _) =
    initial


dragCurrentValue : Drag -> Int
dragCurrentValue (Drag _ current) =
    positionValue current


currentDrag : TransitionState -> Maybe Drag
currentDrag transition =
    case transition of
        Dragging drag ->
            Just drag

        Resting ->
            Nothing

        InTransition _ ->
            Nothing


update : Msg -> State -> ( State, Cmd Msg )
update msg ((State index_ transitionState) as state) =
    case msg of
        DragStart position ->
            ( State index_ (Dragging (Drag position position))
            , Cmd.none
            )

        DragAt position ->
            case currentDrag transitionState of
                Just drag ->
                    ( State index_ (Dragging (Drag (dragInitialValueP drag) position))
                    , Cmd.none
                    )
                        |> Debug.log
                            ("Drag At position: "
                                ++ String.fromInt (positionValue position)
                            )

                Nothing ->
                    ( State index_ (Dragging (Drag position position))
                    , Cmd.none
                    )

        --(updatePosition position))
        DragEnd ->
            case currentDrag transitionState of
                Just drag ->
                    case drag of
                        Drag beginning current_ ->
                            if positionValue beginning - positionValue current_ > 100 then
                                ( State index_ (InTransition ToNext)
                                , Cmd.none
                                )
                                    |> Debug.log ("dragEnd: ToNext" ++ String.fromInt (positionValue beginning) ++ String.fromInt (positionValue current_))

                            else if positionValue beginning - positionValue current_ < -100 then
                                ( State index_ (InTransition ToPrevious)
                                , Cmd.none
                                )
                                    |> Debug.log ("dragEnd: ToPrevious" ++ String.fromInt (positionValue beginning) ++ String.fromInt (positionValue current_))

                            else
                                ( State index_ (InTransition ToCurrent)
                                , Cmd.none
                                )
                                    |> Debug.log ("dragEnd: ToCurrent" ++ String.fromInt (positionValue beginning) ++ String.fromInt (positionValue current_))

                Nothing ->
                    ( State index_ Resting
                    , Cmd.none
                    )

        TransitionEnd ->
            ( State (incOrDec (transitionTypeForState transitionState) index_) Resting
            , Cmd.none
            )


transitionTypeForState : TransitionState -> TransitionType
transitionTypeForState tState =
    case tState of
        InTransition t ->
            t

        Dragging _ ->
            ToCurrent

        Resting ->
            ToCurrent


incOrDec : TransitionType -> Int -> Index
incOrDec transition curIndex =
    case transition of
        ToNext ->
            curIndex + 1

        ToPrevious ->
            curIndex - 1

        ToCurrent ->
            curIndex



--TransitionEnd ->
--    State index_ Resting


lengthToString : Length -> String
lengthToString length =
    case length of
        Px x ->
            String.fromFloat x ++ "px"

        Pct x ->
            String.fromFloat x ++ "%"

        Rem x ->
            String.fromFloat x ++ "rem"

        Em x ->
            String.fromFloat x ++ "em"

        Vh x ->
            String.fromFloat x ++ "vh"

        Vw x ->
            String.fromFloat x ++ "vw"

        Unset ->
            ""


view : Config -> State -> Html Msg
view ((Config configR) as config_) ((State index transitionState) as state) =
    div
        [ class className
        , id configR.id
        , style "width" (lengthToString configR.width)
        , style "height" (lengthToString <| configR.height)
        , style "background" "purple"
        ]
        [ --lStyleSheet configR.id transitionState
          --,
          div
            [ --class <| className ++ "__Wrapper" ]
              --
              --                 position: relative;
              style "width" "100%"
            , style "height" "100%"
            , style "overflow" "hidden"
            , style "background" "black"
            ]
            [ div
                ([ style "position" "relative"
                 , style "top" "0"
                 , style "height" "100%"
                 , style "display" "flex"
                 , style "flex-direction" "row"
                 , style "padding" "0"
                 , style "margin" "0"
                 , style "cursor" "grab"
                 , style "overflow-x" "auto"
                 , style "white-space" "nowrap"
                 , style "width" wrapperWidthString
                 , style "left" wrapperRestingPercentileOffset
                 , style "transition" (transitionText (isNotInTransition transitionState)) -- "transform 1000ms ease"
                 ]
                    ++ events (isNotInTransition transitionState) transitionState
                    -- events here
                    ++ documentDragStyle transitionState
                 {- [ class <| className ++ "__Slides"
                    , classList
                       [ ( className ++ "__Slides--dragging"
                         , isDragging transitionState
                         )
                       ]
                    ]

                 -}
                )
              <|
                slidesForCurrentIndex index configR.slides
            ]
        ]


transitionText : Bool -> String
transitionText trans =
    case trans of
        True ->
            "none"

        False ->
            "transform 1000ms ease"


isNotInTransition : TransitionState -> Bool
isNotInTransition transition =
    case transition of
        InTransition _ ->
            False

        Resting ->
            True

        Dragging _ ->
            True


loggedIndex : Int -> Int
loggedIndex n =
    let
        loggedN =
            Debug.log "loggedIndex" n
    in
    n


isDragging : TransitionState -> Bool
isDragging transition =
    case transition of
        Dragging _ ->
            True

        _ ->
            False


documentDragStyle : TransitionState -> List (Attribute Msg)
documentDragStyle transition =
    case transition of
        Resting ->
            []

        Dragging drag ->
            [ --  style "transform" <| "translateX(" ++ (String.fromInt points) ++ "px" ++  ", 0px)"
              --             [ style "transform" <|
              style "transform" ("translateX(" ++ String.fromInt (dragCurrentValue drag - dragInitialValue drag) ++ "px)")
            ]

        InTransition t ->
            [ -- "translateX("(String.fromInt (currentPoints - startPoints)) ++ "px)"
              style "transform" ("translateX(" ++ loggedStyle (transitionPercentileStr t)) --++ pageItemPercentileOfScreenWidthFStr (50.0 - (toFloat pageItemPercentileOfScreenWidth * 2.5) - 10.0)) --"20%") --++ transitionPercentileStr t ++ ")")
            ]


transitionPercentileStr : TransitionType -> String
transitionPercentileStr transition =
    case transition of
        ToNext ->
            pageItemPercentileOfScreenWidthFStr -20.0
                |> Debug.log "To Next"

        ToPrevious ->
            pageItemPercentileOfScreenWidthFStr 20.0
                --(toFloat pageItemPercentileOfScreenWidth / (toFloat pageItemPercentileOfScreenWidth * toFloat (List.length columns)))
                |> Debug.log "To ToPrevious"

        ToCurrent ->
            "0%"
                |> Debug.log "To Current"


positionValue : Position -> Int
positionValue (Position position) =
    position



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


htmlMatchesIndex : Int -> ( Int, Html Msg ) -> Bool
htmlMatchesIndex index slide =
    index == Tuple.first slide


extractHtmlFromSlide : ( Int, Html Msg ) -> Html Msg
extractHtmlFromSlide slide =
    Tuple.second slide


pageItemPercentileOfScreenWidth : Int
pageItemPercentileOfScreenWidth =
    75


pageItemPercentileOfScreenWidthStr : Int -> String
pageItemPercentileOfScreenWidthStr percentile =
    String.fromInt percentile ++ "%"


pageItemPercentileOfScreenWidthFStr : Float -> String
pageItemPercentileOfScreenWidthFStr percentile =
    String.fromFloat percentile ++ "%"


wrapperWidthString : String
wrapperWidthString =
    pageItemPercentileOfScreenWidthStr (pageItemPercentileOfScreenWidth * List.length columns)


wrapperRestingPercentileOffset : String
wrapperRestingPercentileOffset =
    --"50%"
    pageItemPercentileOfScreenWidthFStr (50.0 - (toFloat pageItemPercentileOfScreenWidth * 2.5))



--pageItemPercentileOfScreenWidthFStr (-2.5 * toFloat pageItemPercentileOfScreenWidth)


htmlForIndex : List ( Int, Html Msg ) -> Int -> Html Msg
htmlForIndex insideOf column =
    div
        [ classList
            [ --( className ++ "__Slides_Slide", True )
              ( "active", True )
            ]
        , style "width" (pageItemPercentileOfScreenWidthStr pageItemPercentileOfScreenWidth)
        , style "max-height" "100%"
        , style "overflow" "auto"
        , style "position" "relative"
        , style "user-drag" "none"
        , style "user-select" "none"
        , style "-webkit-user-select" "none"
        , style "-moz-user-select" "none"
        , style "-ms-user-select" "none"
        , style "display" "inline-block"
        , style "background" "coral"
        , style "border-style" "solid"
        , style "border-width" "1px"
        , style "border-color" "black"
        ]
        (List.map
            extractHtmlFromSlide
            (List.filter
                (htmlMatchesIndex column)
                insideOf
            )
        )


columns =
    [ -2, -1, 0, 1, 2 ]


slidesForCurrentIndex : Index -> List ( Int, Html Msg ) -> List (Html Msg)
slidesForCurrentIndex index all =
    let
        addedd =
            List.map (addeddIndex index) columns
                |> List.map (modIndex (List.length all))
    in
    List.map (htmlForIndex all) addedd



-- List.map (htmlForIndex (modIndex index (List.length all)) all) columns


addeddIndex : Int -> Int -> Int
addeddIndex currentIndex offset =
    currentIndex + offset


modIndex : Int -> Int -> Int
modIndex left right =
    modBy left right



--all
-- List.map (\a -> htmlForIndex ((index + a) modBy (List.length all))) columns
-- [ htmlForIndex ((index + 2) modBy (List.length all))
-- , htmlForIndex ((index + 1) modBy (List.length all))
-- , htmlForIndex (index modBy (List.length all))
-- , htmlForIndex ((index - 1) modBy (List.length all))
-- , htmlForIndex ((index - 2) modBy (List.length all))
-- ]


lStyleSheet : String -> TransitionState -> Html Msg
lStyleSheet configR transition =
    lazy2 (\c t -> styleSheet c t) configR transition


loggedStyle : String -> String
loggedStyle n =
    let
        loggedN =
            Debug.log "loggedStyle: " n
    in
    n



{-
   ++ id
   ++ "."
-}


ssText : String -> String -> String
ssText id class =
    """
            #"""
        ++ id
        ++ "."
        ++ class
        ++ """__Wrapper {
                position: relative;
                width: 100%;
                height: 100%";
                overflow: hidden;
                background: pink;
            }

            #"""
        ++ id
        ++ "."
        ++ class
        ++ """__Slides {
                position: absolute;
                top: 0;
                width: 500%;
                height: 100%;
                display: flex;
                flex-direction: row;
                left: -200%;
                right: 200%;
                padding: 0;
                margin: 0;
                transition: transform 1000 ms ease"
                cursor: grab;
                overflow-x: auto;
                white-space: nowrap;
                background: gold;
            }
            #"""
        ++ id
        ++ "."
        ++ class
        ++ """__Slides-dragging {
                transition: none;
                }
            #"""
        ++ id
        ++ "."
        ++ class
        ++ """__Slides_Slide {
                max-width: 100%;
                max-height: 50%;
                overflow: auto;
                position: relative;
                user-drag: none;
                user-select: none;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                }
  """


styleSheet : String -> TransitionState -> Html msg
styleSheet id transition =
    node "style"
        []
        [ text <| loggedStyle (ssText id className)
        ]


events : Bool -> TransitionState -> List (Attribute Msg)
events enableDrag transitionState =
    if not enableDrag then
        [ on "transitionend" (Decode.succeed TransitionEnd) ]

    else
        [ on "mousedown" (Decode.map DragStart decodePosX)
        , on "touchstart" (Decode.map DragStart decodePosX)
        , on "transitionend" (Decode.succeed TransitionEnd)
        ]
            ++ (if isDragging transitionState then
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


{-| Extract the PosX from a mouse or touch event
-}
decodePosX : Decode.Decoder Position
decodePosX =
    let
        decoder =
            Decode.map Position <|
                Decode.field "pageX" (Decode.map floor Decode.float)
    in
    Decode.oneOf
        [ decoder
        , Decode.at [ "touches", "0" ] decoder
        ]
