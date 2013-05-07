
type face = {
  centerX : int;
  centerY : int;
  cornerX : int;
  cornerY : int;
  oppositeX : int;
  oppositeY : int;
}

val scale : unit -> float
val set_scale : float -> unit

val cascade_name : unit -> string
val set_cascade_name : string -> unit

val nested_nascade_name : unit -> string
val set_nested_nascade_name : string -> unit

val init : unit -> int
val detect_faces_file: string -> face list
val detect_faces_img: string -> int -> face list
