module FSVideoPlayer exposing (Msg, view)

import AppleseGallerySlide as A exposing (ModalVideo, ModalVideoFrameDesign, vidH, vidW)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode


type Msg
    = TapOutVideo


view : { msg : Msg -> msg } -> A.ModalVideo -> Html msg
view msg model =
    -- div
    --     []
    --     [
    div
        [ style "position" "fixed"
        , style "width" "100%"
        , style "height" "100%"
        , style "top" "0"
        , style "left" "0"
        , style "background-color" "rgba(0, 0, 0, 0.75)"
        , style "z-index" "2"
        ]
        [ button
            [ onClick (msg.msg TapOutVideo)
            , style "position" "absolute"
            , style "background" "rgba(0.0, 0.0, 0.0, 0.0)"
            , style "width" "100%"
            , style "height" "100%"
            , style "top" "0"
            , style "left" "0"
            ]
            [ text "Close" ]
        , vidFrame model
        ]


vidFrame : A.ModalVideo -> Html msg
vidFrame vid =
    div
        [ class "centeredElement"
        , style "width" <| pixes (A.vidW vid.frameDesign + 40)
        , style "height" <| pixes (A.vidH vid.frameDesign + 80)
        , style "background" "black"
        , style "border-radius" "15px"
        , style "border" "0.5px solid gray"
        ]
        [ Html.video
            [ src vid.videoUrl
            , class "centeredElement"
            , controls True
            , style "width" <| pixes (A.vidW vid.frameDesign)
            , style "height" <| pixes (A.vidH vid.frameDesign)
            , style "border" "0.5px solid midnightblue"
            ]
            []
        ]


pixes : Int -> String
pixes value =
    String.fromInt value ++ "px"



--]
--p [] [ text videoo.videoUrl ], button [ onClick CloseSelection ] [ text "Close" ] ]
