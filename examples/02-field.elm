import Html exposing (Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String



main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { content : String
  }


model : Model
model =
  Model ""


palindrome: String -> Bool
palindrome word =
   not (String.isEmpty word) &&
   String.length word > 1 &&
   word == String.reverse word



-- UPDATE


type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Text to reverse", onInput Change, myStyle ] []
    , div [ myStyle ] [ text (String.reverse model.content) ]
    , div [ hidden (not (palindrome model.content)), myStyle ] [ text "Palindrome!"]
    ]

myStyle =
    style
        [ ("width", "100%")
        , ("height", "40px")
        , ("padding", "10px 0")
        , ("font-size", "2em")
        , ("text-align", "center")
        ]
