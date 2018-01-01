import Task
import Date exposing (Date)
import Time exposing (Time)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model = {
    time: Time
    }

init : (Model, Cmd Msg)
init =
  (Model 0, Cmd.none)


-- UPDATE

type Msg = Click | NewTime Time

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Click ->
        (model, Task.perform NewTime Time.now)

    NewTime time ->
        (Model time, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Click ] [ text "Update" ]
    , div [] [ text (toString (Date.fromTime model.time)) ]
    ]


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
