// CONTROLLER LIBRARIES
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

Utils utils = new Utils();

// SOUND LIBRARY
import processing.sound.*;
SoundFile rotationClap;
SoundFile scaleClap;
SoundFile selectionClap;
SoundFile ambiantSound;

// TEST AUDIO LIBRARY BEADS
import beads.*;
import java.util.Arrays; 
AudioContext ac;
// String rotationClapPath;

// GRAPHICS RELATED VARIABLES
int fpsFontSize = 20;

// GAME INSTANCES
Game game;

// CONTROLLER
ControlDevice controller;


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
    rotationClap = new SoundFile(this, "rotationClap.wav");
    scaleClap = new SoundFile(this, "scaleClap.wav");
    selectionClap = new SoundFile(this, "selectionClap.wav");
    ambiantSound = new SoundFile(this, "ambiant.wav");

    // BEADS SETUP
    // rotationClapPath = sketchPath("") + "data/rotationClap.wav";



    // GAME INSTANCE
    game = new Game(controller, this);
}


void draw() {
    if (! game.getLevels()[game.getCurrentLevel() - 1].hasBeenSetUp()) {
        game.getLevels()[game.getCurrentLevel() - 1].setupLevel();
    }

    if (! game.getLevels()[game.getCurrentLevel() - 1].isComplete()) {
        game.getLevels()[game.getCurrentLevel() - 1].drawLevel();
    }
    else {
        game.levelComplete();
    }
    

    // SOUND
    // float frequency = pow(700, map(layer1.getDistanceToOrigin(), 0, 848, 0, 1)) + 300;
    // // float frequency = 200;
    // float detune = map(layer1.getDistanceToOrigin() + layer2.getDistanceToOrigin(), 0, 1500, 0.5, 10);
    

    // // Set the frequencies, detuning and volume
    // for (int i = 0; i < numSines; i++) { 
    //     sineWaves[i].freq(frequency * (i + 1 + i * detune));
    //     sineWaves[i].amp(sineVolume[i]);
    // }


    // FPS COUNTER
    blendMode(BLEND);
    text((int)frameRate, 0, 20);
}


void circlePressed() {
    game.getLevels()[game.getCurrentLevel() - 1].circleButtonPressed();
}
