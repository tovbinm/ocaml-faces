/* File : faces.c */
#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include <cctype>
#include <iostream>
#include <iterator>
#include <stdio.h>

#include "faces.h"

using namespace std;
using namespace cv;

/* Some global variables */
double Scale = 1.0;
string CascadeName = "./faces/haarcascades/haarcascade_frontalface_alt.xml";
string NestedCascadeName = "./faces/haarcascades/haarcascade_eye_tree_eyeglasses.xml";
CascadeClassifier cascade, nestedCascade;

int init() {
  if( !nestedCascade.load( NestedCascadeName ) )
      cerr << "WARNING: Could not load classifier cascade for nested objects from path "
           << NestedCascadeName << endl;

  if( !cascade.load( CascadeName ) ) {
      cerr << "ERROR: Could not load classifier cascade from path "
           << CascadeName << endl;
      return -1;
  }
  return 0;
}

vector<Face> detectFaces(Mat& image, bool isGrayscale, vector<Face>& faces) {
  double t = 0;
  vector<Rect> res;
  Mat smallImg( cvRound (image.rows/Scale), cvRound(image.cols/Scale), CV_8UC1 );

  printf( "INFO: processing image width=%d,height=%d,type=%d\n",
          image.size().width, image.size().height, image.type() );

  if (!isGrayscale) {
    Mat gray;
    cvtColor( image, gray, CV_BGR2GRAY );
    resize( gray, smallImg, smallImg.size(), 0, 0, INTER_LINEAR );
  } else {
    resize( image, smallImg, smallImg.size(), 0, 0, INTER_LINEAR );
  }
  equalizeHist( smallImg, smallImg );

  t = (double)cvGetTickCount();
   cascade.detectMultiScale( smallImg, res,
        1.1, 2, 0
        //|CV_HAAR_FIND_BIGGEST_OBJECT
        //|CV_HAAR_DO_ROUGH_SEARCH
        |CV_HAAR_SCALE_IMAGE
        ,
        Size(30, 30) );

  t = (double)cvGetTickCount() - t;
  printf( "INFO: face detection time = %gms. detected: %d face(s)\n",
          t/((double)cvGetTickFrequency()*1000.),
          res.size() );

  for( vector<Rect>::const_iterator r = res.begin(); r != res.end(); r++ ) {
      Face face(cvRound((r->x + r->width*0.5)*Scale),
                cvRound((r->y + r->height*0.5)*Scale),
                cvRound(r->x*Scale),
                cvRound(r->y*Scale),
                cvRound((r->x + r->width-1)*Scale),
                cvRound((r->y + r->height-1)*Scale));

      faces.push_back(face);
      printf("INFO: face detected centerX=%d,centerY=%d\n",
             face.centerX(), face.centerY());
  }
  return faces;
}

vector<Face> detectFacesImg(char* image, int n) {
  vector<Face> faces;
  vector<unsigned char> v;
  for ( unsigned int i = 0; i < n; i++ ) {
      v.push_back( image[ i ] );
  }
  Mat buf( v, false );
  Mat img = imdecode(buf, CV_LOAD_IMAGE_COLOR);

  return detectFaces(img, false, faces);
}

vector<Face> detectFacesFile(string imageName) {
  vector<Face> faces;
  if( imageName.empty() ) {
     cout << "ERROR: Couldn't read image: imageName is empty." << endl;
     return faces;
  }
  Mat image = imread( imageName, CV_LOAD_IMAGE_GRAYSCALE );
  if( image.empty() ) {
     cout << "ERROR: Couldn't read image " << imageName << endl;
     return faces;
  }
  return detectFaces(image, true, faces);
}


