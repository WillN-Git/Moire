import processing.sound.*;

class Button {
    float rectX, rectY;      // Position of square button
    float rectWidth = 200, rectHeight = 90;     // Dimensions of rect
    color rectColor, baseColor;
    color rectHighlight;
    boolean rectOver = false;

    SoundFile hoverSound;
    int hoverSoundTrigger = 0;

    Button() {
        this.rectColor = color(0);
        this.rectHighlight = color(51);
        this.baseColor = color(102);

        this.rectX = width / 2;
        this.rectY = height / 2;
    }

    void draw() {
        if(isHover()) {
            fill(50);
            if(hoverSoundTrigger == 0) hoverSound.play();
            hoverSoundTrigger++;
        } else {
            hoverSoundTrigger = 0;
            fill(153);
        }
        
        stroke(this.rectColor);
        strokeWeight(5);
        rectMode(CENTER);
        rect(this.rectX, this.rectY, this.rectWidth, this.rectHeight, 20);

        fill(255);
        textSize(40);
        textAlign(CENTER, CENTER);
        text("Jouer", this.rectX, this.rectY * 0.99);
    }

    boolean isHover() {
        return (this.rectX - this.rectWidth / 2 <= mouseX && mouseX <= this.rectX + this.rectWidth) 
        && (this.rectY - this.rectHeight / 2 <= mouseY && mouseY <= this.rectY + this.rectHeight / 2);
    }

    void setHoverSound(SoundFile hoverSound) {
        this.hoverSound = hoverSound;
    }
}