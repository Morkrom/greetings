module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

menuButton : Msg -> String -> Html Msg
menuButton msg title =
  button [onClick msg, 
          style "padding" "19px"] 
         [text title]

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

-- MODEL

sections = ["greetings", "worksample"]

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
       style "background" "gold", 
       style "top" "0%",
       style "width" "100%"] [ 
    div [
         style "background" "blue",
         style "display" "flex",
         style "justify-content" "center",
         style "gap" "10px"
      ]
      [
        menuButton Greetings "Greetings!",
        menuButton Work "Work"
      ],
    div [style "background" "red"] [text (String.fromInt model.selectedSection)]
  ]
