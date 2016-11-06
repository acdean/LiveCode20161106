import peasy.*;

PeasyCam cam;
PShape shape;
boolean video = true;

int SHAPES = 10;
float SEPARATION = 200;
float SZ = 60;
float xoff = SZ * (.866 * 2);
float yoff = SZ * 1.5;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 500);
  shape = createShape();
  shape.beginShape(LINES);
  shape.strokeWeight(3);
  shape.stroke(255, 0, 0);
  shape.noFill();
  int range = 20;
  for (int y = -range ; y < range ; y++) {
    float y0 = y * yoff;
    for (int x = -range ; x < range ; x++) {
      float x0 = x;
      if ((y + 100) % 2 == 0) {
        x0 = x + .5;
      }
      x0 *= xoff;
      if (sq(x0) + sq(y0) < sq(2000)) {
        // add a hexagon
        for (int i = 0 ; i < 6 ; i++) {
          float a1 = TWO_PI * i / 6;
          float a2 = TWO_PI * (i + 1) / 6;
          shape.vertex(x0 + SZ * sin(a1), y0 + SZ * cos(a1));
          shape.vertex(x0 + SZ * sin(a2), y0 + SZ * cos(a2));
        }
      }
    }
  }
  shape.endShape();
  colorMode(HSB, SHAPES, 100, 100);
  
  if (video) {
    saveFrame("frame#####.png");
    if (frameCount > 500) {
      exit();
    }
  }
}

void draw() {
  background(0, 0, 0);
  camera(50 * cos(radians(frameCount)), 50 * sin(radians(frameCount)), -500, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
  for (int i = 0 ; i < SHAPES ; i++) {
    pushMatrix();
    shape.setStroke(color(i, 100, 100));
    translate(0, 0, i * SEPARATION);
    shape(shape);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("snap####.png");
  }
}