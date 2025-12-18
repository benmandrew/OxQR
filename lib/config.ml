module ErrorCorrectionLevel = struct
  type t = L | M | Q | H

  let compare e1 e2 =
    let to_int = function L -> 0 | M -> 1 | Q -> 2 | H -> 3 in
    compare (to_int e1) (to_int e2)
end

module Config = struct
  type t = { version : int; ecl : ErrorCorrectionLevel.t }

  let compare c1 c2 =
    let ver_cmp = Int.compare c1.version c2.version in
    if ver_cmp <> 0 then ver_cmp else ErrorCorrectionLevel.compare c1.ecl c2.ecl
end
