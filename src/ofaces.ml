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

let cascade_name () = _CascadeName '() as string
let set_cascade_name v = let _ = _CascadeName '((v to string)) in ()

let nested_nascade_name () = _NestedCascadeName '() as string
let set_nested_nascade_name v = let _ = _NestedCascadeName '((v to string)) in ()

let init () =
    let _ = _init '() in
    ()

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

let detect_faces image_name =
    let v = new_FaceVector (_detectFaces '((image_name to string))) in
    let f = Array.make ((v -> size()) as int) default_face in
    let _ = vector_to_array v to_face f in
    Array.to_list f
