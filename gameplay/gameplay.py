import random
import time
import py5
import pydualsense as ds


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


random.seed()
ORIGIN_X: int = random.randint(0, int(WINDOW_SIZE))
ORIGIN_Y: int = random.randint(0, int(WINDOW_SIZE))
random.seed()
layer1_offset_x: int = random.randint(0, int(WINDOW_SIZE / 2))
layer1_offset_y: int = random.randint(0, int(WINDOW_SIZE / 2))
random.seed()
layer2_offset_x: int = random.randint(0, int(WINDOW_SIZE / 2))
layer2_offset_y: int = random.randint(0, int(WINDOW_SIZE / 2))


shape_scale = 1.0


def settings():
    py5.size(WINDOW_SIZE, WINDOW_SIZE)


def setup():
    py5.no_fill()
    py5.stroke_weight(STROKE_WEIGHT)
    py5.text_size(20)

    dualsense = ds.pydualsense()
    dualsense.init()
    dualsense.left_joystick_changed += left_joystick
    dualsense.right_joystick_changed += right_joystick
    dualsense.dpad_up += dpad_up
    dualsense.dpad_down += dpad_down
    dualsense.dpad_left += dpad_left
    dualsense.dpad_right += dpad_right
    dualsense.triangle_pressed += triangle_pressed
    dualsense.cross_pressed += cross_pressed
    dualsense.square_pressed += square_pressed
    dualsense.circle_pressed += circle_pressed


def draw():
    if (
        (abs(ORIGIN_X - layer1_offset_x) < 1) and
        (abs(ORIGIN_Y - layer1_offset_y) < 1) and
        (abs(ORIGIN_X - layer2_offset_x) < 1) and
        (abs(ORIGIN_Y - layer2_offset_y) < 1)
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
            py5.ellipse(layer1_offset_x, layer1_offset_y, WINDOW_SIZE / 40 + i * CIRCLE_SPACING, WINDOW_SIZE / 40 + i * CIRCLE_SPACING)
        
        py5.pop_matrix()

        # LAYER 2
        py5.push_matrix()
        py5.stroke(*LAYER2_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            py5.ellipse(layer2_offset_x, layer2_offset_y, WINDOW_SIZE / 40 + i * CIRCLE_SPACING, WINDOW_SIZE / 40 + i * CIRCLE_SPACING)
        
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


def left_joystick(stateX, stateY):
    # print(f'lj {stateX} {stateY}')
    if (abs(stateX) > JOYSTICK_DEAD_ZONE) or (abs(stateY) > JOYSTICK_DEAD_ZONE):
        global layer1_offset_x, layer1_offset_y
        layer1_offset_x = layer1_offset_x + ((stateX / 50) * JOYSTICK_SPEED)
        layer1_offset_y = layer1_offset_y + ((stateY / 50) * JOYSTICK_SPEED)


def right_joystick(stateX, stateY):
    # print(f'lj {stateX} {stateY}')
    if (abs(stateX) > JOYSTICK_DEAD_ZONE) or (abs(stateY) > JOYSTICK_DEAD_ZONE):
        global layer2_offset_x, layer2_offset_y
        layer2_offset_x = layer2_offset_x + ((stateX / 50) * JOYSTICK_SPEED)
        layer2_offset_y = layer2_offset_y + ((stateY / 50) * JOYSTICK_SPEED)


def dpad_up(state):
    if state:
        global layer1_offset_y
        layer1_offset_y -= 1
        # print(f'dpad {state}')


def dpad_down(state):
    if state:
        global layer1_offset_y
        layer1_offset_y += 1
        # print(f'dpad {state}')


def dpad_left(state):
    if state:
        global layer1_offset_x
        layer1_offset_x -= 1
        # print(f'dpad {state}')


def dpad_right(state):
    if state:
        global layer1_offset_x
        layer1_offset_x += 1
        # print(f'dpad {state}')


def triangle_pressed(state):
    if state:
        global layer2_offset_y
        layer2_offset_y -= 1
        # print(f'dpad {state}')


def cross_pressed(state):
    if state:
        global layer2_offset_y
        layer2_offset_y += 1
        # print(f'dpad {state}')


def square_pressed(state):
    if state:
        global layer2_offset_x
        layer2_offset_x -= 1
        # print(f'dpad {state}')


def circle_pressed(state):
    if state:
        global layer2_offset_x
        layer2_offset_x += 1
        # print(f'dpad {state}')


py5.run_sketch()
