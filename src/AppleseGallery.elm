module AppleseGallery exposing
    ( Config
    , Index
    , Length
    , Msg
    , Slides
    , State
    , TransitionState
    , cancelSelectedMsg
    , config
    , init
    , pct
    , px
    , update
    , videoOfState
    , view
    )

import AppleseGallerySlide exposing (ModalVideo, Msg, SlideComponentData, slideContent, videoOf)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy)
import Json.Decode as Decode


type alias Slides =
    List ( Int, Html Msg )



-- try this and then try slides injected thru 'view' function which makes more sense lol


type State
    = State Index TransitionState (Maybe ModalVideo)



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
    | CtaMsg AppleseGallerySlide.Msg
    | CancelSelected



--| ButtonMsg ParentButtonMsg.Msg


init : State
init =
    State 0 Resting Nothing


type Config
    = Config
        { id : String
        , width : Length
        , height : Length
        , slidePercentileOfWidth : Int

        --, slides : List (Html Msg)
        }



---> Config
{-
   pageItemPercentileOfScreenWidth : Int
   pageItemPercentileOfScreenWidth =
       75
-}


config :
    { id : String
    , width : Length
    , height : Length
    , slidePercentileOfWidth : Int

    --, slides : List (Html Msg)
    }
    -> Config
config
    { id
    , width
    , height
    , --slides,
      slidePercentileOfWidth
    }
    =
    Config
        { id = id
        , width = width
        , height = height

        --, slides = slides
        , slidePercentileOfWidth = slidePercentileOfWidth
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
update msg ((State index_ transitionState bideo) as state) =
    case msg of
        DragStart position ->
            case transitionState of
                Resting ->
                    ( State index_ (Dragging (Drag position position)) bideo
                    , Cmd.none
                    )

                _ ->
                    ( state
                    , Cmd.none
                    )
                        |> Debug.log "AppleseGallery: drag start"

        DragAt position ->
            case currentDrag transitionState of
                Just drag ->
                    ( State index_ (Dragging (Drag (dragInitialValueP drag) position)) bideo
                    , Cmd.none
                    )

                Nothing ->
                    ( State index_ transitionState bideo
                    , Cmd.none
                    )
                        |> Debug.log "AppleseGallery: drag at"

        --(updatePosition position))
        DragEnd ->
            case currentDrag transitionState of
                Just drag ->
                    case drag of
                        Drag beginning current_ ->
                            if positionValue beginning - positionValue current_ > 100 then
                                ( State index_ (InTransition ToNext) bideo
                                , Cmd.none
                                )
                                    |> Debug.log ("AppleseGallery: dragEnd: ToNext" ++ String.fromInt (positionValue beginning) ++ String.fromInt (positionValue current_))

                            else if positionValue beginning - positionValue current_ < -100 then
                                ( State index_ (InTransition ToPrevious) bideo
                                , Cmd.none
                                )
                                    |> Debug.log ("AppleseGallery: dragEnd: ToPrevious" ++ String.fromInt (positionValue beginning) ++ String.fromInt (positionValue current_))

                            else
                                ( State index_ (InTransition ToCurrent) bideo
                                , Cmd.none
                                )
                                    |> Debug.log ("AppleseGallery: dragEnd: ToCurrent" ++ String.fromInt (positionValue beginning) ++ String.fromInt (positionValue current_))

                Nothing ->
                    ( State index_ Resting bideo
                    , Cmd.none
                    )
                        |> Debug.log "AppleseGallery: dragend: nothing"

        TransitionEnd ->
            ( State (incOrDec (transitionTypeForState transitionState) index_) Resting bideo
            , Cmd.none
            )
                |> Debug.log "AppleseGallery: transition-end"

        CtaMsg msgg ->
            ( State index_ Resting (AppleseGallerySlide.videoOf msgg)
            , Cmd.none
            )
                |> Debug.log "AppleseGallery: cta message"

        CancelSelected ->
            ( State index_ transitionState Nothing, Cmd.none )


cancelSelectedMsg : Msg
cancelSelectedMsg =
    CancelSelected


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


view : Config -> State -> List SlideComponentData -> Html Msg
view ((Config configR) as config_) ((State index transitionState _) as state) slides =
    div
        [ id configR.id
        , style "width" (lengthToString configR.width)
        , style "height" (lengthToString <| configR.height)
        ]
        [ lStyleSheet config_
        , div
            [ class "Wrapper"
            ]
            [ div
                ([ class <|
                    "Slides"
                 , classList
                    [ ( "Slides-dragging", isNotInTransition transitionState )
                    ]
                 ]
                    ++ events True transitionState
                    ++ documentDragStyle transitionState
                )
              <|
                slidesForCurrentIndex index <|
                    List.indexedMap Tuple.pair (slidesFromData slides)
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
            [ style "transform" ("translateX(" ++ String.fromInt (dragCurrentValue drag - dragInitialValue drag) ++ "px)")
            ]

        InTransition t ->
            [ style "transform" ("translateX(" ++ transitionPercentileStr t) --++ pageItemPercentileOfScreenWidthFStr (50.0 - (toFloat pageItemPercentileOfScreenWidth * 2.5) - 10.0)) --"20%") --++ transitionPercentileStr t ++ ")")
            ]


transitionPercentileStr : TransitionType -> String
transitionPercentileStr transition =
    case transition of
        ToNext ->
            pageItemPercentileOfScreenWidthFStr -20.0

        ToPrevious ->
            pageItemPercentileOfScreenWidthFStr 20.0

        --(toFloat pageItemPercentileOfScreenWidth / (toFloat pageItemPercentileOfScreenWidth * toFloat (List.length columns)))
        ToCurrent ->
            "0%"


positionValue : Position -> Int
positionValue (Position position) =
    position


htmlMatchesIndex : Int -> ( Int, Html Msg ) -> Bool
htmlMatchesIndex index slide =
    index == Tuple.first slide


extractHtmlFromSlide : ( Int, Html Msg ) -> Html Msg
extractHtmlFromSlide slide =
    Tuple.second slide


pageItemPercentileOfScreenWidthStr : Int -> String
pageItemPercentileOfScreenWidthStr percentile =
    String.fromInt percentile ++ "%"


pageItemPercentileOfScreenWidthFStr : Float -> String
pageItemPercentileOfScreenWidthFStr percentile =
    String.fromFloat percentile ++ "%"


wrapperWidthString : Int -> String
wrapperWidthString elementPercentageOfWidth =
    pageItemPercentileOfScreenWidthStr (elementPercentageOfWidth * List.length columns)


wrapperRestingPercentileOffset : Int -> String
wrapperRestingPercentileOffset elementPercentageOfWidth =
    --"50%"
    pageItemPercentileOfScreenWidthFStr (50.0 - (toFloat elementPercentageOfWidth * 2.5))


htmlForIndex : List ( Int, Html Msg ) -> Int -> Html Msg
htmlForIndex insideOf column =
    div
        [ classList
            [ ( "Slides-slide", True )
            , ( "active", True )
            ]
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


videoOfState : State -> Maybe AppleseGallerySlide.ModalVideo
videoOfState ((State _ _ video) as state) =
    video
        |> Debug.log "videoofstate"


slidesForCurrentIndex : Index -> List ( Int, Html Msg ) -> List (Html Msg)
slidesForCurrentIndex index all =
    let
        addedd =
            List.map (addeddIndex index) columns
                |> List.map (modIndex (List.length all))
    in
    List.map (htmlForIndex all) addedd


addeddIndex : Int -> Int -> Int
addeddIndex currentIndex offset =
    currentIndex + offset


modIndex : Int -> Int -> Int
modIndex left right =
    modBy left right


lStyleSheet : Config -> Html Msg
lStyleSheet configR =
    lazy (\c -> styleSheet c) configR


ssText : Config -> String
ssText ((Config configR) as config_) =
    """
            #"""
        ++ configR.id
        ++ """ .Wrapper {
                width: 100%;
                height: 100%;
                overflow: hidden;
            }

            #"""
        ++ configR.id
        ++ """ .Slides {
                position: relative;
                top: 0;
                height: 100%;
                display: flex;
                flex-direction: row;
                padding: 0;
                margin: 0;
                cursor: grab;
                overflow-x: auto;
                white-space: nowrap;
                width: """
        ++ wrapperWidthString configR.slidePercentileOfWidth
        ++ ";"
        ++ """
                left: """
        ++ wrapperRestingPercentileOffset configR.slidePercentileOfWidth
        ++ ";"
        ++ """
                transition: transform 300ms ease;
            }
            #"""
        ++ configR.id
        ++ """ .Slides-dragging {
                transition: none;
                }
            #"""
        ++ configR.id
        ++ """ .Slides-slide {
                width: """
        ++ pageItemPercentileOfScreenWidthStr configR.slidePercentileOfWidth
        ++ ";"
        ++ """
                max-height: 100%;
                overflow: auto;
                position: relative;
                user-drag: none;
                user-select: none;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                display: inline-block;
                }
  """


styleSheet : Config -> Html Msg
styleSheet configR =
    node "style"
        []
        [ text <| ssText configR
        ]


events : Bool -> TransitionState -> List (Attribute Msg)
events enableDrag transitionState =
    if not enableDrag then
        []

    else
        [ on "mousedown" (Decode.map DragStart decodePosX)
        , on "touchstart" (Decode.map DragStart decodePosX)
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
                    [ on "transitionend" (Decode.succeed TransitionEnd) ]
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


slidesFromData : List SlideComponentData -> List (Html Msg)
slidesFromData components =
    List.map (slideContent CtaMsg) components
