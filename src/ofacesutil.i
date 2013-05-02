/* File : ofacesutil.i */
%module ofacesutil

%inline %{
extern int    gcd(int x, int y);
extern double Foo;
%}

