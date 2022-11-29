class Params {
    float joystickDeadZone;
    float layerTranslationSpeed;
    float layerScaleSpeed;
    float triggerSpeed;

    Params() {
        this.joystickDeadZone = 0.05;
        this.layerTranslationSpeed = 7.0;
        this.layerScaleSpeed = 0.5;
        this.triggerSpeed = 2.0;
    }

    float getJoystickDeadZone() {
        return joystickDeadZone;
    }

    float getLayerTranslationSpeed() {
        return layerTranslationSpeed;
    }

    float getLayerScaleSpeed() {
        return layerScaleSpeed;
    }

    float getTriggerSpeed() {
        return triggerSpeed;
    }
}
