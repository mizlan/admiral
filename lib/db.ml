open Sqlite3

let drop_table db =
  let drop_table_sql = "DROP TABLE IF EXISTS files;" in
  exec db drop_table_sql

let create_table db =
  let create_table_sql =
    "CREATE TABLE IF NOT EXISTS files ( \
      id INTEGER PRIMARY KEY, \
      path TEXT NOT NULL UNIQUE, \
      count INTEGER NOT NULL DEFAULT 1, \
      last_access TIMESTAMP NOT NULL \
    );" [@ocamlformat "disable"]
  in
  exec db create_table_sql

let mark db (path : string) =
  let mark_sql =
    "INSERT INTO files(path, last_access) VALUES(?, strftime('%s','now')) \
      ON CONFLICT(path) DO UPDATE SET \
        count=count+1, \
        last_access=strftime('%s','now')" [@ocamlformat "disable"]
  in
  let stmt = prepare db mark_sql in
  match bind_text stmt 1 path with Rc.OK -> step stmt | r -> r
