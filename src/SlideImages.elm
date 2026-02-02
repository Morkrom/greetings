module SlideImages exposing (..)

import Svg
import Svg.Attributes exposing (..)
import VirtualDom exposing (Attribute, attribute)


caseStroke : Svg.Attribute msg
caseStroke =
    attribute "stroke" "lightsteelblue"


briefcase : String -> Svg.Svg msg
briefcase strokeWidth =
    Svg.node "svg"
        [ viewBox "0 0 438 305"
        , attribute "width" "100%"
        , attribute "height" "100%"
        , preserveAspectRatio "xMidYMid meet"
        ]
        [ Svg.node "g"
            []
            [ Svg.node "rect" [ attribute "fill-opacity" "0", caseStroke, attribute "rx" "10", attribute "id" "svg_4", attribute "height" "251.00001", attribute "width" "418", attribute "y" "50", attribute "x" "5", attribute "stroke-width" "10", attribute "fill" "#0000ff" ] []
            , Svg.node "rect" [ attribute "fill-opacity" "0", attribute "rx" "5", attribute "id" "svg_6", attribute "height" "45", attribute "width" "96", attribute "y" "5", attribute "x" "161", attribute "stroke-width" "10", caseStroke ] []
            , Svg.node "rect" [ attribute "id" "svg_7", attribute "height" "0", attribute "width" "26", attribute "y" "0", attribute "x" "0", attribute "stroke-width" "15", caseStroke, attribute "fill" "none" ] []
            , Svg.node "line" [ caseStroke, attribute "id" "svg_14", attribute "y2" "130", attribute "x2" "418", attribute "y1" "130", attribute "x1" "0", attribute "stroke-width" "8", attribute "fill" "none" ] []
            , Svg.node "rect" [ attribute "rx" "5", attribute "id" "svg_22", attribute "height" "35", attribute "width" "46", attribute "y" "75", attribute "x" "285", attribute "stroke-width" "8", attribute "stroke" "gold", attribute "fill" "none" ] []
            , Svg.node "rect" [ attribute "stroke" "gold", attribute "rx" "4", attribute "id" "svg_23", attribute "height" "26", attribute "width" "7", attribute "y" "95", attribute "x" "305", attribute "stroke-width" "8", attribute "fill" "none" ] []
            , Svg.node "rect" [ attribute "rx" "5", attribute "id" "svg_22", attribute "height" "35", attribute "width" "46", attribute "y" "75", attribute "x" "81", attribute "stroke-width" "8", attribute "stroke" "gold", attribute "fill" "none" ] []
            , Svg.node "rect" [ attribute "stroke" "gold", attribute "rx" "4", attribute "id" "svg_23", attribute "height" "26", attribute "width" "7", attribute "y" "95", attribute "x" "101", attribute "opacity" "NaN", attribute "stroke-width" "8", attribute "fill" "none" ] []
            ]
        ]


eyeball : Svg.Svg msg
eyeball =
    Svg.node "svg"
        [ viewBox "0 0 190 190"
        , attribute "width" "100%"
        , attribute "height" "100%"
        , preserveAspectRatio "xMidYMid meet"
        ]
        [ Svg.node "defs"
            []
            [ Svg.node "radialGradient"
                [ attribute "r" "0.54308", attribute "cy" "0.5", attribute "cx" "0.5", attribute "spreadMethod" "pad", attribute "id" "svg_36" ]
                [ Svg.node "stop" [ attribute "offset" "0.83984", attribute "stop-color" "#ffffff" ] []
                , Svg.node "stop" [ attribute "offset" "1", attribute "stop-color" "#000000" ] []
                ]
            ]
        , Svg.node "g"
            []
            [ Svg.node "ellipse" [ attribute "stroke" "#000", attribute "ry" "95", attribute "rx" "95", attribute "id" "svg_32", attribute "cy" "95", attribute "cx" "95", attribute "stroke-width" "0", attribute "fill" "url(#svg_36)" ] []
            , Svg.node "ellipse" [ attribute "stroke" "#000", attribute "ry" "65", attribute "rx" "65", attribute "id" "svg_32", attribute "cy" "95", attribute "cx" "95", attribute "stroke-width" "0", attribute "fill" "#191919" ] []
            ]
        ]
