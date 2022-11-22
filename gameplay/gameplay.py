import random
import time
import py5
from controls import *
from graphics import *


def generate_random_color():
    color: list[int] = []
    for i in range(3):
        random.seed()
        color.append(random.randint(0, 255))
    
    return color


WINDOW_SIZE: int = 800
BACKGROUND_COLOR: list[int] = [100, 100, 100]
CIRCLE_QUANTITY: int = 100
CIRCLE_SPACING: int = 20
STROKE_WEIGHT: int = 4
BACKGROUND_STROKE_COLOR: list[int] = [0, 0, 0]
LAYER1_STROKE_COLOR: list[int] = generate_random_color()
LAYER2_STROKE_COLOR: list[int] = generate_random_color()

JOYSTICK_SPEED: int = 1
JOYSTICK_DEAD_ZONE: int = 4


layer1: Layer = Layer("BLEND")
layer2: Layer = Layer("BLEND")


random.seed()
ORIGIN_X: int = random.randint(0, int(WINDOW_SIZE))
ORIGIN_Y: int = random.randint(0, int(WINDOW_SIZE))
random.seed()
layer1.set_position(random.randint(0, int(WINDOW_SIZE / 2)), random.randint(0, int(WINDOW_SIZE / 2)))
random.seed()
layer2.set_position(random.randint(0, int(WINDOW_SIZE / 2)), random.randint(0, int(WINDOW_SIZE / 2)))


shape_scale = 1.0


def settings():
    py5.size(WINDOW_SIZE, WINDOW_SIZE)


def setup():
    py5.no_fill()
    py5.stroke_weight(STROKE_WEIGHT)
    py5.text_size(20)

    controller = Dualsense()
    controls = Controls(controller, layer1, layer2)
    
    controller.instance().left_joystick_changed += controls.left_joystick_moved
    controller.instance().right_joystick_changed += controls.right_joystick_moved
    controller.instance().dpad_up += controls.left_pad_up
    controller.instance().dpad_down += controls.left_pad_down
    controller.instance().dpad_left += controls.left_pad_left
    controller.instance().dpad_right += controls.left_pad_right
    controller.instance().triangle_pressed += controls.right_pad_up
    controller.instance().cross_pressed += controls.right_pad_down
    controller.instance().square_pressed += controls.right_pad_left
    controller.instance().circle_pressed += controls.right_pad_right


def draw():
    if (
        (abs(ORIGIN_X - layer1.get_position_X()) < 1) and
        (abs(ORIGIN_Y - layer1.get_position_Y()) < 1) and
        (abs(ORIGIN_X - layer2.get_position_X()) < 1) and
        (abs(ORIGIN_Y - layer2.get_position_Y()) < 1)
    ):
        py5.background(255, 255, 255)
    else:
        start_time: float = time.time()
        py5.background(*BACKGROUND_COLOR)

        # BACKGROUND
        py5.blend_mode(py5.BLEND)
        py5.stroke(*BACKGROUND_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            py5.ellipse(ORIGIN_X, ORIGIN_Y, WINDOW_SIZE / 40 + i * CIRCLE_SPACING, WINDOW_SIZE / 40 + i * CIRCLE_SPACING)

        # LAYER 1
        py5.push_matrix()
        py5.blend_mode(py5.DIFFERENCE)
        py5.stroke(*LAYER1_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            py5.ellipse(layer1.get_position_X(), layer1.get_position_Y(), WINDOW_SIZE / 40 + i * CIRCLE_SPACING, WINDOW_SIZE / 40 + i * CIRCLE_SPACING)
        
        py5.pop_matrix()

        # LAYER 2
        py5.push_matrix()
        py5.stroke(*LAYER2_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            py5.ellipse(layer2.get_position_X(), layer2.get_position_Y(), WINDOW_SIZE / 40 + i * CIRCLE_SPACING, WINDOW_SIZE / 40 + i * CIRCLE_SPACING)
        
        py5.pop_matrix()
    
        stop_time: float = time.time()
        py5.blend_mode(py5.BLEND)
        py5.text(f'{int(1 / (stop_time - start_time))} FPS', 0, 20)

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


py5.run_sketch()
