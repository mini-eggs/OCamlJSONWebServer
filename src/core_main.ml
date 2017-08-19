open Core
open Async
open Cohttp_async

open Core_routes

let start_server port () =
  eprintf "Listening on port %d\n" port;
  let portTCP = Tcp.on_port port in
  let server = Cohttp_async.Server.create ~on_handler_error:`Raise portTCP handle in
  server >>= fun _ -> Deferred.never ()

let () =
  Command.async ~summary:"A simple web server"
    Command.Spec.(empty +>
      flag "-port" (optional_with_default 8080 int) ~doc:"port to listen on"
    ) start_server
  |> Command.run