Cover cover;
Canvas canvas;
MouseTracker mouseTracker;

void setup() {
    size(1080, 800);

    float x = width * 0.5;
    float y = height * 0.5;
    float w = width * 0.7;
    float h = height * 0.6;

    canvas = new Canvas(x, y, w, h);
}

void draw() {
    mouseTracker = new MouseTracker();
    mouseTracker.draw();

    canvas.draw();
}
