open Swig
open Ofacesutil

exception NoReturn

type face = {
  centerX : int;
  centerY : int;
  cornerX : int;
  cornerY : int;
  oppositeX : int;
  oppositeY : int;
}

let scale () = _Scale '() as float
let set_scale v = let _ = _Scale '((v to float)) in ()

let min_size () = _MinSize '() as int
let set_min_size v = let _ = _MinSize '((v to int)) in ()

let cascade_name () = _CascadeName '() as string
let set_cascade_name v = let _ = _CascadeName '((v to string)) in ()

let nested_nascade_name () = _NestedCascadeName '() as string
let set_nested_nascade_name v = let _ = _NestedCascadeName '((v to string)) in ()

let init () =
    (_init '()) as int

let default_face =
  { centerX = 0;
    centerY = 0;
    cornerX = 0;
    cornerY = 0;
    oppositeX = 0;
    oppositeY = 0; }

let to_face f =
  { centerX = (f -> centerX ()) as int;
    centerY = (f -> centerY ()) as int;
    cornerX = (f -> cornerX ()) as int;
    cornerY = (f -> cornerY ()) as int;
    oppositeX = (f -> oppositeX ()) as int;
    oppositeY = (f -> oppositeY ()) as int;
  }

let to_faces faces =
    let f = Array.make ((faces -> size()) as int) default_face in
    let _ = vector_to_array faces to_face f in
    Array.to_list f

let detect_faces_file image_name =
    let v = new_FaceVector (_detectFacesFile '((image_name to string))) in
    to_faces v

let detect_faces_img image n =
    let v = new_FaceVector (_detectFacesImg '((C_string image), (n to int))) in
    to_faces v
