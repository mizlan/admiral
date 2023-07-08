open Admiral
open Sqlite3
open Cmdliner

let cmds =
  let mark_cmd =
    let mark path =
      let& db = db_open "admiral.sqlite3" in
      let _ = Db.create_table db in
      if Rc.is_success (Db.mark db path) then prerr_string "marked"
      else prerr_string "failed"
    in
    let path =
      Arg.(required & pos 0 (Arg.some string) None & info [] ~doc:"bruh")
    in
    let info = Cmd.info "mark" in
    Cmd.v info Term.(const mark $ path)
  in

  let clean_cmd =
    let clean () =
      let& db = db_open "admiral.sqlite3" in
      let _ = Db.create_table db in
      if Rc.is_success (Db.mark db "hi") then prerr_string "marked"
      else prerr_string "failed"
    in
    let info = Cmd.info "clean" in
    Cmd.v info Term.(const clean $ const ())
  in

  Cmd.group (Cmd.info "admiral") [ mark_cmd; clean_cmd ]

let main () = exit (Cmd.eval cmds)
let () = print_float (Admiral.Ffi.rank' "a/b/c" ["a"; "b"])
let () = main ()
