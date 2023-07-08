open Ctypes

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  let rank = foreign "rank" (string @-> ptr string @-> size_t @-> bool @-> bool @-> returning double)
end
