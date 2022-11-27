// CONTROLLER LIBRARIES
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

Utils utils = new Utils();

// SOUND LIBRARY
import processing.sound.*;

// GRAPHICS RELATED VARIABLES
int fpsFontSize = 20;

// GAME INSTANCES
Game game;
Level[] levels;

// CONTROLLER
ControlDevice controller;

// SOUND
SinOsc[] sineWaves;
int numSines = 2;
float[] sineVolume;
// float volume = (1.0 / numSines);
float volume = 0.2;


void setup() {
    // GRAPHICS SETUP
    size(600, 600);
    // fullScreen();
    noFill();
    textSize(fpsFontSize);


    // CONTROLLER SETUP
    controller = ControlIO.getInstance(this).filter(GCP.STICK).getMatchedDevice("dualsense");
    if (controller == null) {
        println("No suitable device configured");
        // System.exit(-1); // End the program NOW!
    }
    
    // Setup a function to trap events for this button
    controller.getButton("circle").plug(this, "circlePressed", ControlIO.ON_RELEASE);

    // SOUND SETUP
    sineWaves = new SinOsc[numSines];
    sineVolume = new float[numSines];
    for (int i = 0; i < numSines; i++) {
        // The overall amplitude shouldn't exceed 1.0 which is prevented by 1.0/numSines.
        // The ascending waves will get lower in volume the higher the frequency.
        sineVolume[i] = volume / (i + 1);

        // Create the Sine Oscillators and start them
        sineWaves[i] = new SinOsc(this);
        //sineWaves[i].play();
    }

    // GAME INSTANCES
    game = new Game(controller);
}


void draw() {
    if (! game.getLevels()[game.getCurrentLevel() - 1].hasBeenSetUp()) {
        game.getLevels()[game.getCurrentLevel() - 1].setupLevel();
    }

    if (! game.getLevels()[game.getCurrentLevel() - 1].isComplete()) {
        game.getLevels()[game.getCurrentLevel() - 1].drawLevel();
    }
    else {
        levelComplete();
    }
    
    // SOUND
    /*
    float frequency = pow(700, map(layer1.getDistanceToOrigin(), 0, 848, 0, 1)) + 300;
    // float frequency = 200;
    float detune = map(layer1.getDistanceToOrigin() + layer2.getDistanceToOrigin(), 0, 1500, 0.5, 10);
    

    // Set the frequencies, detuning and volume
    for (int i = 0; i < numSines; i++) { 
        sineWaves[i].freq(frequency * (i + 1 + i * detune));
        sineWaves[i].amp(sineVolume[i]);
    }
    */

    // FPS COUNTER
    blendMode(BLEND);
    text((int)frameRate, 0, 20);
}


void circlePressed() {
    game.getLevels()[game.getCurrentLevel() - 1].circleButtonPressed();
}


void levelComplete() {
    background(0, 0, 0);
    text("LEVEL COMPLETE", width / 2, height / 2);
    delay(5000);

    if (game.getCurrentLevel() == game.getLevelQuantity()) {
        game.markFinished();
    }

    if (game.isFinished()) {
        background(0, 0, 0);
        text("THANKS FOR PLAYING", width / 2, height / 2);
        delay(5000);
        System.exit(-1); // End the program
    }
    else {
        game.nextLevel();
    }
}

/*
void keyPressed() {

        // UP
        if (keyCode == 38) {
        }
        
        // DOWN
        else if (keyCode == 40) {
        }
        
        // LEFT
        else if (keyCode == 37) {
        }
        
        // RIGHT
        else if (keyCode == 39) {
        }
        
        // Z
        else if (keyCode == 90) {
        }
        
        // S
        else if (keyCode == 83) {
        }
            
        // Q
        else if (keyCode == 81) {
        }
        
        // D
        else if (keyCode == 68) {
        }

    println(keyCode);
}
*/
