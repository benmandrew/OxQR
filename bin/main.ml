open Oxqr

let () =
  let qr_code = Encoding.generate "HELLO WORLD" Config.ECL.M in
  Printf.printf "%s\n" qr_code
