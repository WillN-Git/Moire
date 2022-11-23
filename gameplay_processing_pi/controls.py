from graphics import *
# import pydualsense


class Controller:
    def __init__(self):
        self._JOYSTICK_SPEED
        self._JOYSTICK_DEAD_ZONE
    
    def get_joystick_speed(self):
        return self._JOYSTICK_SPEED
    
    def get_joystick_dead_zone(self):
        return self._JOYSTICK_DEAD_ZONE


class Dualsense(Controller):
    def __init__(self):
        super().__init__()
        self._JOYSTICK_SPEED = 1
        self._JOYSTICK_DEAD_ZONE = 4
        # self._instance = pydualsense.pydualsense()
        # self._instance.init()
    
    """def instance(self):
        return self._instance"""


class Keyboard(Controller):
    def __init__(self):
        super().__init__()


class Controls:
    def __init__(self, controller, layer1, layer2):
        self._controller = controller
        self._layer1 = layer1
        self._layer2 = layer2
    
    def left_joystick_moved(self, state_X, state_Y):
        if (abs(state_X) > self._controller.get_joystick_dead_zone()) or (abs(state_Y) > self._controller.get_joystick_dead_zone()):
            self._layer1.set_position_X(self._layer1.get_position_X() + ((state_X // 50) * self._controller.get_joystick_speed()))
            self._layer1.set_position_Y(self._layer1.get_position_Y() + ((state_Y // 50) * self._controller.get_joystick_speed()))
    
    def right_joystick_moved(self, state_X, state_Y):
        if (abs(state_X) > self._controller.get_joystick_dead_zone()) or (abs(state_Y) > self._controller.get_joystick_dead_zone()):
            self._layer2.set_position_X(self._layer2.get_position_X() + ((state_X // 50) * self._controller.get_joystick_speed()))
            self._layer2.set_position_Y(self._layer2.get_position_Y() + ((state_Y // 50) * self._controller.get_joystick_speed()))
    
    def left_pad_up(self, state):
        if state:
            self._layer1.set_position_Y(self._layer1.get_position_Y() - 1)
    
    def left_pad_down(self, state):
        if state:
            self._layer1.set_position_Y(self._layer1.get_position_Y() + 1)
    
    def left_pad_left(self, state):
        if state:
            self._layer1.set_position_X(self._layer1.get_position_X() - 1)
    
    def left_pad_right(self, state):
        if state:
            self._layer1.set_position_X(self._layer1.get_position_X() + 1)
    
    def right_pad_up(self, state):
        if state:
            self._layer2.set_position_Y(self._layer2.get_position_Y() - 1)
    
    def right_pad_down(self, state):
        if state:
            self._layer2.set_position_Y(self._layer2.get_position_Y() + 1)
    
    def right_pad_left(self, state):
        if state:
            self._layer2.set_position_X(self._layer2.get_position_X() - 1)
    
    def right_pad_right(self, state):
        if state:
            self._layer2.set_position_X(self._layer2.get_position_X() + 1)
    
    """
    def keyPressed():
        global offset_x, offset_y, shape_scale

        if keyCode == 38:
            offset_y = offset_y - 1
        elif keyCode == 40:
            offset_y = offset_y + 1
        elif keyCode == 37:
            offset_x = offset_x - 1
        elif keyCode == 39:
            offset_x = offset_x + 1
        
        if keyCode == 83:
            shape_scale = shape_scale - 0.01
        elif keyCode == 68:
            shape_scale = shape_scale + 0.01
        # println(keyCode)
    """
