module Main exposing (main)

--exposing (Html, button, div, text, a)
--style, href)

import AppleseGallery exposing (..)
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


sections =
    [ "Greetings!" ]


type alias Model =
    { appSections : List String
    , selectedSection : Int
    , gallery : AppleseGallery.State
    }



-- Application


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


init : Model
init =
    { appSections = sections
    , selectedSection = 0
    , gallery = AppleseGallery.init
    }



-- UPDATE


type Msg
    = Greetings
    | Work
    | AppleseGalleryMsg AppleseGallery.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Greetings ->
            { model | selectedSection = 0 }

        Work ->
            { model | selectedSection = 1 }

        AppleseGalleryMsg msgg ->
            { model | gallery = Tuple.first (AppleseGallery.update msgg model.gallery) }



-- VIEW


view : Model -> Html Msg
view model =
    div
        parentDiv
        [ div
            menuDiv
            [ menuButton Greetings "Greetings"
            , menuButton Work "Work"
            ]
        , div
            mainDiv
            [ introSection
            , languageGnostic
            , exp
            , Html.map AppleseGalleryMsg <| AppleseGallery.view config model.gallery
            ]

        --    div [style "background" "red"] [text (String.fromInt model.selectedSection)]
        ]


config : AppleseGallery.Config
config =
    AppleseGallery.config
        { id = "applese-gallery"
        , width = AppleseGallery.pct 100
        , height = AppleseGallery.px 500
        , slidePercentileOfWidth = 75
        , slides = appleseSlides
        }


appleseSlides : Slides
appleseSlides =
    [ ( 0
      , div
            [ style "width" "90%"
            , style "height" "100%"
            , style "background" "blue"
            , style "margin" "auto"
            ]
            [ text "blue" ]
      )
    , ( 1
      , div
            [ style "width" "90%"
            , style "height" "100%"
            , style "background" "green"
            , style "margin" "auto"
            ]
            [ text "green" ]
      )
    , ( 2
      , div
            [ style "width" "90%"
            , style "height" "100%"
            , style "background" "red"
            , style "margin" "auto"
            ]
            [ text "red" ]
      )
    ]



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
                    [ div (smallBlockW 195.0)
                        [ swift []
                        ]
                    , div [ style "width" "200px" ]
                        [ objectiveC []
                        ]
                    , div
                        (smallBlockW 190.0
                            ++ [ style "margin-top" "4px" ]
                        )
                        [ Logo.main ]
                    ]
               ]
        )


exp : Html Msg
exp =
    div introSectionDivStyle
        (titleText "Xp" "\"Experience is the teacher of all things.\""
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
            "Senior iOS Engineer (Performance, Features, Verticals, Specialist)⇗"
            "https://thrivemarket.com"
        )
        tmBodyText
        [ "SwiftUI", "UIKit", "Objective-C", "Swift", "Xcode Instruments", "XCTest", "NewRelic", "MVVM" ]
        [ referenceQuote "Michael’s promotion to Senior Engineer is long overdue and well-deserved"
            "- Karan Shah, iOS Supervisor"
        ]


fitplanExp : Html Msg
fitplanExp =
    expBox "3 yr"
        (linkedExperience
            "Senior iOS Engineer ⇗"
            "https://www.fitplanapp.com"
        )
        fitplanBodyText
        [ "WatchKit", "Core Data", "VIPER", "Core Animation", "AVFoundation", "Airplay", "Lottie", "Swift 5.x", "Objective-C", "Scrum\\Agile" ]
        [ referenceQuote "Michael was able to quickly refactor major parts of our iOS project under a minimal amount of time and planning. He has deep knowledge of best coding practices using apple’s internal libraries as well as 3rd party SDKs. His ability to code review and offer insight to less senior engineers and ability to drive them to the next level was something I’ll miss."
            "- Dan Patey (Mobile Lead Engineer)"
        ]


tmBodyText : Html Msg
tmBodyText =
    div technologyStyleW
        [ p technologyStyleW
            [ text
                "Stability & performance lead:"
            ]
        , ul technologyULStyle
            [ text "Reduce app load time by over 1 second"
            , text "Eliminate app memory leaks"
            , text "Own UI performance."
            ]
        , p technologyStyleW
            [ text
                "Features:"
            ]
        , ul technologyULStyle
            [ text "Ads with Instacart"
            , text "\"Fresh\" vertical main contributor"
            , text "Ai chat bot"
            , text "Ownership of home screen"
            , text "Shopping List feature set"
            ]
        , p technologyStyleW
            [ text "Main contributor: Webby winner “Sahara” product release ( 6% increase in sales). Contribute to every section: Autoship, quiz, PLP, PDP, review orders, cart. Deliver weekly for a growing platform of over a million users. Modernize legacy sections. Increase UI & Unit coverage from 0 to 40%."
            ]
        ]


fitplanBodyText : Html Msg
fitplanBodyText =
    div technologyStyleW
        [ p technologyStyleW
            [ text
                "Guide iOS growth nearly 100% to 60000 users from 35000."
            ]
        , p technologyStyleW
            [ text
                "Features:"
            ]
        , ul technologyULStyle
            [ text "\"Zumba\" long-format (Apple TV) workout experience"
            , text "Apple Watch experience"
            , text "Before/after collage"
            , text "Exercise rest timer"
            , text "Audio Session management (Integration with Spotify)"
            , text "custom animations"
            ]
        , p technologyStyleW
            [ text
                "Iterate on Funnel for growth. Lead the remote team to streamline architecture. App’s improvement half a year after my start allowed us to secure our first outside investment. Stabilize and maintain app crashes from less than 98% to within 0.1 of 100%."
            ]
        ]


type alias ReferenceQuote =
    Html Msg


referenceQuote : String -> String -> ReferenceQuote
referenceQuote quote referee =
    p referenceStyle
        [ text quote
        , br [] []
        , br [] []
        , text referee
        ]



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


expBox : String -> LinkedExperienceTitle -> Html Msg -> List String -> List ReferenceQuote -> Html Msg
expBox duration titleAndLink bodyText technologies references =
    div
        expBoxStyle
        [ div [ style "margin" "10px" ]
            ([ titleAndLink
             , br [ style "margin-top" "10px" ] []
             , p technologyStyleW [ text duration ]
             , bodyText --p technologyStyleW [ text bodyText ]
             ]
                ++ [ technologiesHtml technologies ]
                ++ references
            )
        ]
