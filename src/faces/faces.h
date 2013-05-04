/* File : faces.h */

class Face {
private:
  int cX, cY, crX, crY, opX, opY;
public:
  //Ctor
  Face(int centerX = 0, int centerY = 0,
       int cornerX = 0, int cornerY = 0,
       int oppositeX = 0, int oppositeY = 0) {
      cX = centerX;
      cY = centerY;
      crX = cornerX;
      crY = cornerY;
      opX = oppositeX;
      opY = oppositeY;
  }
  // Extractors
  int centerX() { return cX; }
  int centerY() { return cY; }
  int cornerX() { return crX; }
  int cornerY() { return crY; }
  int oppositeX() { return opX; }
  int oppositeY() { return opY; }
};
