import processing.sound.*;

SoundFile ambientAudio;
SoundFile btnHoverSound;

Cover cover;
Canvas canvas;
MouseTracker mouseTracker;
Button button;
int i = 0;

void setup() {
    size(1080, 800);

    // float x = width * 0.5;
    // float y = height * 0.5;
    // float w = width * 0.7;
    // float h = height * 0.6;

    // canvas = new Canvas(x, y, w, h);

    ambientAudio = new SoundFile(this, "../sound/ambient.wav");
    ambientAudio.play();
    
    btnHoverSound = new SoundFile(this, "../sound/selection_item.wav");
    button = new Button();
    button.setHoverSound(btnHoverSound);
}

void draw() {
    Cover cover = new Cover();
    cover.draw();
    
    button.draw();
    
    

    // MouseTracker m = new MouseTracker();
    // m.draw();
}
