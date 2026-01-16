module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

import Images

-- Domain

menuButton : Msg -> String -> Html Msg
menuButton msg title =
  button [onClick msg, 
          style "padding" "10px",
          style "border" "none", 
          style "background" "white" ] 
         [text title]


-- Application

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

-- MODEL

sections = ["greetings", "worksample"]

type RoundedButton = Highlighted | Lowlighted

roundedButton : RoundedButton -> Html Msg
roundedButton buttonStyle =
    div [
      style "padding" "10px",
      style "corner-radius" "30px",
      style "border" "1px",
      style "border-color" "rgb(2, 102, 223)",
      style "height" "60px",
      style "background-color" (buttonBackgroundColorString buttonStyle)
    ] [
       Html.a 
         [Html.Attributes.href "mailto:morkrom@icloud.com"
         
         ],
          [text "Contact"]
    ]
 
buttonBackgroundColorString : RoundedButton -> String
buttonBackgroundColorString style = 
  case style of 
    Highlighted -> 
      "rgb(2, 102, 223)"
    Lowlighted -> 
      "transparent"

type alias Model =
    { appSections: List String, 
      selectedSection: Int
    }

init : Model
init =
    { appSections = sections,
      selectedSection = 0
    }

-- UPDATE

type Msg
    = Greetings | Work

update : Msg -> Model -> Model
update msg model =
    case msg of
        Greetings ->
            { model | selectedSection = 0 }
        Work -> 
            { model | selectedSection = 1 }

-- VIEW

view : Model -> Html Msg
view model =
  div [style "position" "absolute", 
       style "background" "gold", 
       style "top" "0%",
       style "width" "100%"] [ 
    div [
         style "display" "flex",
         style "justify-content" "center",
         style "gap" "10px"
      ]
      [
        menuButton Greetings "Greetings",
        menuButton Work "Work"
      ],
      div [style "background" "white", 
           style "justify-content" "center", 
           style "display" "flex", style "gap" "1px",
           style "flex-direction" "column", 
           style "background" "rgb(243, 243, 246)"] 
        (titleText ++ [roundedButtons]  ++ [ titleSvgs ])
--    div [style "background" "red"] [text (String.fromInt model.selectedSection)]
  ]

roundedButtons : Html Msg
roundedButtons = div [ 
        style "justify-content" "center", 
        style "display" "flex",
        style "gap" "1px",
        style "flex-direction" "row", 
        style "background" "rgb(243, 243, 246)"]
   [
    roundedButton Lowlighted
  ]

titleSvgs : Html Msg
titleSvgs = div [
    style "display" "block",
    style "margin" "auto"
  ] [
      Images.phone 
  ]

titleTextSubtitle : Html Msg
titleTextSubtitle = 
  div [ 
       style "justify-content" "center", 
       style "display" "flex", style "gap" "1px",
       style "flex-direction" "row", 
       style "background" "rgb(243, 243, 246)"]
  [
    Html.h3 [style "margin" "10", 
             style "font-family" "Arial",
             style "line-height" "0px",
             style "font-weight" "300"] [text "iOS Engineer"],
    Html.p [style "font-family" "Arial", 
            style "line-height" "0px",
            style "margin-top" "22px",
            style "font-size" "10px"] [text "  .. and some"]
  ]

titleText : List (Html Msg)
titleText = 
    [Html.h1 [
              style "margin-top" "45px", 
              style "font-family" "Arial", 
              style "text-align" "center", 
              style "line-height" "0px"] [text "Michael Mork"], 
     titleTextSubtitle
    ]
