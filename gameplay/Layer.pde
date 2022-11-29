class Layer {
    Map levelParams;
    float positionX;
    float positionY;
    float distanceToOrigin;
    float rotation;
    float rotationToBackground;
    boolean rotationControlEnabled;
    boolean rotationClapPlayed;
    float scale;
    float scaleToBackground; // in percentage of difference
    boolean scaleControlEnabled;
    boolean scaleClapPlayed;
    boolean hasColor;
    color strokeColor;
    int shapeSides;
    int shapeQuantity;
    int shapeSpacing;
    int strokeWeight;
    float radius;
    Params params;

    Layer(Map levelParams) {
        this.levelParams = levelParams;
        this.rotationControlEnabled = (boolean)levelParams.get("rotationControlEnabled");
        this.rotationClapPlayed = false;
        this.scale = 1;
        this.scaleControlEnabled = (boolean)levelParams.get("scaleControlEnabled");
        this.scaleClapPlayed = false;
        this.hasColor = (boolean)levelParams.get("hasColor");
        this.shapeSides = (int)levelParams.get("shapeSides");
        this.shapeQuantity = 100;
        // this.shapeSpacing = 20;
        this.strokeWeight = 8;
        this.radius = width / 60;
        this.params = new Params();
        initRotation();
        initShapeSpacing();
    }

    void initRotation() {
        if (this.shapeSides > 0) {
                this.rotation = (180 / this.shapeSides);
        }
        else if (this.shapeSides == 0 || this.shapeSides == -1) {
            this.rotation = 0;
        }
    }

    void initShapeSpacing() {
        switch (this.shapeSides) {
            case -1:
                this.shapeSpacing = 30;
                break;
            case 0:
                this.shapeSpacing = 40;
                break;
            case 3:
                this.shapeSpacing = 35;
                break;
            default:
                this.shapeSpacing = 20;
        }
    }

    float getPositionX() {
        return positionX;
    }

    float getPositionY() {
        return positionY;
    }

    float getDistanceToOrigin() {
        return distanceToOrigin;
    }

    void computeDistanceToOrigin(float originX, float originY) {
        this.distanceToOrigin = dist(originX, originY, this.positionX, this.positionY);
    } 

    float getRotation() {
        return rotation;
    }

    float getRotationToBackground() {
        return rotationToBackground;
    }

    void computeRotationToBackground(float backgroundRotation) {
        this.rotationToBackground = abs(backgroundRotation - this.rotation);
    }

    float getScale() {
        return scale;
    }

    float getScaleToBackground() {
        return scaleToBackground;
    }

    void computeScaleToBackground(float input) {
        this.scaleToBackground = abs(1 - input / getScale()) * 100;
    }

    void setStrokeColor(color input) {
        this.strokeColor = input;
    }

    void init(boolean hasColor) {
        strokeWeight(strokeWeight);

        int[] coordLayer = utils.generateRandomCoord(0, width, 0, height);
        this.positionX = coordLayer[0];
        this.positionY = coordLayer[1];


        if (hasColor) {
            this.strokeColor = utils.generateRandomColor();
        }
        else {
            this.strokeColor = color(0, 0, 0);
        }

        if (this.rotationControlEnabled) {
            if (this.shapeSides > 0) {
                this.rotation = utils.generateRandomRot() % (360 / this.shapeSides);
            }
            else if (this.shapeSides == 0) {
                this.rotation = utils.generateRandomRot() % 180;
            }
            else if (this.shapeSides == -1) {
                println("Not allowed to activate rotation control when playing with circles.");
                System.exit(-1);
            }
        }

        if (this.scaleControlEnabled) {
            this.scale = utils.generateRandomScale();
        }
    }

    void draw() {

    }

    void updatePosition(ControlDevice controller) {
        if (abs(controller.getSlider("leftJoyX").getValue()) >= params.getJoystickDeadZone()) {
            this.positionX = ((int)(this.positionX + controller.getSlider("leftJoyX").getValue() * params.getLayerTranslationSpeed()));
        }

        if (abs(controller.getSlider("leftJoyY").getValue()) >= params.getJoystickDeadZone()) {
            this.positionY = ((int)(this.positionY + controller.getSlider("leftJoyY").getValue() * params.getLayerTranslationSpeed()));
        }

        if (this.scaleControlEnabled) {
            if (abs(controller.getSlider("rightJoyY").getValue()) >= params.getJoystickDeadZone()) {
                this.scale = (this.scale - controller.getSlider("rightJoyY").getValue() * params.getLayerScaleSpeed());
            }

            if (controller.getButton("triangle").pressed()) {
                this.scale += 0.002;
            }

            if (controller.getButton("cross").pressed()) {
                this.scale -= 0.002;
            }
        }

        if (this.rotationControlEnabled) {
            float l2 = map(controller.getSlider("l2").getValue(), -1, 1, 0, 1);
            float r2 = map(controller.getSlider("r2").getValue(), -1, 1, 0, 1);
            this.rotation += (r2 - l2) * params.getTriggerSpeed();

            if (controller.getButton("r1").pressed()) {
                this.rotation += 0.05;
            }

            if (controller.getButton("l1").pressed()) {
                this.rotation -= 0.05;
            }

            if (this.shapeSides > 0) {
                // Nasty formula to map the rotation to only positive value 0 <= x <= (360 / this.shapeSides)
                this.rotation = ((this.rotation % (360 / this.shapeSides)) + (360 / this.shapeSides)) % (360 / this.shapeSides);
            }
            else if (this.shapeSides == 0) {
                this.rotation = ((this.rotation % 180) + 180) % 180;
            }

            
        }

        if (controller.getHat("crosspad").left()) {
            this.positionX -= 0.1;
        }

        if (controller.getHat("crosspad").right()) {
            this.positionX += 0.1;
        }

        if (controller.getHat("crosspad").up()) {
            this.positionY -= 0.1;
        }

        if (controller.getHat("crosspad").down()) {
            this.positionY += 0.1;
        }
    }
}