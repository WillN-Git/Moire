class Layer {
    int positionX;
    int positionY;
    float distanceToOrigin;
    float scale;
    float rotation;
    color strokeColor;
    Params params;

    Layer() {
        this.params = new Params();
    }

    int getPositionX() {
        return positionX;
    }

    void setPositionX(int input) {
        this.positionX = input;
    }

    int getPositionY() {
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

    void computeDistanceToOrigin(int originX, int originY) {
        this.distanceToOrigin = sqrt(sq(abs(originX - getPositionX())) + sq(abs(originY - getPositionY())));
    }

    color getStrokeColor() {
        return strokeColor;
    }

    void setStrokeColor(color input) {
        this.strokeColor = input;
    }

    void updatePosition(ControlDevice controller) {
        if (abs(controller.getSlider("leftJoyX").getValue()) >= params.getJoystickDeadZone()) {
            setPositionX((int)(getPositionX() + controller.getSlider("leftJoyX").getValue() * params.getJoystickSpeed()));
        }

        if (abs(controller.getSlider("leftJoyY").getValue()) >= params.getJoystickDeadZone()) {
            setPositionY((int)(getPositionY() + controller.getSlider("leftJoyY").getValue() * params.getJoystickSpeed()));
        }

        if (controller.getHat("crosspad").left()) {
            this.positionX -= 1;
        }

        if (controller.getHat("crosspad").right()) {
            this.positionX += 1;
        }

        if (controller.getHat("crosspad").up()) {
            this.positionY -= 1;
        }

        if (controller.getHat("crosspad").down()) {
            this.positionY += 1;
        }
    }
}