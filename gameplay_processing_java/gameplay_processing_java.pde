// CONTROLLER LIBRARIES
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

// SOUND LIBRARY
import processing.sound.*;

// GRAPHICS RELATED VARIABLES
color backgroundColor = color(100, 100, 100);
int circleQuantity = 100;
int circleSpacing = 20;
int strokeWeight = 4;
color staticStrokeColor = color(0, 0, 0);
color layer1StrokeColor = color(255, 0, 0);
color layer2StrokeColor = color(0, 255, 0);
int fpsFontSize = 20;

// LAYERS RELATED VARIABLES
int windowSizeX = 600;
int windowSizeY = 600;
int originX = (int)(Math.random() * windowSizeX);
int originY = (int)(Math.random() * windowSizeY);
/*
Layer layer1 = new Layer();
Layer layer2 = new Layer();
layer1.getPositionX();
*/
float layer1PosX = (int)(Math.random() * (windowSizeX / 2));
float layer1PosY = (int)(Math.random() * (windowSizeY / 2));
float layer1DistanceToOrigin;
int layer2PosX = (int)(Math.random() * (windowSizeX / 2));
int layer2PosY = (int)(Math.random() * (windowSizeY / 2));
float layer2DistanceToOrigin;

// CONTROLLER
ControlIO control;
ControlDevice dualsense;
float joystickSpeed = 7.0;
float joystickDeadZone = 0.05;

// SOUND
SinOsc[] sineWaves;
int numSines = 2;
float[] sineVolume;
// float volume = (1.0 / numSines);
float volume = 0.01;


void setup() {
    // GRAPHICS SETUP
    size(600, 600);
    noFill();
    strokeWeight(strokeWeight);
    textSize(fpsFontSize);

    // CONTROLLER SETUP
    control = ControlIO.getInstance(this);
    dualsense = control.filter(GCP.STICK).getMatchedDevice("dualsense");
    if (dualsense == null) {
        println("No suitable device configured");
        // System.exit(-1); // End the program NOW!
    }

    // SOUND SETUP
    sineWaves = new SinOsc[numSines];
    sineVolume = new float[numSines];
    for (int i = 0; i < numSines; i++) {
        // The overall amplitude shouldn't exceed 1.0 which is prevented by 1.0/numSines.
        // The ascending waves will get lower in volume the higher the frequency.
        sineVolume[i] = volume / (i + 1);

        // Create the Sine Oscillators and start them
        sineWaves[i] = new SinOsc(this);
        sineWaves[i].play();
    }
}


void getUserInput() {
    /*
    println("-------------------------------------------------------------------");
    println("LEFT  | X :",dualsense.getSlider("leftJoyX").getValue(), "Y :", dualsense.getSlider("leftJoyY").getValue());
    println("RIGHT | X :",dualsense.getSlider("rightJoyX").getValue(), "Y :", dualsense.getSlider("rightJoyY").getValue());
    */

    if (abs(dualsense.getSlider("leftJoyX").getValue()) >= joystickDeadZone) {
        layer1PosX += dualsense.getSlider("leftJoyX").getValue() * joystickSpeed;
    }

    if (abs(dualsense.getSlider("leftJoyY").getValue()) >= joystickDeadZone) {
        layer1PosY += dualsense.getSlider("leftJoyY").getValue() * joystickSpeed;
    }

    if (abs(dualsense.getSlider("rightJoyX").getValue()) >= joystickDeadZone) {
        layer2PosX += dualsense.getSlider("rightJoyX").getValue() * joystickSpeed;
    }

    if (abs(dualsense.getSlider("rightJoyY").getValue()) >= joystickDeadZone) {
        layer2PosY += dualsense.getSlider("rightJoyY").getValue() * joystickSpeed;
    }
}


void draw() {
    getUserInput();

    if ((abs(originX - layer1PosX) < 1) && (abs(originY - layer1PosY) < 1) && (abs(originX - layer2PosX) < 1) && (abs(originY - layer2PosY) < 1)) {
        background(255, 255, 255);
    }
    else {
        background(backgroundColor);
    
        // STATIC LAYER
        blendMode(BLEND);
        stroke(staticStrokeColor);
        for (int i=0; i<circleQuantity; i++) {
            ellipse(originX, originY, (windowSizeX / 40) + (i * circleSpacing), (windowSizeY / 40) + (i * circleSpacing));
        }
    
        // LAYER 1
        pushMatrix();
        blendMode(DIFFERENCE);
        stroke(layer1StrokeColor);
        for (int i=0; i<circleQuantity; i++) {
            ellipse(layer1PosX, layer1PosY, (windowSizeX / 40) + (i * circleSpacing), (windowSizeY / 40) + (i * circleSpacing));
        }
        popMatrix();
    
        // LAYER 2
        pushMatrix();
        blendMode(DIFFERENCE);
        stroke(layer2StrokeColor);
        for (int i=0; i<circleQuantity; i++) {
            ellipse(layer2PosX, layer2PosY, (windowSizeX / 40) + (i * circleSpacing), (windowSizeY / 40) + (i * circleSpacing));
        }
        popMatrix();
        
        // SOUND
        layer1DistanceToOrigin = sqrt((int)(Math.pow(abs(originX - layer1PosX), 2)) + (int)(Math.pow(abs(originY - layer1PosY), 2)));
        layer2DistanceToOrigin = sqrt((int)(Math.pow(abs(originX - layer2PosX), 2)) + (int)(Math.pow(abs(originY - layer2PosY), 2)));
        // float frequency = pow(700, map(layer1DistanceToOrigin, 0, 848, 0, 1)) + 300;
        float frequency = 200;
        float detune = map(layer1DistanceToOrigin + layer2DistanceToOrigin, 0, 1500, 0.5, 10);
        /*
        println("layer1DistanceToOrigin : " + layer1DistanceToOrigin);
        println("layer2DistanceToOrigin : " + layer2DistanceToOrigin);
        println("frequency : " + frequency);
        println("detune : " + detune);
        */

        // Set the frequencies, detuning and volume
        for (int i = 0; i < numSines; i++) { 
            sineWaves[i].freq(frequency * (i + 1 + i * detune));
            sineWaves[i].amp(sineVolume[i]);
        }
    
        // FPS COUNTER
        blendMode(BLEND);
        text((int)frameRate, 0, 20);
    }
}


void layer1Up() {
    layer1PosY--;
}


void layer1Down() {
    layer1PosY++;
}


void layer1Left() {
    layer1PosX--;
}


void layer1Right() {
    layer1PosX++;
}


void layer2Up() {
    layer2PosY--;
}


void layer2Down() {
    layer2PosY++;
}


void layer2Left() {
    layer2PosX--;
}


void layer2Right() {
    layer2PosX++;
}


void keyPressed() {

        // UP
        if (keyCode == 38) {
            layer2Up();
        }
        
        // DOWN
        else if (keyCode == 40) {
            layer2Down();
        }
        
        // LEFT
        else if (keyCode == 37) {
            layer2Left();
        }
        
        // RIGHT
        else if (keyCode == 39) {
            layer2Right();
        }
        
        // Z
        else if (keyCode == 90) {
            layer1Up();
        }
        
        // S
        else if (keyCode == 83) {
            layer1Down();
        }
            
        // Q
        else if (keyCode == 81) {
            layer1Left();
        }
        
        // D
        else if (keyCode == 68) {
            layer1Right();
        }

    // println(keyCode);
}
