/* File : ofacesutil.i */
%module ofacesutil

%include stl.i
%{
#include "faces/faces.h"
%}

class Face {
public:
        Face(int centerX, int centerY,
             int cornerX, int cornerY,
             int oppositeX, int oppositeY);
        int centerX();
        int centerY();
        int cornerX();
        int cornerY();
        int oppositeX();
        int oppositeY();
};

%template(FaceVector) std::vector<Face>;

%inline %{
extern double Scale;
extern std::string CascadeName;
extern std::string NestedCascadeName;
extern void init();
extern std::vector<Face> detectFaces(std::string imageName);
%}

