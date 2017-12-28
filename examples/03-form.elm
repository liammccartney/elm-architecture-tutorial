import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" Name
    , viewInput "password" "Password" Password
    , viewInput "password" "Re-enter Password" PasswordAgain
    , viewValidation model
    ]


viewInput inputType labelText onInputMsg =
    div []
      [ span [] [ text (labelText ++ " ") ]
      , input [ type_ inputType, placeholder "", onInput onInputMsg ] []
      ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if not (String.isEmpty model.password) &&
         String.length model.password < 8 then
        ("red", "Password too short")
      else if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]
