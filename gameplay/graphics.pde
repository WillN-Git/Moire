class Layer {
    float positionX;
    float positionY;
    float distanceToOrigin;
    float rotation;
    float rotationToBackground;
    boolean rotationClapPlayed;
    float scale;
    float scaleToBackground; // in percentage of difference
    color strokeColor;
    Params params;

    Layer() {
        this.params = new Params();
        this.rotationClapPlayed = false;
        this.scale = 1;
    }

    float getPositionX() {
        return positionX;
    }

    void setPositionX(int input) {
        this.positionX = input;
    }

    float getPositionY() {
        return positionY;
    }

    void setPositionY(int input) {
        this.positionY = input;
    }

    void setPosition(int x, int y) {
        this.positionX = x;
        this.positionY = y;
    }

    float getDistanceToOrigin() {
        return distanceToOrigin;
    }

    void computeDistanceToOrigin(float originX, float originY) {
        this.distanceToOrigin = sqrt(sq(abs(originX - getPositionX())) + sq(abs(originY - getPositionY())));
    }

    float getRotation() {
        return rotation;
    }

    void setRotation(float input) {
        this.rotation = input;
    }

    float getRotationToBackground() {
        return rotationToBackground;
    }

    void computeRotationToBackground(float backgroundRotation) {
        this.rotationToBackground = abs(backgroundRotation - getRotation());
    }

    float getScale() {
        return scale;
    }

    void setScale(float input) {
        this.scale = input;
    }

    float getScaleToBackground() {
        return scaleToBackground;
    }

    void computeScaleToBackground(float input) {
        this.scaleToBackground = abs(1 - input / getScale()) * 100;
    }

    color getStrokeColor() {
        return strokeColor;
    }

    void setStrokeColor(color input) {
        this.strokeColor = input;
    }

    void updatePosition(ControlDevice controller) {
        if (abs(controller.getSlider("leftJoyX").getValue()) >= params.getJoystickDeadZone()) {
            setPositionX((int)(getPositionX() + controller.getSlider("leftJoyX").getValue() * params.getLayerTranslationSpeed()));
        }

        if (abs(controller.getSlider("leftJoyY").getValue()) >= params.getJoystickDeadZone()) {
            setPositionY((int)(getPositionY() + controller.getSlider("leftJoyY").getValue() * params.getLayerTranslationSpeed()));
        }

        if (game.getLevels()[game.getCurrentLevel() - 1].isScaleControlEnabled()) {
            if (abs(controller.getSlider("rightJoyY").getValue()) >= params.getJoystickDeadZone()) {
                setScale(getScale() - controller.getSlider("rightJoyY").getValue() * params.getLayerScaleSpeed());
            }

            if (controller.getButton("triangle").pressed()) {
                this.scale += 0.002;
            }

            if (controller.getButton("cross").pressed()) {
                this.scale -= 0.002;
            }
        }

        if (game.getLevels()[game.getCurrentLevel() - 1].isRotationControlEnabled()) {
            float l2 = map(controller.getSlider("l2").getValue(), -1, 1, 0, 1);
            float r2 = map(controller.getSlider("r2").getValue(), -1, 1, 0, 1);
            setRotation((getRotation() + (r2 - l2) * params.getTriggerSpeed()));
            if (controller.getButton("r1").pressed()) {
                this.rotation += 0.05;
            }

            if (controller.getButton("l1").pressed()) {
                this.rotation -= 0.05;
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