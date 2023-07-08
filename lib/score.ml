open Ctypes
open PosixTypes
open Foreign

let rank' path tokens =
  let arr = (CArray.of_list string tokens) in
  C.Functions.rank path (CArray.start arr) (Unsigned.Size_t.of_int (CArray.length arr)) true false
