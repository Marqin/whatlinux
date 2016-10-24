import Html exposing (Html, button, div, text, br)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes exposing (href)
import Dict

type Model = Init | Company | Personal | Server | Home | Pro | Newbie
type alias Msg = Model

main : Program Never
main = App.beginnerProgram { model = model, view = view, update = update }

model : Model
model = Init

update : Msg -> Model -> Model
update msg model = msg

view : Model -> Html Msg
view model =
  div [] <|
  [
    text "I need Linux distro for:",
    br [] [],
    div [] (getView model),
    br [] []
  ] ++ backButton model ++ disclaimer

---

disclaimer : List (Html Model)
disclaimer =
  [
    br [] [],
    br [] [],
    text "This website is not connected with any Linux distro linked here.",
    br [] [],
    Html.b [] [ text "This website comes without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this website and/or any content linked by it."],
    br [] [],
    Html.a [href "https://github.com/Marqin/whatlinux/"] [text "Source Code"]
  ]

backButton : Model -> List (Html Model)
backButton model =
  if model == Init then
    []
  else
    [button [onClick <| previous model] [text "Get back!"]]

previous : Model -> Model
previous model =
  case model of
    Server -> Personal
    Home -> Personal
    Pro -> Home
    Newbie -> Home
    _ -> Init

getView : Model -> List (Html Model)
getView x =
  case Dict.get (toString x) mainTree of
    Just node -> node
    Nothing -> []

mainTree : Dict.Dict String (List (Html Model))
mainTree =
  Dict.fromList [
    ("Init", init),
    ("Personal", personal),
    ("Company", company),
    ("Server", server),
    ("Home", home),
    ("Newbie", newbie),
    ("Pro", pro)
  ]

init : List (Html Model)
init =
  [
    button [ onClick Company ] [ text "Company" ],
    button [ onClick Personal ] [ text "Personal usage" ]
  ]

personal : List (Html Model)
personal =
  [
    button [ onClick Server ] [ text "Server" ],
    button [ onClick Home ] [ text "Home usage" ]
  ]

home : List (Html Model)
home =
  [
    button [ onClick Newbie ] [ text "New Linux user" ],
    button [ onClick Pro ] [ text "Proficient Linux user" ]
  ]

company : List (Html a)
company = [ genLink "RHEL", br [] [], genLink "SLES", br [] [], genLink "Ubuntu" ]

server : List (Html a)
server = [ genLink "Debian" ]

newbie : List (Html a)
newbie = [ genLink "Manjaro Linux" ]

pro : List (Html a)
pro = [ genLink "Arch Linux" ]

genLink : String -> Html a
genLink x = Html.a [ href (getLink x) ] [ text x ]

getLink : String -> String
getLink x = case Dict.get x links of
  Just url -> url
  Nothing -> ""

links : Dict.Dict String String
links =
  Dict.fromList [
    ("Debian", "https://www.debian.org/"),
    ("Arch Linux", "https://www.archlinux.org/"),
    ("Manjaro Linux", "https://manjaro.org/"),
    ("SLES", "https://www.suse.com/products/server/"),
    ("RHEL", "https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux"),
    ("Ubuntu", "https://www.ubuntu.com/")
  ]
