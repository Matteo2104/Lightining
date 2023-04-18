float x, y;
float x_old, y_old;
float theta; 
float len_segment, max_len_segment;;
float deviation;
float center_distance;
float intensity;
int fade;

void setup() {
  fullScreen();
  background(0);
  stroke(255);
  strokeWeight(1.5);
  frameRate(200);
  
  x_old = 0;
  y_old = 0;
  
  max_len_segment = 3;
  deviation = 0.3;
  theta = 0;
  intensity = 0;
  fade = 0;
}

void draw() {
  translate(width/2, height/2);

  if (fade == 1 && !black()) {
    fade(0.98);
  } else if (fade == 1 && black()) {
    x_old = 0;
    y_old = 0;
    x = 0;
    y = 0;
    intensity = 0;
    fade = 0;
  } else {
    center_distance = sqrt(pow(x, 2) + pow(y, 2));
    theta = random(theta - deviation, theta + deviation);
    
    if (center_distance > 400) {
      fade = 1;
    }
    
    len_segment = random(max_len_segment);
    x = x_old + len_segment * cos(theta);
    y = y_old + len_segment * sin(theta);
    
    intensity++;
    stroke(255 * (1 - exp(-0.01 * intensity)));
    line(x_old, y_old, x, y);
    
    x_old = x;
    y_old = y;
  }
}

void fade(float speed) {
  int r, g, b;
  loadPixels();
  for (int i=0;i<pixels.length;i++) {
    r = int(red(pixels[i]) * speed);
    g = int(green(pixels[i]) * speed);
    b = int(blue(pixels[i]) * speed);
    
    pixels[i] = color(r, g, b);
  }
  updatePixels();
}

boolean black() {
  loadPixels();
  for (int i=0;i<pixels.length;i++) {
    if (int(red(pixels[i])) > 0) {
      return false;
    }
  }
  return true;
}
