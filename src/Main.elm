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
       style "top" "0%",
       style "width" "100%"] [ 
    div [
         style "display" "flex",
         style "justify-content" "center",
         style "gap" "10px",  
         style "position" "fixed",
         style "background-color" "rgba(255, 255, 255, 0.95)",
         style "backdrop-filter" "blur(50px)",
         style "top" "0",
         style "left" "0",
         style "right" "0"
      ]
      [
        menuButton Greetings "Greetings",
        menuButton Work "Work"
      ],
      div [style "background" "white", 
           style "justify-content" "center", 
           style "display" "flex", 
           style "gap" "10px",
           style "background-color" "white",
           style "flex-direction" "column", 
           style "margin-top" "20px"] 
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
      (titleText "Language" "Any paradigm any day.") ++
      [roundedButtons] ++
      [div [
          style "justify-content" "center",
          style "display" "flex", style "gap" "20px",
          style "flex-direction" "row",
          style "flex-wrap" "wrap",
          style "background" "rgb(243, 243, 246)", style "margin-top" "20px"]
        [ div [style "width" "200px"] [
            swift [ ]],
          div [style "width" "200px"] [ 
            objectiveC [ ]],
          div [style "width" "190px"] [
            Logo.main
        ]
       ]
     ])

exp : Html Msg
exp = 
  div introSectionDivStyle
  (  (titleText "Exp" "Experience is the teacher of all things. <br>- J. Caesar")
  ++ [roundedButtons] ++ 
  [ expBox "IV annus" 
           (linkedExperience 
             "Senior iOS Engineer (Core, Verticals, Specialist)" 
             "https://thrivemarket.com")
           "Main contributor and stability & performance lead. Satisfied KPIs: Reduce app load time by over 1 second - Eliminate app memory leaks - Own UI performance (scroll). Ads with Instacart - “Fresh” vertical main contributor - Implement Ai chat bot - Main contributor role to Webby winner “Sahara” product release, resulting in roughly 6% increase in sales for more than 1 million user base. Ownership of home screen. Implement Shopping List feature set. Contribute to every section: Autoship, quiz, PLP, PDP, review orders, cart. Deliver on a growing platform of over a million users. Modernize legacy sections. Increase UI & Unit coverage to ~40%. Horiziontal Screen and app load research and solutions using Instruments + New Relic."
          ["SwiftUI", "UIKit", "Objective-C", "Swift", "Xcode Instruments", "XCTest", "NewRelic", "MVVM"]
  ]
  
{-
 52           style "font-family" "Arial",
 53           style "padding-left" "10px",
 54           style "padding-right" "10px",
 55           style "padding-top" "5px",
 56           style "padding-bottom" "5px",
 57           style "color" (buttonBackgroundColorTitleString buttonStyle),
 58           style "display" "inline-block",
 59           style "text-decoration" "none",
 60           style "font-size" "12px"
-}

{-
typealias ReferenceQuote = Html Msg
referenceQuote : String -> String -> ReferenceQuote
referenceQuote quote referee = 
-}

-- title, linkout
typealias LinkedExperienceTitle : String -> String -> Html Msg
linkedExperience title : LinkedExperienceTitle
linkedExperience title link =
  a [ href link
    , myExperienceLinkCSS
    ] 
    [ text title 
    ] 

expBox : String -> LinkedExperinceTitle -> String -> List String -> ReferenceQuote -> Html Msg

