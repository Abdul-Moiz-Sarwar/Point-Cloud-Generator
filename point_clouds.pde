import nervoussystem.obj.*;
boolean record = false;
PImage img;       // The source image
int cellsize = 2; // Dimensions of each cell in the grid
int cols, rows;   // Number of columns and rows in our system
int count = 0;

void setup() {
  size(1024, 1024, P3D);
  img  = loadImage("10.png"); // Load the image
  cols = width/cellsize;             // Calculate # of columns
  rows = height/cellsize;            // Calculate # of rows
}

void draw() {
  if(record) {
    save("1.tiff");
    beginRecord("nervoussystem.obj.OBJExport", "1.obj"); 
  }
  background(0);
  loadPixels();
  if(key == 'a'){
    count += 50;
  }
  else if(key == 'd'){
    count -= 50;
  }
  else if(key == 'r'){
    count = 0;
  }
  // Begin loop for columns
  for ( int i = 0; i < cols;i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows;j++) {
      int x = i*cellsize + cellsize/2; // x position
      int y = j*cellsize + cellsize/2; // y position
      int loc = x + y*width;           // Pixel array location
      color c = img.pixels[loc];       // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (1000/(float)width) * (0.9*brightness(img.pixels[loc])) - 300;
      float rx = (mouseX/(float)(0.2*width)) * (0.9*brightness(img.pixels[loc]))/100.0;
      float ry = (mouseY/(float)(0.2*height)) * (0.9*brightness(img.pixels[loc]))/100.0;
      // Translate to the location, set fill and stroke, and draw the rect
      fill(c);
      noStroke();
      rectMode(CENTER);
      
      pushMatrix();
      //translate(-width/2,-height/2);
      //rotateY(rx);
      //rotateX(ry);
      translate(width/2,height/2,count+50);
      //rotateX(2.2 + (-mouseY/(float)200));
      //rotateY(-2.2 + (mouseX/(float)200));
      translate(x,y,z-300);
      //sphere(cellsize/2);
      rect(-width/2,-height/2,cellsize,cellsize);
      popMatrix();
      
      
    }
    
    
    
  }
  if(record) {
    endRecord();
    record = false;
  }
}



void keyPressed() {
  if(key == 's' || key == 'S') {
    record = true;
  }
}
