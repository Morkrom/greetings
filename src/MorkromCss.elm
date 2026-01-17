module MorkromCss exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type TextColor
    = LightBlue
    | AppleBlue
    | LightestGray


type RoundedButton
    = Highlighted
    | Lowlighted


buttonColor : TextColor -> String
buttonColor color =
    case color of
        LightBlue ->
            "rgb(120, 197, 239)"

        LightestGray ->
            "rgb(229, 229, 234)"

        AppleBlue ->
            "rgb(2, 102, 223)"


roundButtonStyle : RoundedButton -> List (Attribute msg)
roundButtonStyle buttonStyle =
    [ style "border-width" "1px"
    , style "border-color" (buttonColor AppleBlue)
    , style "border-style" "solid"
    , style "border-radius" "30px"
    , style "background-color" (buttonBackgroundColorString buttonStyle)
    ]


buttonBackgroundColorTitleString : RoundedButton -> String
buttonBackgroundColorTitleString style =
    case style of
        Highlighted ->
            "white"

        Lowlighted ->
            "rgb(2, 102, 223)"


buttonBackgroundColorString : RoundedButton -> String
buttonBackgroundColorString style =
    case style of
        Highlighted ->
            "rgb(2, 102, 223)"

        Lowlighted ->
            "transparent"


technologyStyleW : List (Attribute msg)
technologyStyleW =
    [ style "font-family" "Arial"
    , style "color" (buttonColor LightestGray)
    , style "font-size" "12px"
    , style "text-align" "left"
    ]


technologyStyleBordered : List (Attribute msg)
technologyStyleBordered =
    [] ++ technologyStyle


technologyStyle : List (Attribute msg)
technologyStyle =
    [ style "font-family" "Arial"
    , style "color" (buttonColor LightBlue) --"rgb(2, 102, 223)"
    , style "font-size" "12px"
    ]


myExperienceLinkCSS : List (Attribute msg)
myExperienceLinkCSS =
    [ style "font-family" "Arial"
    , style "text-decoration" "none"
    , style "font-size" "14px"
    , style "display" "inlineBlock"
    , style "color" (buttonColor LightBlue) --"rgb(2, 102, 223)"
    ]


introSectionDivStyle : List (Attribute msg)
introSectionDivStyle =
    [ style "justify-content" "center"
    , style "display" "flex"
    , style "gap" "0px"
    , style "flex-direction" "column"
    , style "background" "rgb(243, 243, 246)"
    ]


smallBlock : List (Attribute msg)
smallBlock =
    [ style "width" "200.0px"
    ]


smallBlockW : Float -> List (Attribute msg)
smallBlockW w =
    [ style "width" (String.fromFloat w ++ "px")
    ]


blockContents : List (Attribute msg)
blockContents =
    blockContentsR ++ [ style "background" "rgb(243, 243, 246)" ]


blockContentsR : List (Attribute msg)
blockContentsR =
    [ style "justify-content" "center"
    , style "display" "flex"
    , style "gap" "20px"
    , style "flex-direction" "row"
    , style "flex-wrap" "wrap"
    , style "margin-top" "20px"
    ]


expBoxStyle : List (Attribute msg)
expBoxStyle =
    [ style "background" "#1D1D1F"
    , style "border-radius" "20px"
    ]
        ++ smallBlockW 260


titleTextStyle : List (Attribute msg)
titleTextStyle =
    [ style "margin-top" "45px"
    , style "font-family" "Arial"
    , style "text-align" "center"
    , style "line-height" "0px"
    , style "word-break" "break-word"
    ]


subtitleTextStyle : List (Attribute msg)
subtitleTextStyle =
    [ style "margin" "10"
    , style "font-family" "Arial"
    , style "font-weight" "300"
    , style "word-break" "break-word"
    , style "display" "inline-block"
    , style "text-align" "center"
    ]
