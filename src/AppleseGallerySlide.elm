module AppleseGallerySlide exposing
    ( ModalVideo
    , ModalVideoFrameDesign
    , Msg
    , SizeClass
    , SlideComponentData
    , sizeClass
    , slideComponents
    , slideContent
    , vidH
    , vidW
    , videoOf
    )

import GallerySlideImages exposing (dnb, izonit, res)
import Html exposing (Attribute, Html, button, div, h2, h4, text)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import MorkromCss exposing (..)
import Svg exposing (Svg)


type Msg
    = SelectVideo ModalVideo


type ModalVideoFrameDesign
    = Tablet
    | Phoney


type alias ModalVideo =
    { frameDesign : ModalVideoFrameDesign
    , videoUrl : String
    }


type alias SlideComponentData =
    { title : String
    , description : String
    , ctaTitle : String
    , textColor : String
    , videoData : ModalVideo

    --, backgroundSvg : Svg msg
    , slideImage : SlideImage
    , sizeClass : SizeClass
    , svgSize : SvgSize
    }


type SlideImage
    = Res
    | Dnb
    | IzOn


type SizeClass
    = Small
    | Large


type alias SvgSize =
    { w : String
    , h : String
    }


sizeClass : Int -> SizeClass
sizeClass sw =
    let
        notIsSmall : Bool
        notIsSmall =
            sw > 540
    in
    case notIsSmall of
        True ->
            Large

        False ->
            Small


smallWidth : Int -> Int
smallWidth sw =
    let
        notIsSmall : Bool
        notIsSmall =
            sw > 320
    in
    case notIsSmall of
        True ->
            280

        False ->
            180


svgH : SizeClass -> Int
svgH sc =
    case sc of
        Small ->
            230

        Large ->
            450


svgW : SizeClass -> Int -> Int
svgW sc sW =
    case sc of
        Small ->
            smallWidth sW

        Large ->
            round ((toFloat sW * 0.75) - (toFloat sW * 0.1))


svgsize : SizeClass -> Int -> SvgSize
svgsize sc sw =
    { w = String.fromInt (svgW sc sw) ++ "px"
    , h = String.fromInt (svgH sc) ++ "px"
    }


slideComponents : Int -> List SlideComponentData
slideComponents screenWidth =
    [ { title = "Dual N Back:"
      , description = "Coming soon to the App Store"
      , ctaTitle = "View now"
      , textColor = "black"
      , videoData =
            { frameDesign = Phoney
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/dnb-demo.mp4"
            }
      , slideImage = Dnb
      , sizeClass = sizeClass screenWidth
      , svgSize = svgsize (sizeClass screenWidth) screenWidth
      }
    , { title = "izOnIt:"
      , description = "Coming soon to the App Store"
      , ctaTitle = "View now"
      , textColor = "white"
      , videoData =
            { frameDesign = Phoney
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/izOnIt.mp4"
            }
      , slideImage = IzOn
      , sizeClass = sizeClass screenWidth
      , svgSize = svgsize (sizeClass screenWidth) screenWidth
      }
    , { title = "Portfolio"
      , description = "Reminisce a moment!"
      , ctaTitle = "View now"
      , textColor = "black"
      , videoData =
            { frameDesign = Tablet
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/res-demo-c.mp4"
            }
      , slideImage = Res
      , sizeClass = sizeClass screenWidth
      , svgSize = svgsize (sizeClass screenWidth) screenWidth
      }
    ]


slideLogo : SlideImage -> Svg msg
slideLogo data =
    case data of
        Dnb ->
            dnb

        IzOn ->
            izonit

        Res ->
            res


slideTitle : String -> String -> Html msg
slideTitle title color =
    h2
        [ class "slideTitle"
        , style "color" color
        , style "margin-top" "5px"
        ]
        [ text title ]


slideDescription : String -> String -> SizeClass -> Html msg
slideDescription title color sc =
    h4
        [ class "slideDesc"
        , style "color" color
        , style "inline-size" <| descriptionWidth sc
        , style "margin-top" "12px"
        ]
        [ text title ]


descriptionWidth : SizeClass -> String
descriptionWidth sc =
    case sc of
        Large ->
            String.fromInt 250 ++ "px"

        Small ->
            String.fromInt 150 ++ "px"


videoOf : Msg -> Maybe ModalVideo
videoOf msg =
    case msg of
        SelectVideo video ->
            Just video


slideContent : (Msg -> msg) -> SlideComponentData -> Html msg
slideContent toSelf componentData =
    div
        [ style "width" "100%"
        , style "height" "100%"
        , style "position" "relative"
        , style "background-color" "rgb(243, 243, 246)"
        ]
        [ -- div [style "margin" "auto", style "width" "70%", style "background" "pink", style "position" "relative"] [
          div
            [ style "margin" "0"
            , style "position" "absolute"
            , style "top" "50%"
            , style "left" "50%"
            , style "transform" "translate(-50%, -50%)"
            ]
            --[style "margin" "auto", style "width" "80%", style "position" "relative"]
            [ div
                [ style "width" componentData.svgSize.w
                , style "height" componentData.svgSize.h
                ]
                [ slideLogo componentData.slideImage ]
            , div
                ([ style "position" "absolute"
                 , style "bottom" "10%"
                 , style "left" "10%"
                 ]
                    ++ [ class (divContentClass componentData.sizeClass) ]
                )
              --++ slideContentListAttributesForLayout componentData) <|
              <|
                slideList toSelf componentData
            ]
        ]


slideText : (Msg -> msg) -> SlideComponentData -> List (Html msg)
slideText toSelf component =
    let
        list =
            [ slideTitle component.title component.textColor
            , slideDescription component.description component.textColor component.sizeClass
            ]
    in
    case component.sizeClass of
        Large ->
            [ button
                [ class "slideButton"
                , style "display" "inline-block"
                , style "height" "35px"
                , onClick (toSelf (SelectVideo component.videoData))
                ]
                [ text component.ctaTitle ]
            ]
                ++ list

        Small ->
            list
                ++ [ button
                        [ class "slideButton"
                        , style "display" "inline-block"
                        , style "height" "25px"
                        , onClick (toSelf (SelectVideo component.videoData))
                        ]
                        [ text component.ctaTitle ]
                   ]


slideList : (Msg -> msg) -> SlideComponentData -> List (Html msg)
slideList toSelf component =
    slideText toSelf component


divContentClass : SizeClass -> String
divContentClass class =
    case class of
        Large ->
            "galleryContentFlowBig"

        Small ->
            "galleryContentFlow"


vidW : ModalVideoFrameDesign -> SizeClass -> Int
vidW frame sc =
    case frame of
        Tablet ->
            case sc of
                Large ->
                    714

                Small ->
                    201

        Phoney ->
            201


vidH : ModalVideoFrameDesign -> SizeClass -> Int
vidH frame sc =
    case frame of
        Tablet ->
            case sc of
                Large ->
                    401

                Small ->
                    112

        Phoney ->
            348
