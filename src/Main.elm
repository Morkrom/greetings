module Main exposing (main)

--exposing (Html, button, div, text, a)
--style, href)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Images
import Logo
import MorkromCss exposing (..)
import ObjCIcon exposing (objectiveC)
import Svg.Attributes exposing (scale)
import SwiftIcon exposing (swift)



-- Domain


menuButton : Msg -> String -> Html Msg
menuButton msg title =
    button
        [ onClick msg
        , style "padding" "10px"
        , style "border" "none"
        , style "background" "white"
        ]
        [ text title ]



-- Application


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


sections =
    [ "greetings", "worksample" ]


roundedButton : String -> String -> RoundedButton -> Html Msg
roundedButton title link buttonStyle =
    div
        (roundButtonStyle
            buttonStyle
        )
        [ a
            [ href link
            , style "font-family" "Arial"
            , style "padding-left" "10px"
            , style "padding-right" "10px"
            , style "padding-top" "5px"
            , style "padding-bottom" "5px"
            , style "color" (buttonBackgroundColorTitleString buttonStyle)
            , style "display" "inline-block"
            , style "text-decoration" "none"
            , style "font-size" "12px"
            ]
            [ text title ]
        ]


type alias Model =
    { appSections : List String
    , selectedSection : Int
    }


init : Model
init =
    { appSections = sections
    , selectedSection = 0
    }



-- UPDATE


type Msg
    = Greetings
    | Work


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
    div
        [ style "position" "absolute"
        , style "top" "0%"
        , style "width" "100%"
        ]
        [ div
            [ style "display" "flex"
            , style "justify-content" "center"
            , style "gap" "10px"
            , style "position" "fixed"
            , style "background-color" "rgba(255, 255, 255, 0.95)"
            , style "backdrop-filter" "blur(50px)"
            , style "top" "0"
            , style "left" "0"
            , style "right" "0"
            ]
            [ menuButton Greetings "Greetings"
            , menuButton Work "Work"
            ]
        , div
            [ style "background" "white"
            , style "justify-content" "center"
            , style "display" "flex"
            , style "gap" "10px"

            --, style "background-color" "white"
            , style "flex-direction" "column"
            , style "margin-top" "20px"
            ]
            [ introSection, languageGnostic, exp ]

        --    div [style "background" "red"] [text (String.fromInt model.selectedSection)]
        ]


introSection : Html Msg
introSection =
    div introSectionDivStyle
        (titleText "Michael Mork" "iOS Engineer" ++ [ roundedButtons, titleSvgs ])


roundedButtons : Html Msg
roundedButtons =
    div mainRoundedButtonsStyle
        [ --roundedButton "Résumé" "file:///Users/apple/Software/morkrom/resume-master-a.pdf" Highlighted,
          roundedButton "Contact" "mailto:morkrom@icloud.com" Lowlighted
        ]


titleSvgs : Html Msg
titleSvgs =
    div
        [ style "display" "block"
        , style "margin" "auto"
        ]
        [ Images.phone
        ]


titleTextSubtitle : String -> Html Msg
titleTextSubtitle subtitle =
    h3
        subtitleTextStyle
        [ text subtitle ]


titleText : String -> String -> List (Html Msg)
titleText title subtitle =
    [ h1
        titleTextStyle
        [ text title ]
    , titleTextSubtitle subtitle
    ]


languageGnostic : Html Msg
languageGnostic =
    div introSectionDivStyle
        (titleText "Language" "Any paradigm any day."
            ++ [ roundedButtons ]
            ++ [ div
                    blockContents
                    [ div [ style "width" "200px" ]
                        [ swift []
                        ]
                    , div [ style "width" "200px" ]
                        [ objectiveC []
                        ]
                    , div (smallBlockW 190.0)
                        [ Logo.main
                        ]
                    ]
               ]
        )


exp : Html Msg
exp =
    div introSectionDivStyle
        (titleText "Exp" "\"Experience is the teacher of all things.\" - Julius Caesar"
            ++ [ roundedButtons ]
            ++ [ div blockContents
                    [ thriveMarketExp
                    , fitplanExp
                    ]
               ]
        )


thriveMarketExp : Html Msg
thriveMarketExp =
    expBox "6 yr"
        (linkedExperience
            "Senior iOS Engineer (Core, Verticals, Specialist)⇗"
            "https://thrivemarket.com"
        )
        "Main contributor and stability & performance lead. Satisfied KPIs: Reduce app load time by over 1 second - Eliminate app memory leaks - Own UI performance (scroll). Ads with Instacart - “Fresh” vertical main contributor - Implement Ai chat bot - Main contributor role to Webby winner “Sahara” product release, resulting in roughly 6% increase in sales for more than 1 million user base. Ownership of home screen. Implement Shopping List feature set. Contribute to every section: Autoship, quiz, PLP, PDP, review orders, cart. Deliver weekly for a growing platform of over a million users. Modernize legacy sections. Increase UI & Unit coverage to ~40%. Horiziontal Screen and app load research and solutions using Instruments + New Relic."
        [ "SwiftUI", "UIKit", "Objective-C", "Swift", "Xcode Instruments", "XCTest", "NewRelic", "MVVM" ]
        [ referenceQuote "Michael’s promotion to Senior Engineer is long overdue and well-deserved"
            "Karan Shah, iOS Supervisor"
        ]


fitplanExp : Html Msg
fitplanExp =
    expBox "3 yr"
        (linkedExperience
            "Senior iOS Engineer ⇗"
            "https://www.fitplanapp.com"
        )
        "Guide growth to over 60000 iOS users from 35000. Zumba brand long-format workout experience, Apple Watch experience, a/b funnel growth strategies, lead the remote team to triage pre-existing tech debt, architectural improvements. Fitplan iOS took in ~80% of revenue. App’s improvement half a year after my start allowed us to secure our first outside investment. The pertinent features I implemented were:\n        Before/after collage experience, exercise rest timer, Airplay video experience in partnership with Zumba adapted to digest Fitplan’s long-format video experience, Audio Session management, Apple Watch extension, Stabilize and maintain app crashes from less\n\n        than 98% to within 0.1 of 100%. Deliver innovative custom animations."
        [ "WatchKit", "Core Data", "VIPER", "Core Animation", "AVFoundation", "Airplay", "Lottie", "Swift 5.x", "Objective-C", "Scrum\\Agile" ]
        [ referenceQuote "Michael was able to quickly refactor major parts of our iOS project under a minimal amount of time and planning. He has deep knowledge of best coding practices using apple’s internal libraries as well as 3rd party SDKs. His ability to code review and offer insight to less senior engineers and ability to drive them to the next level was something I’ll miss."
            "- Dan Patey (Mobile Lead Engineer)"
        ]


type alias ReferenceQuote =
    Html Msg


referenceQuote : String -> String -> ReferenceQuote
referenceQuote quote referee =
    p referenceStyle [ text (quote ++ "\n-" ++ referee) ]



-- title, linkout


type alias LinkedExperienceTitle =
    Html Msg


linkedExperience : String -> String -> LinkedExperienceTitle
linkedExperience title link =
    a
        ([ href link
         , attribute "target" "_blank"
         ]
            ++ myExperienceLinkCSS
        )
        [ text title
        ]


technologyHtml : String -> Html msg
technologyHtml technology =
    div technologyBorderedInset
        [ div technologyStyleBordered [ text technology ]
        ]


technologiesHtml : List String -> Html msg
technologiesHtml techs =
    div blockContentsR
        (List.map technologyHtml techs)


expBox : String -> LinkedExperienceTitle -> String -> List String -> List ReferenceQuote -> Html Msg
expBox duration titleAndLink bodyText technologies references =
    div
        expBoxStyle
        [ div [ style "margin" "10px" ]
            ([ titleAndLink
             , br [ style "margin-top" "10px" ] []
             , p technologyStyleW [ text duration ]
             , p technologyStyleW [ text bodyText ]
             ]
                ++ [ technologiesHtml technologies ]
                ++ references
            )
        ]
