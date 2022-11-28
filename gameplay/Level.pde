class Level {
    Map levelParams;
    int levelID;
    int layerQuantity;
    Polygon[] layers;
    boolean hasColor;
    float totalDistanceToOrigin;
    int circleButtonPressedCount;
    int layerToControl;
    float sumOfLayersRotations;
    float sumOfLayersScalesDifferences;
    boolean hasBeenSetUp;
    boolean isComplete;
    ControlDevice controller;
    PApplet parentPApplet; // needed for sound library
    int numSines;
    float volume;
    SinOsc[] sineWaves;
    float[] sineVolume;


    Level(Map levelParams, ControlDevice controller, PApplet parentPApplet) {
        this.levelParams = levelParams;
        this.levelID = (int)levelParams.get("ID");
        this.layerQuantity = (int)levelParams.get("layerQuantity");
        this.layers = new Polygon[layerQuantity + 1]; // +1 because layers[0] = background
        this.hasColor = (boolean)levelParams.get("hasColor");
        this.circleButtonPressedCount = 0;
        this.layerToControl = 1;
        this.hasBeenSetUp = false;
        this.isComplete = false;
        this.controller = controller;
        this.parentPApplet = parentPApplet;
        this.numSines = 2;
        this.volume = (1.0 / this.numSines);
        this.sineWaves = new SinOsc[numSines];
        this.sineVolume = new float[numSines];
        instanciateLayers();
    }

    void instanciateLayers() {
        for (int i = 0; i <= layerQuantity; i++) {
            this.layers[i] = new Polygon(levelParams);
        }
    }

    boolean isComplete() {
        return isComplete;
    }

    void circleButtonPressed() {
        this.circleButtonPressedCount += 1;
        updateLayerToControl();
        if (hasColor && layerQuantity > 1) {
            this.layers[getLayerToControl() - 1].setStrokeColor(utils.generateRandomColor());
            selectionClap.play();
        }
    }

    int getLayerToControl() {
        return layerToControl;
    }

    void updateLayerToControl() {
        this.layerToControl = (circleButtonPressedCount % layerQuantity) + 1;
    }

    boolean hasBeenSetUp() {
        return hasBeenSetUp;
    }

    void setupLevel() {
        println("--------");
        println("LEVEL", game.getCurrentLevel());

        // BACKGROUND STATIC LAYER
        layers[0].init(false);
        
        // DYNAMIC LAYERS
        for (int i = 1; i <= layerQuantity; i++) {
            layers[i].init(this.hasColor);
        }

        // SOUND SETUP
        // int numSines = 2;
        // float volume = (1.0 / numSines);
        // SinOsc[] sineWaves = new SinOsc[numSines];
        // float[] sineVolume = new float[numSines];
        //SinOsc lfo = new SinOsc();
        for (int i = 0; i < this.numSines; i++) {
            // The overall amplitude shouldn't exceed 1.0 which is prevented by 1.0/numSines.
            // The ascending waves will get lower in volume the higher the frequency.
            this.sineVolume[i] = this.volume / (i + 1);

            // Create the Sine Oscillators and start them
            this.sineWaves[i] = new SinOsc(this.parentPApplet);
            //this.sineWaves[i].play();
        }

        ambiantSound.loop();

        this.hasBeenSetUp = true;
    }

    boolean checkIfComplete() {
        if ((totalDistanceToOrigin < layerQuantity) &&
            (sumOfLayersRotations < layerQuantity) &&
            (sumOfLayersScalesDifferences < ((float)layerQuantity / 10))
        ) {
            println("Level", game.getCurrentLevel(), "finished", frameCount);
            return true;
        }
        else {
            return false;
        }
    }

    void drawLevel() {
        this.totalDistanceToOrigin = 0;
        this.sumOfLayersRotations = 0;
        this.sumOfLayersScalesDifferences = 0;

        background(100, 100, 100);
        rectMode(CENTER);

        // STATIC BACKGROUND LAYER
        blendMode(BLEND);
        this.layers[0].draw();

        // DYNAMIC LAYERS
        if (this.hasColor) {
            blendMode(DIFFERENCE);
        }
        else {
            blendMode(BLEND);
        }

        for(int i=1; i <= this.layerQuantity; i++) {
            if (this.layerToControl == i) {
                layers[i].updatePosition(controller);
            }

            this.layers[i].draw();

            layers[i].computeDistanceToOrigin(layers[0].getPositionX(), layers[0].getPositionY());
            layers[i].computeRotationToBackground(layers[0].getRotation());
            layers[i].computeScaleToBackground(layers[0].getScale());
            

            // ROTATION CLAP SOUND
            if ((layers[i].getRotationToBackground() < 1) && (! layers[i].rotationClapPlayed)) {
                rotationClap.play();
                layers[i].rotationClapPlayed = true;
            }
            if (layers[i].getRotationToBackground() > 1) {
                layers[i].rotationClapPlayed = false;
            }

            // SCALE CLAP SOUND
            if ((layers[i].getScaleToBackground() < 0.1) && (! layers[i].scaleClapPlayed)) {
                scaleClap.play();
                layers[i].scaleClapPlayed = true;
            }
            if (layers[i].getScaleToBackground() > 0.1) {
                layers[i].scaleClapPlayed = false;
            }


            this.totalDistanceToOrigin += layers[i].getDistanceToOrigin();
            this.sumOfLayersRotations += layers[i].getRotationToBackground();
            this.sumOfLayersScalesDifferences += (layers[i].getScaleToBackground());
        }

        // CONTINUOUS SOUND RELATED TO SHAPES DISTANCES TO ORIGIN
        float frequency = pow(300, map(this.totalDistanceToOrigin, 0, 848, 0, 1)) + 150;
        // float frequency = 200;
        float detune = map(this.totalDistanceToOrigin, 0, 1500, 0.5, 10);
        

        // Set the frequencies, detuning and volume
        for (int i = 0; i < this.numSines; i++) { 
            // this.sineWaves[i].freq(frequency * (i + 1 + i * detune));
            // sineWaves[i].amp(sineVolume[i]);
            // this.sineWaves[i].amp(cos(second()));
            //this.sineWaves[i].freq(frequency * cos(millis()) + 0.5);
        }

        this.isComplete = checkIfComplete();
    }

    void levelComplete() {
        ambiantSound.stop();
    }
}