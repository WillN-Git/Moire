class Level {
    Map levelParams;
    int levelID;
    int layerQuantity;
    Layer[] layers;
    int shapeSides;
    boolean hasColor;
    float totalDistanceToOrigin;
    int circleButtonPressedCount;
    int layerToControl;
    float sumOfLayersRotations;
    float sumOfLayersScalesDifferences;
    boolean hasBeenSetUp;
    boolean isComplete;
    ControlDevice controller;
    float radiusYMultiplier;

    // SOUND LIBRARY
    PApplet parentPApplet; // needed for sound library
    Sound master;

    // BEADS LIBRARY
    WavePlayer lfoFreq;
    WavePlayer lfoAmp;
    Function function;
    WavePlayer distanceSoundWave;
    Gain distanceSoundGain;

    Glide carrierFreq;
    Glide modFreqRatio;


    Level(Map levelParams, ControlDevice controller, PApplet parentPApplet) {
        this.levelParams = levelParams;
        this.levelID = (int)levelParams.get("ID");
        this.layerQuantity = (int)levelParams.get("layerQuantity");
        this.layers = new Layer[layerQuantity + 1]; // +1 because layers[0] = background
        this.shapeSides = (int)levelParams.get("shapeSides");
        this.hasColor = (boolean)levelParams.get("hasColor");
        this.circleButtonPressedCount = 0;
        this.layerToControl = 1;
        this.hasBeenSetUp = false;
        this.isComplete = false;
        this.controller = controller;
        this.parentPApplet = parentPApplet;
        this.master = new Sound(this.parentPApplet);
        initRadiusYMultiplier();
        instanciateLayers();
    }

    void initRadiusYMultiplier() {
        this.radiusYMultiplier = random(20);
    }

    void instanciateLayers() {
        for (int i = 0; i <= layerQuantity; i++) {
            if (this.shapeSides > 0) {
                // POLYGON
                this.layers[i] = new Polygon(levelParams);
            }
            else if (this.shapeSides == 0) {
                // ELLIPSE
                this.layers[i] = new Ellipse(levelParams, radiusYMultiplier);
            }
            else if (this.shapeSides == -1) {
                // CIRCLE
                this.layers[i] = new Ellipse(levelParams);
            }
            else {
                println("Please input a valid number of sides for your shapes in the LevelsParams.");
                System.exit(-1);
            }
        }
    }

    void initBeads() {
        // ac = AudioContext.getDefaultContext();
        // this.lfoFreq = new WavePlayer(1, Buffer.SINE);
        // this.lfoAmp = new WavePlayer(0.1, Buffer.SINE);

        // this.function = new Function(lfoFreq) {
        //     float calculate() {
        //         return x[0] * 50.0 + 200.0;
        //     }
        // };

        // this.distanceSoundWave = new WavePlayer(function, Buffer.SINE);
        // this.distanceSoundGain = new Gain(1, this.lfoAmp);
        // this.distanceSoundGain.addInput(this.distanceSoundWave);
        // ac.out.addInput(this.distanceSoundGain);
        // ac.start();


        ac = AudioContext.getDefaultContext();
        this.carrierFreq = new Glide(5);
        this.modFreqRatio = new Glide(1);
        Function modFreq = new Function(carrierFreq, modFreqRatio) {
            public float calculate() {
            return x[0] * x[1];
            }
        };
        WavePlayer freqModulator = new WavePlayer(modFreq, Buffer.SINE);
        Function carrierMod = new Function(freqModulator, carrierFreq) {
            public float calculate() {
            return x[0] * 400.0 + x[1];    
            }
        };
        this.distanceSoundWave = new WavePlayer(carrierMod, Buffer.SINE);
        this.distanceSoundGain = new Gain(1, 0.2);
        this.distanceSoundGain.addInput(this.distanceSoundWave);
        ac.out.addInput(this.distanceSoundGain);
        ac.start();

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
        master.volume(0.3);
        ambiantSound.loop();

        // DISTANCE SOUND INIT
        initBeads();

        this.hasBeenSetUp = true;
    }

    boolean checkIfComplete() {
        if ((totalDistanceToOrigin < layerQuantity) &&
            (sumOfLayersRotations < layerQuantity) &&
            (sumOfLayersScalesDifferences < ((float)layerQuantity / 10))
        ) {
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
        // BEADS LIBRARY
        // this.lfoFreq.setFrequency(map(this.totalDistanceToOrigin, 0, width * this.layerQuantity, 0.05, 3));
        // this.lfoAmp.setFrequency(map(this.totalDistanceToOrigin, 0, width * this.layerQuantity, 0.06, 3));

        this.modFreqRatio.setValue(map(this.totalDistanceToOrigin, 0, width * this.layerQuantity, 0.1, 20));

        this.isComplete = checkIfComplete();
    }

    void levelComplete() {
        // BEADS LIBRARY
        ac.out.clearInputConnections();

        // SOUND LIBRARY
        ambiantSound.stop();

        background(0, 0, 0);
        text("LEVEL COMPLETE", width / 2, height / 2);
        println("Level", game.getCurrentLevel(), "complete");
    }
}
