open Core
open Async
open Cohttp_async
open Yojson

open Api_create_token

let home () = 
  Server.respond_string ~status:`OK "Hello from Pesto's house. :D"

let not_found () = 
  Server.respond_string ~status:`Not_found "404, not found"

let serve_file resource_name =
  let full_resource_name = "public/" ^ resource_name in
  Server.respond_with_file full_resource_name

let get_handle ( req : Request.t) =
  match req.resource with
    | "/" -> home ()
    | _ -> serve_file req.resource
    
let post_handle ( req : Request.t ) body = 
  match req.resource with
  | "/create-token" -> api_create_token req body
  | _ -> not_found ()
  
let handle ~body:body _sock ( req : Request.t ) =
  match req.meth with
  | `GET -> get_handle req
  | `POST -> post_handle req body
  | _ -> not_found ()
    