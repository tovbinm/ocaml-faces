(* example_prog.ml *)

open Swig
open Ofacesutil

exception NoReturn


let gcd x y =
    _gcd '((x to int),(y to int)) as int

let foo () =
    _Foo '() as float

