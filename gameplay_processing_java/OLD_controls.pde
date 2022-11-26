import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;


class Dualsense {
    float joystickSpeed;
    float joystickDeadZone;

    Dualsense() {
        this.joystickSpeed = 7.0;
        this.joystickDeadZone = 0.05;
    }

    /*
    ControlDevice init() {
        this.control = ControlIO.getInstance(this);
        this.controller = control.filter(GCP.STICK).getMatchedDevice("dualsense");
        return controller;
    }
    

    ControlDevice getObject() {
        return controller;
    }
    */

    float getJoystickSpeed() {
        return joystickSpeed;
    }

    float getJoystickDeadZone() {
        return joystickDeadZone;
    }
}


class Controls {
    ControlDevice controller;
    Dualsense dualsense;
    Layer layer1;
    Layer layer2;

    Controls(ControlDevice controller, Dualsense dualsense, Layer layer1, Layer layer2) {
        this.controller = controller;
        this.dualsense = dualsense;
        this.layer1 = layer1;
        this.layer2 = layer2;
    }

    void getUserInput() {
    /*
    println("-------------------------------------------------------------------");
    println("LEFT  | X :",dualsense.getSlider("leftJoyX").getValue(), "Y :", dualsense.getSlider("leftJoyY").getValue());
    println("RIGHT | X :",dualsense.getSlider("rightJoyX").getValue(), "Y :", dualsense.getSlider("rightJoyY").getValue());
    */

        if (abs(controller.getSlider("leftJoyX").getValue()) >= dualsense.getJoystickDeadZone()) {
            layer1.setPositionX((int)(layer1.getPositionX() + controller.getSlider("leftJoyX").getValue() * dualsense.getJoystickSpeed()));
        }

        if (abs(controller.getSlider("leftJoyY").getValue()) >= dualsense.getJoystickDeadZone()) {
            layer1.setPositionY((int)(layer1.getPositionY() + controller.getSlider("leftJoyY").getValue() * dualsense.getJoystickSpeed()));
        }

        if (abs(controller.getSlider("rightJoyX").getValue()) >= dualsense.getJoystickDeadZone()) {
            layer2.setPositionX((int)(layer2.getPositionX() + controller.getSlider("rightJoyX").getValue() * dualsense.getJoystickSpeed()));
        }

        if (abs(controller.getSlider("rightJoyY").getValue()) >= dualsense.getJoystickDeadZone()) {
            layer2.setPositionY((int)(layer2.getPositionY() + controller.getSlider("rightJoyY").getValue() * dualsense.getJoystickSpeed()));
        }
}
}