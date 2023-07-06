open Admiral
open Sqlite3

let () =
  let& db = db_open "admiral.sqlite3" in
  let _ = Db.create_table db in
  let r = Db.mark db "chagrin" in
  if not (Rc.is_success r) then (
    prerr_endline "errored:";
    prerr_endline (Rc.to_string r);
    prerr_endline (errmsg db))
