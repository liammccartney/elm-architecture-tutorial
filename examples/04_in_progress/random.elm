import Random
import Task
import Html exposing (..)
import Html.Events exposing (onClick)

main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
    { dieFace1 : Int
    , dieFace2 : Int
    }

type Msg
    = BatchRoll
    | Roll Int
    | NewFace Int Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        BatchRoll ->
            (model, Cmd.batch [Task.perform Roll (Task.succeed 1)
                              , Task.perform Roll (Task.succeed 2)])

        Roll face ->
            (model, Random.generate (NewFace face) (Random.int 1 6))

        NewFace face newFaceVal ->
            case face of
                1 ->
                    ({model | dieFace1 = newFaceVal}, Cmd.none)
                2 ->
                    ({model | dieFace2 = newFaceVal}, Cmd.none)
                _ ->
                    (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Html Msg
view model =
    div []
    [ h1 [] [ text (toString model.dieFace1) ]
    , h1 [] [ text (toString model.dieFace2) ]
    , button [ onClick BatchRoll ] [ text "Roll" ]
    ]

init : (Model, Cmd Msg)
init =
    (Model 1 1, Cmd.none)
