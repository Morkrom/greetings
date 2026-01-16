module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text, a)
import Html.Attributes exposing (style, href)
import Svg.Attributes exposing (scale)
import Html.Events exposing (onClick)
import SwiftIcon exposing (swift)
import ObjCIcon exposing (objectiveC)
import Logo
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

--"mailto:morkrom@icloud.com"
--file:///Users/apple/Software/morkrom/index.html
roundedButton : String -> String -> RoundedButton -> Html Msg
roundedButton title link buttonStyle = 
  div [style "border-width" "1px", 
       style "border-color" "rgb(2, 102, 223)", 
       style "border-style" "solid", 
       style "border-radius" "30px",
       style "background-color" (buttonBackgroundColorString buttonStyle)]
      [
       a 
         [href link,
          style "font-family" "Arial", 
          style "padding-left" "10px",
          style "padding-right" "10px",
          style "padding-top" "5px",
          style "padding-bottom" "5px",
          style "color" (buttonBackgroundColorTitleString buttonStyle),
          style "display" "inline-block",
          style "text-decoration" "none",
          style "font-size" "12px"
         ]
          [text title]
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
           style "display" "flex", 
           style "gap" "10px",
           style "flex-direction" "column"] 
        ([introSection, languageGnostic])
--    div [style "background" "red"] [text (String.fromInt model.selectedSection)]
  ]

introSectionDivStyle : List (Html.Attribute msg)
introSectionDivStyle = 
  [
    style "justify-content" "center",
    style "display" "flex",
    style "gap" "0px",
    style "flex-direction" "column", 
    style "background" "rgb(243, 243, 246)"
  ]

introSection : Html Msg
introSection = div introSectionDivStyle
  ((titleText "Michael Mork" "iOS Engineer") ++ [roundedButtons, titleSvgs])

roundedButtons : Html Msg
roundedButtons = div [ 
        style "justify-content" "center", 
        style "display" "flex",
        style "gap" "10px",
        style "flex-direction" "row", 
        style "background" "rgb(243, 243, 246)"]
   [
    --roundedButton "Résumé" "file:///Users/apple/Software/morkrom/resume-master-a.pdf" Highlighted, 
    roundedButton "Contact" "mailto:morkrom@icloud.com" Lowlighted
  ]

titleSvgs : Html Msg
titleSvgs = div [
    style "display" "block",
    style "margin" "auto"
  ] [
      Images.phone 
  ]

titleTextSubtitle : String -> Html Msg
titleTextSubtitle subtitle = 
  
  div [ 
       style "justify-content" "center", 
       style "display" "flex", style "gap" "1px",
       style "flex-direction" "row", 
       style "background" "rgb(243, 243, 246)"]
  [
    Html.h3 [style "margin" "10", 
             style "font-family" "Arial",
             style "line-height" "0px",
             style "font-weight" "300"] [text subtitle]
  ]

titleText : String -> String -> List (Html Msg)
titleText title subtitle = 
    [Html.h1 [
              style "margin-top" "45px", 
              style "font-family" "Arial", 
              style "text-align" "center", 
              style "line-height" "0px"] [text title], 
     titleTextSubtitle subtitle
    ]

languageGnostic : Html Msg
languageGnostic = 
     div introSectionDivStyle 
     (
      (titleText "Language" "Any paradigm any day") ++
      [div [
          style "justify-content" "center",
          style "display" "flex", style "gap" "20px",
          style "flex-direction" "row",
          style "flex-wrap" "wrap",
          style "background" "rgb(243, 243, 246)"]
        [ div [style "width" "200px"] [
            swift [ ]],
          div [style "width" "200px"] [ 
            objectiveC [ ]],
          div [style "width" "190px"] [
            Logo.main
        ]
       ]
     ])
