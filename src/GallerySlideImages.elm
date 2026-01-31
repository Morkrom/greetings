module GallerySlideImages exposing (dnb, izonit, res)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


phoneVB : String
phoneVB =
    "0 0 720 720"


presize : List (Svg msg) -> Svg msg
presize colorString =
    svg
        [ width "100%"
        , height "100%"
        , viewBox phoneVB
        , preserveAspectRatio "none"
        ]
        [ defs []
            [ linearGradient [ id "grad", x1 "0", x2 "1", y1 "1", y2 "0" ] <|
                colorString
            ]
        , rect
            [ x "0"
            , y "0"
            , width "720"
            , height "720"
            , rx "20"
            , ry "20"
            , fill "url('#grad')"
            ]
            []
        ]


res : Svg msg
res =
    presize
        [ stop
            [ offset "0%"
            , stopColor "gold"
            ]
            []
        , stop
            [ offset "25%"
            , stopColor "#04f9bc"
            ]
            []
        , stop
            [ offset "85%"
            , stopColor "black"
            ]
            []
        ]



{- }
   64 232 204
   230 30 69
-}


dnb : Svg msg
dnb =
    presize
        [ stop
            [ offset "0%"
            , stopColor "#40e8cc"
            ]
            []
        , stop
            [ offset "75%"
            , stopColor "#e61e45"
            ]
            []
        ]



--"rgb(2, 102, 223)"
-- black


izonit : Svg msg
izonit =
    presize
        [ stop
            [ offset "0%"
            , stopColor "#0d02dd"
            ]
            []
        , stop
            [ offset "35%"
            , stopColor "#000000"
            ]
            []
        ]
