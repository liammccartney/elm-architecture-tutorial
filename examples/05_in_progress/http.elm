import Http
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode


main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL
type alias Model =
    { topic : String
    , gifUrl : String
    , errorMsg : String
    }


init : (Model, Cmd Msg)
init =
    ( Model "cats" "" ""
    , getRandomGif "cats"
    )


-- UPDATE
type Msg
    = MorePlease
    | SetTopic String
    | NewGif (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        MorePlease ->
            (model, getRandomGif model.topic)

        SetTopic newTopic ->
            ({model | topic = newTopic}, Cmd.none)

        NewGif (Ok newUrl) ->
            ( { model | errorMsg = "", gifUrl = newUrl }, Cmd.none)

        NewGif (Err _) ->
            ({model | errorMsg = "Wifi broke"}, Cmd.none)


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at ["data", "image_url"] Decode.string






-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ h2 [] [text model.topic]
        , input [onInput SetTopic] [text model.topic]
        , button [onClick MorePlease] [text "More Please!"]
        , viewError model
        , br [] []
        , img [src model.gifUrl] []
        ]

viewError : Model -> Html Msg
viewError model =
    if not (String.isEmpty model.errorMsg) then
        div [ style [("color", "red")]] [ text model.errorMsg ]
    else
        div [] []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
