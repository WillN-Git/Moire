class Game {
    int levelQuantity;
    int currentLevel;
    Level[] levels;
    boolean isFinished;

    Game(int levelQuantity) {
        this.levelQuantity = levelQuantity;
        this.currentLevel = 1;
        this.levels = new Level[levelQuantity];
        this.isFinished = false;
    }

    int getLevelQuantity() {
        return levelQuantity;
    }

    int getCurrentLevel() {
        return currentLevel;
    }

    void nextLevel() {
        this.currentLevel += 1;
    }

    void setLevels(Level[] input) {
        this.levels = input;
    }

    Level[] getLevels() {
        return levels;
    }

    boolean isFinished() {
        return isFinished;
    }

    void markFinished() {
        this.isFinished = true;
    }
}


class Params {
    float joystickSpeed;
    float joystickDeadZone;

    Params() {
        this.joystickSpeed = 7.0;
        this.joystickDeadZone = 0.05;
    }

    float getJoystickSpeed() {
        return joystickSpeed;
    }

    float getJoystickDeadZone() {
        return joystickDeadZone;
    }
}


class Level {
    int levelID;
    int layerQuantity;
    Layer[] layers;
    float totalDistanceToOrigin;
    int shapeQuantity;
    int shapeSpacing;
    int strokeWeight;
    boolean hasColor;
    int circleButtonPressedCount;
    int layerToControl;
    boolean hasBeenSetUp;
    boolean isComplete;
    Layer background;
    ControlDevice controller;

    Level(int levelID, int layerQuantity, ControlDevice controller) {
        this.levelID = levelID;
        this.layerQuantity = layerQuantity;
        this.layers = new Layer[layerQuantity];
        this.shapeQuantity = 100;
        this.shapeSpacing = 20;
        this.strokeWeight = 4;
        this.hasColor = true;
        this.circleButtonPressedCount = 0;
        this.layerToControl = 1;
        this.hasBeenSetUp = false;
        this.isComplete = false;
        this.background = new Layer();
        this.controller = controller;
        instanciateLayers(layerQuantity);
    }

    void instanciateLayers(int layerQuantity) {
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
        strokeWeight(strokeWeight);
        background.setStrokeColor(color(0, 0, 0));
        int[] coordBackground = utils.generateRandomCoord(0, width, 0, height);
        background.setPosition(coordBackground[0], coordBackground[1]);

        for (int i = 0; i < layerQuantity; i++) {
            layers[i].setStrokeColor(utils.generateRandomColor());
            int[] coordLayer = utils.generateRandomCoord(0, width / 2, 0, height / 2);
            layers[i].setPosition(coordLayer[0], coordLayer[1]);
        }

        this.hasBeenSetUp = true;
    }

    void drawLevel() {
        this.totalDistanceToOrigin = 0;

        for (int layer = 0; layer < layerQuantity; layer++) {
            if (layerToControl == layer + 1) {
                layers[layer].updatePosition(controller);
            }
            layers[layer].computeDistanceToOrigin(background.getPositionX(), background.getPositionY());
            this.totalDistanceToOrigin += layers[layer].getDistanceToOrigin();
        }

        if (totalDistanceToOrigin < layerQuantity) {
            this.isComplete = true;
        }

        background(100, 100, 100);

        // STATIC BACKGROUND LAYER
        blendMode(BLEND);
        stroke(background.getStrokeColor());
        for (int i = 0; i < shapeQuantity; i++) {
            ellipse(
                background.getPositionX(),
                background.getPositionY(),
                (width / 40) + (i * shapeSpacing),
                (height / 40) + (i * shapeSpacing)
            );
        }

        // REMOTED MOVING LAYERS
        for (int i = 0; i < layerQuantity; i++) {
            pushMatrix();
            blendMode(DIFFERENCE);
            stroke(layers[i].getStrokeColor());
            for (int j = 0; j < shapeQuantity; j++) {
                ellipse(
                    layers[i].getPositionX(),
                    layers[i].getPositionY(),
                    (width / 40) + (j * shapeSpacing),
                    (height / 40) + (j * shapeSpacing)
                );
            }
            popMatrix();
        }
    }
}