class Level {
    int levelID;
    int layerQuantity;
    Layer[] layers;
    String shapeType;
    int shapeQuantity;
    int shapeSpacing;
    int strokeWeight;
    boolean hasColor;
    float totalDistanceToOrigin;
    int circleButtonPressedCount;
    int layerToControl;
    boolean rotationControlEnabled;
    float sumOfLayersRotations;
    boolean scaleControlEnabled;
    float sumOfLayersScalesDifferences;
    boolean hasBeenSetUp;
    boolean isComplete;
    Layer background;
    ControlDevice controller;
    PApplet parentPApplet; // needed for sound library

    Level(Map levelParams, ControlDevice controller, PApplet parentPApplet) {
        this.levelID = (int)levelParams.get("ID");
        this.layerQuantity = (int)levelParams.get("layerQuantity");
        this.layers = new Layer[layerQuantity];
        this.shapeType = levelParams.get("shapeType").toString();
        this.shapeQuantity = 100;
        this.shapeSpacing = 20;
        this.strokeWeight = 4;
        this.hasColor = (boolean)levelParams.get("hasColor");
        this.circleButtonPressedCount = 0;
        this.layerToControl = 1;
        this.rotationControlEnabled = (boolean)levelParams.get("rotationControlEnabled");
        this.scaleControlEnabled = (boolean)levelParams.get("scaleControlEnabled");
        this.hasBeenSetUp = false;
        this.isComplete = false;
        this.background = new Layer();
        this.controller = controller;
        this.parentPApplet = parentPApplet;
        instanciateLayers();
    }

    void instanciateLayers() {
        for (int i = 0; i < layerQuantity; i++) {
            this.layers[i] = new Layer();
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
        }
    }

    int getLayerToControl() {
        return layerToControl;
    }

    void updateLayerToControl() {
        this.layerToControl = (circleButtonPressedCount % layerQuantity) + 1;
    }

    boolean isRotationControlEnabled() {
        return rotationControlEnabled;
    }

    boolean isScaleControlEnabled() {
        return scaleControlEnabled;
    }

    boolean hasBeenSetUp() {
        return hasBeenSetUp;
    }

    void setupLevel() {
        println("--------");
        println("LEVEL", game.getCurrentLevel());
        strokeWeight(strokeWeight);
        background.setStrokeColor(color(0, 0, 0));

        // STATIC BACKGROUND LAYER
        int[] coordBackground = utils.generateRandomCoord(0, width, 0, height);
        background.setPosition(coordBackground[0], coordBackground[1]);

        if (rotationControlEnabled) {
            switch (shapeType) {
                case "square":
                    background.setRotation(utils.generateRandomRot() % 90);
            }
        }

        if (scaleControlEnabled) {
            background.setScale(utils.generateRandomScale());
        }

        // DYNAMIC LAYERS
        for (int i = 0; i < layerQuantity; i++) {
            int[] coordLayer = utils.generateRandomCoord(0, width / 2, 0, height / 2);
            layers[i].setPosition(coordLayer[0], coordLayer[1]);

            if (hasColor) {
                layers[i].setStrokeColor(utils.generateRandomColor());
            }
            else {
                layers[i].setStrokeColor(color(0, 0, 0));
            }

            if (rotationControlEnabled) {
                switch (shapeType) {
                    case "square":
                        layers[i].setRotation(utils.generateRandomRot() % 90);
                }
            }

            if (scaleControlEnabled) {
                layers[i].setScale(utils.generateRandomScale());
            }
        }

        // SOUND SETUP
        sineWaves = new SinOsc[numSines];
        sineVolume = new float[numSines];
        for (int i = 0; i < numSines; i++) {
            // The overall amplitude shouldn't exceed 1.0 which is prevented by 1.0/numSines.
            // The ascending waves will get lower in volume the higher the frequency.
            sineVolume[i] = volume / (i + 1);

            // Create the Sine Oscillators and start them
            sineWaves[i] = new SinOsc(parentPApplet);
            sineWaves[i].play();
        }

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

        for (int layer = 0; layer < layerQuantity; layer++) {
            if (layerToControl == layer + 1) {
                layers[layer].updatePosition(controller);
            }
            layers[layer].computeDistanceToOrigin(background.getPositionX(), background.getPositionY());
            this.totalDistanceToOrigin += layers[layer].getDistanceToOrigin();

            layers[layer].computeRotationToBackground(background.getRotation());
            switch (shapeType) {
                case "square":
                    this.sumOfLayersRotations += (layers[layer].getRotationToBackground() % 90);
            }

            layers[layer].computeScaleToBackground(background.getScale());
            this.sumOfLayersScalesDifferences += (layers[layer].getScaleToBackground());
        }

        this.isComplete = checkIfComplete();

        background(100, 100, 100);
        rectMode(CENTER);

        // STATIC BACKGROUND LAYER
        pushMatrix();
        blendMode(BLEND);
        stroke(background.getStrokeColor());
        translate(background.getPositionX(), background.getPositionY());
        rotate(radians(background.getRotation()));
        scale(background.getScale());
        for (int i = 0; i < shapeQuantity; i++) {
            switch(shapeType) {
                case "circle":
                    ellipse(0, 0, (width / 40) + (i * shapeSpacing), (height / 40) + (i * shapeSpacing));
                    break;
                case "square":
                    square(0, 0, (width / 40) + (i * shapeSpacing));
                    break;
            }
        }
        popMatrix();

        // DYNAMIC LAYERS
        if (hasColor) {
            blendMode(DIFFERENCE);
        }
        else {
            blendMode(BLEND);
        }

        for (int i = 0; i < layerQuantity; i++) {
            pushMatrix();
            stroke(layers[i].getStrokeColor());
            translate(layers[i].getPositionX(), layers[i].getPositionY());
            rotate(radians(layers[i].getRotation()));
            scale(layers[i].getScale());
            for (int j = 0; j < shapeQuantity; j++) {
                switch(shapeType) {
                    case "circle":
                        ellipse(0, 0, (width / 40) + (j * shapeSpacing), (height / 40) + (j * shapeSpacing));
                        break;
                    case "square":
                        square(0, 0, (width / 40) + (j * shapeSpacing));
                        break;
                }   
            }
            popMatrix();

            // ROTATION CLAP SOUND
            if ((layers[i].getRotationToBackground() % 90 < 1) && (! layers[i].rotationClapPlayed)) {
                rotationClap.play();
                layers[i].rotationClapPlayed = true;
            }
            if (layers[i].getRotationToBackground() % 90 > 1) {
                layers[i].rotationClapPlayed = false;
            }

            // SCALE CLAP SOUND
            if ((layers[i].scaleToBackground < 0.1) && (! layers[i].scaleClapPlayed)) {
                scaleClap.play();
                layers[i].scaleClapPlayed = true;
            }
            if (layers[i].scaleToBackground > 0.1) {
                layers[i].scaleClapPlayed = false;
            }
        }


        // CONTINUOUS SOUND
        float frequency = pow(700, map(totalDistanceToOrigin, 0, 848, 0, 1)) + 300;
        // float frequency = 200;
        float detune = map(totalDistanceToOrigin, 0, 1500, 0.5, 10);
        

        // Set the frequencies, detuning and volume
        for (int i = 0; i < numSines; i++) { 
            sineWaves[i].freq(frequency * (i + 1 + i * detune));
            sineWaves[i].amp(sineVolume[i]);
        }
    }
}