port module Main exposing (main)

--exposing (Html, button, div, text, a)
--style, href)
--exposing (ModalVideo, SlideComponentData, ModalVideoFrameDesign, SlideImage)
-- import AppleseGallerySlide as Slide exposing (..)

import AppleseGallery exposing (..)
import AppleseGallerySlide exposing (ModalVideo, Msg, SizeClass, sizeClass, slideComponents)
import Browser
import Css exposing (infinite, relative)
import FSVideoPlayer exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Images
import Logo
import MorkromCss exposing (..)
import ObjCIcon exposing (objectiveC)
import SwiftIcon exposing (swift)


sections =
    [ "Greetings!" ]


type alias Model =
    { appSections : List String
    , selectedSection : Int
    , gallery : AppleseGallery.State
    , selectedGalleryVideo : Maybe AppleseGallerySlide.ModalVideo
    , screenWidth : Int
    }



-- Application


main : Program Int Model Msg
main =
    Browser.element
        --.sandbox
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- PORTS


port sendMessage : Int -> Cmd msg


port messageReceiver : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    messageReceiver Receive



-- MODEL


init : Int -> ( Model, Cmd Msg )
init flag =
    ( { appSections = sections
      , selectedSection = 0
      , gallery = AppleseGallery.init
      , selectedGalleryVideo = Nothing
      , screenWidth = flag
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Greetings
    | Work
    | AppleseGalleryMsg AppleseGallery.Msg
    | Receive Int
    | TapOutVideo FSVideoPlayer.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Greetings ->
            ( { model | selectedSection = 0 }, Cmd.none )

        Work ->
            ( { model | selectedSection = 1 }, Cmd.none )

        AppleseGalleryMsg msgg ->
            ( modelWithGalleryAndVideo (galleryAndVideo (Tuple.first (AppleseGallery.update msgg model.gallery))) model
            , Cmd.none
            )

        Receive screenWidth ->
            ( { model | screenWidth = screenWidth }
            , Cmd.none
            )

        TapOutVideo vidMsg ->
            ( { model
                | gallery = Tuple.first <| AppleseGallery.update AppleseGallery.cancelSelectedMsg model.gallery
                , selectedGalleryVideo = Nothing
              }
            , Cmd.none
            )


galleryAndVideo : AppleseGallery.State -> ( AppleseGallery.State, Maybe AppleseGallerySlide.ModalVideo )
galleryAndVideo state =
    ( state, AppleseGallery.videoOfState state )


modelWithGalleryAndVideo : ( AppleseGallery.State, Maybe AppleseGallerySlide.ModalVideo ) -> Model -> Model
modelWithGalleryAndVideo tupple model =
    { model
        | gallery = Tuple.first tupple
        , selectedGalleryVideo = Tuple.second tupple
    }



{- }
   SelectModalVideo video ->
       ( { model
           | selectedModalVideo = Just video
         }
       , Cmd.none
       )
-}
-- VIEW


view : Model -> Html Msg
view model =
    div
        parentDiv
    <|
        [ div
            menuDiv
            [ menuButton Greetings "Greetings"
            ]
        , div
            mainDiv
            [ introSection
            , languageGnostic
            , exp
            , infiniteGalleryView model
            , div [ style "height" "50px" ] []
            ]
        ]
            ++ selectedGalleryVideo model.selectedGalleryVideo model.screenWidth


infiniteGalleryView : Model -> Html Msg
infiniteGalleryView model =
    div (introSectionStyle "gallery")
        [ h1 titleTextStyle [ text "Portfolio" ]
        , AppleseGallery.view (config model.screenWidth) model.gallery (slideComponents model.screenWidth) |> Html.map AppleseGalleryMsg
        ]


selectedGalleryVideo : Maybe AppleseGallerySlide.ModalVideo -> Int -> List (Html Msg)
selectedGalleryVideo video sw =
    case video of
        Just videoo ->
            [ FSVideoPlayer.view { msg = TapOutVideo }
                { modalVideo = videoo
                , sizeClass = AppleseGallerySlide.sizeClass sw
                }
            ]

        Nothing ->
            []


config : Int -> AppleseGallery.Config
config viewportW =
    AppleseGallery.config
        { id = "applese-gallery"
        , width = AppleseGallery.pct 100
        , height = AppleseGallery.px <| configH viewportW
        , slidePercentileOfWidth = 75
        }


configH : Int -> Float
configH viewportW =
    let
        isLarge : Bool
        isLarge =
            viewportW >= 540
    in
    case isLarge of
        False ->
            250

        _ ->
            500


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
    div (introSectionStyle "intro")
        (titleText "Michael Mork" "iOS Engineer" ++ [ roundedButtons, titleSvgs ])


roundedButtons : Html Msg
roundedButtons =
    div mainRoundedButtonsStyle
        [ roundedButton "Contact" "mailto:morkrom@icloud.com" Lowlighted
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
    div (introSectionStyle "language")
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
                            ++ [ style "margin-top" "4px"
                               , style "position" "relative"
                               , style "height" "190px"
                               ]
                        )
                        [ div [ style "position" "absolute" ] [ Logo.main ]
                        , h1
                            [ style "position" "absolute"
                            , style "margin-left" "37px"
                            , style "margin-top" "57px"
                            , style "font-family" "arial"
                            , style "color" "white"
                            , style "text-shadow" "2px 2px 5px black"
                            , style "font-size" "4em"
                            , style "z-index" "1"
                            ]
                            [ text "Elm" ]
                        ]
                    ]
               ]
        )


exp : Html Msg
exp =
    div (introSectionStyle "xp")
        (titleText "Xp" "\"Experience is the teachers of all things.\""
            ++ [ roundedButtons ]
            ++ [ div blockContents
                    [ fitplanExp,
                    dscExp
                    ]
               ]
        )


dscExp : Html Msg
dscExp =
    expBox "5 yr"
        (linkedExperience
            "iOS Engineer⇗"
            "https://us.dollarshaveclub.com/products/8-starter-set?msclkid=b67490363df21e150010f9958400022a&nb_bmt=bp&nb_ci=&nb_fii=&nb_li_ms=&nb_lp_ms=99438&nb_mt=e&nb_oii=80608343601429&nb_pc=&nb_pi=&nb_qs=dollar%20shave%20club%20app&nbt=nb%3Amicrosoft%3Ao%3A638331319%3A1289728440961403%3A80608147400984&utm_campaign=US%20%7C%20BOF%20%7C%20Search%20%7C%20OD%20%2B%20Sub%20%7C%20Brand%20%7C%20Evergreen&utm_content=Name%20%7C%20Starter%20Set%20%7C%20All&utm_medium=cpc&utm_source=bing&utm_term=dollar%20shave%20club%20app"
        )
        tmBodyText
        [ "SwiftUI", "UIKit", "Objective-C", "Swift", "Xcode Instruments", "XCTest", "NewRelic", "MVVM", "Optimizely" ]
        []


fitplanExp : Html Msg
fitplanExp =
    expBox "3 yr"
        (linkedExperience
            "Lead iOS Engineer ⇗"
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
        [
         p technologyStyleW
            [ text "Main contributor: Webby winner product release. Own alerts, settings. Contribute re write project to Swift. With my departure we had roughly 70,000 users. Modernize legacy sections to Swift. Increase UI & Unit coverage to 40%.
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
            [ li [] [ text "\"Zumba\" long-format (Apple TV) workout experience" ]
            , li [] [ text "Apple Watch experience" ]
            , li [] [ text "Before/after collage" ]
            , li [] [ text "Exercise rest timer" ]
            , li [] [ text "Audio Session management (Integration with Spotify)" ]
            , li [] [ text "custom animations" ]
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
