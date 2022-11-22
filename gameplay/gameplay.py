import time
import py5
import params
from graphics import *
import utils
from controls import *


WINDOW_SIZE: tuple = params.WINDOW_SIZE
BACKGROUND_COLOR: tuple = (100, 100, 100)
CIRCLE_QUANTITY: int = 100
CIRCLE_SPACING: int = 20
STROKE_WEIGHT: int = 4
STATIC_STROKE_COLOR: tuple = (0, 0, 0)
LAYER1_STROKE_COLOR: tuple = utils.generate_random_color()
LAYER2_STROKE_COLOR: tuple = utils.generate_random_color()


layer1: Layer = Layer()
layer2: Layer = Layer()


(ORIGIN_X, ORIGIN_Y) = utils.generate_random_coord(0, WINDOW_SIZE[0], 0, WINDOW_SIZE[1])
layer1.set_position(utils.generate_random_coord(0, (WINDOW_SIZE[0] // 2), 0, (WINDOW_SIZE[1] // 2)))
layer2.set_position(utils.generate_random_coord(0, (WINDOW_SIZE[0] // 2), 0, (WINDOW_SIZE[1] // 2)))


def settings():
    py5.size(*WINDOW_SIZE)


def setup():
    py5.no_fill()
    py5.stroke_weight(STROKE_WEIGHT)
    py5.text_size(params.FPS_FONT_SIZE)

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

        # STATIC
        py5.blend_mode(py5.BLEND)
        py5.stroke(*STATIC_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            py5.ellipse(
                ORIGIN_X,
                ORIGIN_Y,
                (WINDOW_SIZE[0] // 40) + (i * CIRCLE_SPACING),
                (WINDOW_SIZE[1] // 40) + (i * CIRCLE_SPACING)
            )

        # LAYER 1
        py5.push_matrix()
        py5.blend_mode(py5.DIFFERENCE)
        py5.stroke(*LAYER1_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            py5.ellipse(
                layer1.get_position_X(),
                layer1.get_position_Y(),
                (WINDOW_SIZE[0] // 40) + (i * CIRCLE_SPACING),
                (WINDOW_SIZE[1] // 40) + (i * CIRCLE_SPACING)
            )
        py5.pop_matrix()

        # LAYER 2
        py5.push_matrix()
        py5.blend_mode(py5.DIFFERENCE)
        py5.stroke(*LAYER2_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            py5.ellipse(
                layer2.get_position_X(),
                layer2.get_position_Y(),
                (WINDOW_SIZE[0] // 40) + (i * CIRCLE_SPACING),
                (WINDOW_SIZE[1] // 40) + (i * CIRCLE_SPACING)
            )
        py5.pop_matrix()
    
        # FPS COUNTER
        stop_time: float = time.time()
        py5.blend_mode(py5.BLEND)
        py5.text(f'{int(1 / (stop_time - start_time))} FPS', 0, 20)


py5.run_sketch()
