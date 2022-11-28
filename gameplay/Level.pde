class Level {
    Map levelParams;
    int levelID;
    int layerQuantity;
    Polygon[] layers;
    // String shapeType;
    int shapeSides;
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
    // Layer background;
    ControlDevice controller;
    PApplet parentPApplet; // needed for sound library
    // Polygon polygon;

    Level(Map levelParams, ControlDevice controller, PApplet parentPApplet) {
        this.levelParams = levelParams;
        this.levelID = (int)levelParams.get("ID");
        this.layerQuantity = (int)levelParams.get("layerQuantity");
        this.layers = new Polygon[layerQuantity + 1]; // +1 because layers[0] = background
        // this.shapeType = levelParams.get("shapeType").toString();
        this.shapeSides = (int)levelParams.get("shapeSides");
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
        this.controller = controller;
        this.parentPApplet = parentPApplet;
        instanciateLayers();
    }

    void instanciateLayers() {
        // Map backgroundParams = levelParams;
        // backgroundParams.replace("hasColor", false);
        // println(backgroundParams);
        this.layers[0] = new Polygon(levelParams); //background

        for (int i = 1; i <= layerQuantity; i++) {
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

        for (int i = 0; i <= layerQuantity; i++) {
            layers[i].init();
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

        for (int layer = 1; layer <= layerQuantity; layer++) { // start at 1 because layers[0] is background
            if (layerToControl == layer) {
                layers[layer].updatePosition(controller);
            }
            layers[layer].computeDistanceToOrigin(layers[0].getPositionX(), layers[0].getPositionY());
            this.totalDistanceToOrigin += layers[layer].getDistanceToOrigin();

            layers[layer].computeRotationToBackground(layers[0].getRotation());
            // switch (shapeType) {
            //     case "square":
            //         this.sumOfLayersRotations += (layers[layer].getRotationToBackground() % 90);
            // }

            layers[layer].computeScaleToBackground(layers[0].getScale());
            this.sumOfLayersScalesDifferences += (layers[layer].getScaleToBackground());
        }

        this.isComplete = checkIfComplete();

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
            this.layers[i].draw();
        }
    }
}