module AppleseGallerySlide exposing (ModalVideo, Msg, SlideComponentData, slideComponents, slideContent)

{-

   UI components

-}

import GallerySlideImages exposing (dnb, izonit, res)
import Html exposing (Attribute, Html, button, div, h2, text)
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
    , ctaTitle : String
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
            sw > 720
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
    [ { title = "Preview: Dual N Back"
      , ctaTitle = "View now"
      , videoData =
            { frameDesign = Phoney
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/dnb-demo.mp4"
            }
      , slideImage = Dnb
      , sizeClass = sizeClass screenWidth
      , svgSize = svgsize (sizeClass screenWidth) screenWidth
      }
    , { title = "Preview: iZOnIt"
      , ctaTitle = "View now"
      , videoData =
            { frameDesign = Phoney
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/izOnIt.mp4"
            }
      , slideImage = IzOn
      , sizeClass = sizeClass screenWidth
      , svgSize = svgsize (sizeClass screenWidth) screenWidth
      }
    , { title = "Sign Posts"
      , ctaTitle = "View now"
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


slideTitle : String -> Html msg
slideTitle title =
    h2 [] [ text title ]


slideContent : (Msg -> msg) -> SlideComponentData -> Html msg
slideContent toSelf componentData =
    div
        [ style "width" "99%"
        , style "height" "99%"
        , style "background" "gray"
        , style "position" "relative"
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
                [ slideTitle componentData.title
                , button [ onClick (toSelf (SelectVideo componentData.videoData)) ] [ text componentData.ctaTitle ]
                ]
            ]
        ]


divContentClass : SizeClass -> String
divContentClass class =
    case class of
        Large ->
            "galleryContentFlowBig"

        Small ->
            "galleryContentFlow"
