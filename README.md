ocaml-faces
=========

OCaml library for face detection using OpenCV


Requirements
------------
- `swig` @ `http://www.swig.org/`
- `opencv` @ `http://opencv.willowgarage.com/wiki/`
- `oasis` @ `http://oasis.forge.ocamlcore.org/` - optional


*** On Mac OSX:

```
$ brew update
$ brew install opam
$ opam update && opam install oasis
$ brew tap homebrew/science
$ brew install python
$ pip install numpy
$ brew install opencv
$ brew install swig
```

*** On Debian:

```
$ wget http://sourceforge.net/projects/swig/files/swig/swig-2.0.9/swig-2.0.9.tar.gz
$ tar -xvzf swig-2.0.9.tar.gz && cd swig-2.0.9
$ ./configure && make && make install
```


Installation
------------

```
$ ocaml setup.ml -configure
$ ocaml setup.ml -build
$ ocaml setup.ml -install
```

Usage
------------

```
(* Intialize cascades (on app start) *)
Ofaces.init ();;
(* Detect some faces *)
let faces = Ofaces.detect_faces_file "pic.jpg" in
Printf.printf "Detected %d face(s)\n" (List.length faces);;
```
