open Core
open OUnit

open Core_auth
  
let test_create_token _ =
  let user_id_string = "47" in
  let token = token_of_user_id user_id_string in
  let user_id_from_token = user_id_of_token token in
  assert_equal user_id_from_token user_id_string


let suite = 
  "Home Server Test Suite" >::: [
    "test_create_token" >:: test_create_token
  ]
                                  
let _ = run_test_tt_main suite