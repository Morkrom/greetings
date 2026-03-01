module TopIcons.elm exposing (..)

import Svg
import VirtualDom exposing (Attribute, attribute)


svg7 : List (Attribute msg) -> Svg.Svg msg
svg7 attrs = Svg.node "svg" (
  [attribute "width" "200",
   attribute "height" "200", attribute "xmlns" "http://www.w3.org/2000/svg"] ++ attrs)
   [ Svg.node "g" ([attribute "id" "Layer_1"])
     [ Svg.node "title" ([])
       [ Svg.text("Layer 1")],
        Svg.node "rect" ([attribute "id" "svg_3", attribute "height" "0", attribute "width" "1", attribute "y" "92", attribute "x" "175", attribute "stroke" "#000", attribute "fill" "#5656ff"]) [],
        Svg.node "rect" ([attribute "id" "svg_6", attribute "height" "0", attribute "width" "14", attribute "y" "50", attribute "x" "82", attribute "stroke" "#000", attribute "fill" "#5656ff"]) [],
        Svg.node "g" ([attribute "id" "svg_20"]) [ Svg.node "rect" ([attribute "rx" "5", attribute "stroke" "#000", attribute "id" "svg_16", attribute "height" "12", attribute "width" "59", attribute "y" "141", attribute "x" "73", attribute "fill" "#5656ff"]) [],
        Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "4", attribute "id" "svg_18", attribute "height" "9", attribute "width" "52", attribute "y" "157", attribute "x" "77", attribute "fill" "#5656ff"]) [],
        Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "3", attribute "id" "svg_19", attribute "height" "7", attribute "width" "40", attribute "y" "170", attribute "x" "83", attribute "fill" "#5656ff"]) []],
       Svg.node "g" ([attribute "id" "svg_21"]) [ Svg.node "rect" ([attribute "rx" "5", attribute "stroke" "#000", attribute "id" "svg_5", attribute "height" "12", attribute "width" "59", attribute "y" "44", attribute "x" "73", attribute "fill" "#5656ff"]) [],
       Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "4", attribute "id" "svg_8", attribute "height" "9", attribute "width" "52", attribute "y" "31", attribute "x" "77", attribute "fill" "#5656ff"]) [],
        Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "3", attribute "id" "svg_9", attribute "height" "7", attribute "width" "40", attribute "y" "20", attribute "x" "83", attribute "fill" "#5656ff"]) []],
        Svg.node "g" ([attribute "id" "svg_22"]) [ Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "11", attribute "id" "svg_2", attribute "height" "77.00001", attribute "width" "77.00001", attribute "y" "60", attribute "x" "63", attribute "fill" "#000000"]) [],
        Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "11", attribute "id" "svg_14", attribute "height" "66.00001", attribute "width" "66.00001", attribute "y" "66", attribute "x" "68", attribute "fill" "#ffffff"]) [],
        Svg.node "rect" ([attribute "rx" "3", attribute "id" "svg_15", attribute "height" "19", attribute "width" "7", attribute "y" "78", attribute "x" "57", attribute "stroke" "#000", attribute "fill" "#000000"]) []]]]

svg8 : List (Attribute msg) -> Svg.Svg msg
svg8 attrs = Svg.node "svg" (
  [attribute "width" "200",
   attribute "height" "200",
   attribute "xmlns" "http://www.w3.org/2000/svg"] ++ attrs)
   [
   Svg.node "g" ([attribute "id" "Layer_1"]) [
   Svg.node "title" ([]) [ Svg.text("Layer 1")],
    Svg.node "g" ([attribute "stroke" "null", attribute "transform" "rotate(-12.4313 26.4715 29.5671)", attribute "id" "svg_3"])
    [ Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_1", attribute "height" "44.60664", attribute "width" "32.90654", attribute "y" "7.26379", attribute "x" "10.01824", attribute "fill" "#000000"]) [],
     Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_2", attribute "height" "39.48785", attribute "width" "31.44402", attribute "y" "8.36067", attribute "x" "10.7495", attribute "fill" "#ffffff"]) []],
     Svg.node "g" ([attribute "stroke" "null", attribute "transform" "rotate(-4.33566 52.1186 32.5024)", attribute "id" "svg_9"]) [
     Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_7", attribute "height" "56.67715", attribute "width" "41.81101", attribute "y" "4.16386", attribute "x" "31.21306", attribute "fill" "#000000"]) [],
      Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_8", attribute "height" "50.17322", attribute "width" "39.95274", attribute "y" "5.55756", attribute "x" "32.1422", attribute "fill" "#ffffff"]) []],
      Svg.node "g" ([attribute "stroke" "null", attribute "transform" "rotate(17.6894 79.1656 44.4905)", attribute "id" "svg_12"]) [ Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_10", attribute "height" "71.95157", attribute "width" "53.07903", attribute "y" "8.51469", attribute "x" "52.62606", attribute "fill" "#000000"]) [],
      Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_11", attribute "height" "63.69484", attribute "width" "50.71996", attribute "y" "10.28399", attribute "x" "53.80559", attribute "fill" "#ffffff"]) []],
       Svg.node "g" ([attribute "stroke" "null", attribute "transform" "rotate(45 103.821 68.3349)", attribute "id" "svg_15"]) [ Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_13", attribute "height" "84.41237", attribute "width" "62.27142", attribute "y" "26.12874", attribute "x" "72.68542", attribute "fill" "#000000"]) [],
      Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_14", attribute "height" "74.72571", attribute "width" "59.5038", attribute "y" "28.20445", attribute "x" "74.06923", attribute "fill" "#ffffff"]) []],
      Svg.node "g" ([attribute "stroke" "null", attribute "transform" "rotate(58.1145 114.612 98.0316)", attribute "id" "svg_18"]) [ Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_16", attribute "height" "98.60593", attribute "width" "72.74208", attribute "y" "48.72862", attribute "x" "78.24143", attribute "fill" "#000000"]) [],
       Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_17", attribute "height" "87.2905", attribute "width" "69.5091", attribute "y" "51.15336", attribute "x" "79.85792", attribute "fill" "#ffffff"]) []],
       Svg.node "g" ([attribute "stroke" "null", attribute "transform" "rotate(67.7143 110.037 124.153)", attribute "id" "svg_21"]) [ Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_19", attribute "height" "112.58837", attribute "width" "83.05699", attribute "y" "67.85837", attribute "x" "68.50882", attribute "fill" "#000000"]) [], Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_20", attribute "height" "99.66839", attribute "width" "79.36556", attribute "y" "70.62694", attribute "x" "70.35453", attribute "fill" "#ffffff"]) []],
        Svg.node "g" ([attribute "stroke" "null", attribute "transform" "rotate(89.7985 97.6452 148.712)", attribute "id" "svg_24"]) [ Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_22", attribute "height" "125.50975", attribute "width" "92.58916", attribute "y" "85.95744", attribute "x" "51.35067", attribute "fill" "#000000"]) [], Svg.node "rect" ([attribute "stroke" "#000", attribute "rx" "6", attribute "id" "svg_23", attribute "height" "111.10699", attribute "width" "88.47408", attribute "y" "89.04374", attribute "x" "53.40821", attribute "fill" "#ffffff"]) []]]]
