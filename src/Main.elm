module Main exposing (main)

import Html as H
import Html.Attributes as HA

main : H.Html msg
main =
    H.p []
        [ H.text "Hello, "
        , H.span [ HA.class "name" ] [ H.text "Dwayne" ]
        , H.text "!"
        ]
