import processing.video.*;

Capture video;
CellularAutomata cellAut = null;

void setup() {
  size(640, 480, P2D);
  video = new Capture(this, width, height);
  noStroke();
}

void draw() {
  if (cellAut != null) {
    cellAut.evolve();
    cellAut.drawGrid();
  } else {
    video.start();
    if (video.available()) {
      video.read();
      image(video, 0, 0);
    }
  }
}

int[][] getBlackAndWhiteImg(int threshold, PImage img) {
  int[][] bw_values = new int[img.width][img.height];

  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {

      float pixelBrightness = brightness(img.pixels[(y * img.width) + x]);
      if (pixelBrightness > threshold) {
        bw_values[x][y] = 0;
      } 
      else {
        bw_values[x][y] = 1;
      }
    }
  }

  return bw_values;
}

void keyPressed() {
  if (key == 'c' || key == 'm') {
    int[][] img_blackAndWhite = getBlackAndWhiteImg(122, video);
    cellAut = key == 'c' ? new ConwayLife(img_blackAndWhite, 1, 1) : new MyCellularAutomata(img_blackAndWhite, 1, 1);
    cellAut.drawGrid();
  } else if(key == 's') {
    saveFrame();
  }
}

void mousePressed() {
  cellAut = null;
}
