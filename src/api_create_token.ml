open Core
open Async
open Cohttp_async
open Yojson

open Core_auth

let api_create_token _req body =
  Body.to_string body >>= fun body_string ->
    try 
      let token = body_string
        |> Basic.from_string
        |> Basic.Util.member "id"
        |> Yojson.Basic.Util.to_string
        |> token_of_user_id in
      let return_string = `Assoc [
        ( "data", `String token ) ;
        ( "message", `String "Token has been created." ) ;
        ( "status", `Bool true )
      ] |> Basic.pretty_to_string in
      Server.respond_string ~status:`OK return_string 
    with _error ->
      let return_string = `Assoc [
        ( "message", `String "Missing ID parameter." ) ;
        ( "status", `Bool false )
      ] |> Basic.pretty_to_string in
      Server.respond_string ~status:`OK return_string
