module Arena : sig
  type t

  val create : unit -> t
  val get_qr_buffer : local_ t -> local_ Bytes.t
end

val encode : Arena.t -> string -> Config.ECL.t -> int
(** [encode arena data ecl] encodes the given [data] string into the QR code
    structure stored in [arena] with error correction level [ecl]. *)

val generate_qr : Arena.t -> string -> Config.ECL.t -> Qr.t
(** [generate arena data ecl] generates a QR code matrix for the given [data]
    string and error correction level [ecl]. Returns a QR code matrix ready to
    be rendered. *)
