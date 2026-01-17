module MorkromCss exposing (main)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)

myExperienceLinkCSS : Html.Styled.Attributes
myExperienceLinkCSS =
  css [ fontFamily "Arial"
      , textDecoration none
      , fontSize (px 14)
      , display inlineBlock,
      , color rgb (2, 102, 223)]
