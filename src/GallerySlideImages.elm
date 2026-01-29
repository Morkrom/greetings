module GallerySlideImages exposing (dnb, izonit, res)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


phoneVB : String
phoneVB =
    "0 0 280 280"


res : Svg msg
res =
    svg
        [ width "280"
        , height "280"
        , viewBox phoneVB
        ]
        [ rect
            [ x "0"
            , y "0"
            , width "280"
            , height "280"
            , rx "20"
            , ry "20"
            , fill "red"
            ]
            []
        ]


dnb : Svg msg
dnb =
    svg
        [ width "280"
        , height "280"
        , viewBox phoneVB
        ]
        [ rect
            [ x "0"
            , y "0"
            , width "280"
            , height "280"
            , rx "20"
            , ry "20"
            , fill "blue"
            ]
            []
        ]


izonit : Svg msg
izonit =
    svg
        [ width "280"
        , height "280"
        , viewBox phoneVB
        ]
        [ rect
            [ x "0"
            , y "0"
            , width "280"
            , height "280"
            , rx "20"
            , ry "20"
            , fill "green"
            ]
            []
        ]
