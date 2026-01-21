module Images exposing (phone)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


type ImageId
    = Phone


type Event
    = Hover ImageId


phoneAppSize : Float
phoneAppSize =
    25.0


type alias PhoneAppElement =
    { x : Float
    , y : Float
    , startDelay : Float
    }


phoneColumns =
    [ 1, 2, 3, 4 ]


phoneRows =
    [ 1, 2, 3, 4, 5, 6 ]


phoneAppsRow : Float -> Int -> List PhoneAppElement
phoneAppsRow size row =
    List.map
        (\column ->
            { x = toFloat column * (1.0 + size)
            , y = toFloat row * (5.0 + size) + 30
            , startDelay = (toFloat column * 0.3) + (toFloat row * 0.3)
            }
        )
        phoneColumns


phoneApps : Float -> List PhoneAppElement
phoneApps size =
    List.map (\row -> phoneAppsRow size row) phoneRows
        |> List.concat


phoneAppsElements : Float -> List (Svg msg)
phoneAppsElements size =
    List.map (\item -> toPhoneScreenElement item) (phoneApps size)


toPhoneScreenElement : PhoneAppElement -> Svg msg
toPhoneScreenElement element =
    svg [ viewBox phoneVB ]
        [ rect
            [ x (String.fromFloat element.x)
            , y (String.fromFloat element.y)
            , width "20"
            , height "20"
            , fill "blue"
            ]
            []
        , animate
            [ attributeName "opacity"
            , values "0;1;0"
            , dur "1.0s"
            , repeatCount "indefinite"
            , begin (String.fromFloat element.startDelay)
            ]
            []
        ]


phoneVB : String
phoneVB =
    "0 0 150 312"


phone : Svg msg
phone =
    svg
        [ width "120"
        , height "250"
        , viewBox phoneVB
        ]
        ([ rect
            [ x "15"
            , y "31"
            , width "120"
            , height "250"
            , rx "20"
            , ry "20"
            , fill "black"
            ]
            []
         , rect
            [ x "25"
            , y "55"
            , width "100"
            , height "195"
            , fill "white"

            --   , onMouseOver "visiblePainted"
            ]
            []
         ]
            ++ phoneAppsElements phoneAppSize
        )
