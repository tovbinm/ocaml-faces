ocaml-faces
=========

OCaml library for face detection using OpenCV


Requirements
------------
- `swig >=2.0.x` @ `http://www.swig.org/`
- `opencv >=2.4.5` @ `http://opencv.willowgarage.com/wiki/`
- `oasis >=0.3` @ `http://oasis.forge.ocamlcore.org/` - optional


*** On Mac OSX:

```
brew update
brew install opam python swig
opam update && opam install oasis
brew tap homebrew/science
pip install numpy
brew install opencv
```

*** On Debian:

```
sudo -i
wget http://sourceforge.net/projects/swig/files/swig/swig-2.0.9/swig-2.0.9.tar.gz
tar -xvzf swig-2.0.9.tar.gz && cd swig-2.0.9
./configure && make && make install
apt-get install libopencv-*
touch /dev/raw1394 && chmod a+rw /dev/raw1394
```


Installation
------------

```
ocaml setup.ml -configure
ocaml setup.ml -build
ocaml setup.ml -install
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
