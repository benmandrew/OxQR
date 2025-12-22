(* Reed-Solomon error correction for QR codes *)

let generate_generator_polynomial n =
  (* Generate the generator polynomial for n error correction codewords *)
  let poly = Array.make (n + 1) 0 in
  poly.(0) <- 1;

  for i = 0 to n - 1 do
    (* Multiply by (x - α^i) *)
    for j = i + 1 downto 1 do
      poly.(j) <-
        Table.polynomial_mult poly.(j) Table.exp_table.(i) lxor poly.(j - 1)
    done;
    poly.(0) <- Table.polynomial_mult poly.(0) Table.exp_table.(i)
  done;

  poly

let generate_error_correction data ec_count =
  let data_len = Bytes.length data in
  let generator = generate_generator_polynomial ec_count in

  (* Initialize remainder with data codewords *)
  let remainder = Array.make ec_count 0 in

  (* Polynomial division *)
  for i = 0 to data_len - 1 do
    let coef = Char.code (Bytes.get data i) lxor remainder.(0) in

    (* Shift remainder *)
    Array.blit remainder 1 remainder 0 (ec_count - 1);
    remainder.(ec_count - 1) <- 0;

    (* Multiply generator polynomial by coef and XOR with remainder *)
    if coef <> 0 then
      for j = 0 to ec_count - 1 do
        remainder.(j) <-
          remainder.(j) lxor Table.polynomial_mult generator.(j) coef
      done
  done;

  (* Convert remainder to bytes *)
  let result = Bytes.create ec_count in
  for i = 0 to ec_count - 1 do
    Bytes.set result i (Char.chr remainder.(i))
  done;
  result
