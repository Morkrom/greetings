
module AppleseGallerySlide exposing (Msg, SlideComponentData, ModalVideo, slideContent, slideComponents)

{-

UI components

-}

import Svg exposing (Svg)
import GallerySlideImages exposing (dnb, izonit, res)
import Html exposing (Attribute, Html, h2, text, div, button)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import MorkromCss exposing (..)

type Msg =
  SelectVideo ModalVideo

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
    , useMobileLayout : Bool
    , slideImage : SlideImage
    }


type SlideImage
    = Res
    | Dnb
    | IzOn


slideComponents : Bool -> List SlideComponentData
slideComponents useMobile =
   [ { title = "Preview: Dual N Back"
      , ctaTitle = "View now"
      , videoData =
            { frameDesign = Phoney
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/dnb-demo.mp4"
            }
      , useMobileLayout = useMobile
      , slideImage = Dnb
      },
      { title = "Preview: iZOnIt"
      , ctaTitle = "View now"
      , videoData =
            { frameDesign = Phoney
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/izOnIt.mp4"
            }
      , useMobileLayout = useMobile
      , slideImage = IzOn
      },
      { title = "Sign Posts"
      , ctaTitle = "View now"
      , videoData =
            { frameDesign = Tablet
            , videoUrl = "https://github.com/Morkrom/greetings/raw/refs/heads/main/vid-content/res-demo-c.mp4"
            }
      , useMobileLayout = useMobile
      , slideImage = Res
      }
    ]

slideContentListAttributesForLayout : SlideComponentData -> List (Attribute msg)
slideContentListAttributesForLayout componentData =
    if componentData.useMobileLayout then
        [ style "justify-content" "center"
        , style "display" "flex"
        , style "gap" "0px"
        , style "flex-direction" "column"
        , style "background" "rgb(243, 243, 246)"
        ]

    else
        [ style "justify-content" "flex-start"
        , style "display" "flex"
        , style "gap" "0px"
        , style "flex-direction" "row"
        , style "background" "rgb(243, 243, 246)"
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
    div [ style "width" "100%", style "height" "100%", style "background" "black"]
        [ div []
            [ slideLogo componentData.slideImage ]
        , div ([ style "margin-top" "75%" ] ++ slideContentListAttributesForLayout componentData) <|
            [ slideTitle componentData.title
            , button [ onClick (toSelf (SelectVideo componentData.videoData)) ] [ text componentData.ctaTitle ]
             ]
        ]
