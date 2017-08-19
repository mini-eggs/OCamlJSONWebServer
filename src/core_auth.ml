open Jwt
open Yojson
open Core

let default_header = `Assoc [
  ("alg", `String "HS256") ;
  ("typ", `String "JWT")
]

let token_of_user_id user_id =
  let time_string = Time.now ()
    |> Time.to_string in
  let token_json = `Assoc [
    ("time", `String time_string) ;
    ("user_id", `String user_id)
  ] in
  let header = header_of_json default_header in
  let payload = payload_of_json token_json in
  t_of_header_and_payload header payload
    |> token_of_t

let user_id_of_token token_string =
  t_of_token token_string
    |> payload_of_t
    |> string_of_payload
    |> Basic.from_string
    |> Basic.Util.member "user_id"
    |> Basic.Util.to_string
