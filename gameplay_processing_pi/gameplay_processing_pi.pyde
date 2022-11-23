# add_library('oscP5')
import time, params, utils
from graphics import *
from controls import *





WINDOW_SIZE = params.WINDOW_SIZE
BACKGROUND_COLOR = (100, 100, 100)
CIRCLE_QUANTITY = 100
CIRCLE_SPACING = 20
STROKE_WEIGHT = 4
STATIC_STROKE_COLOR = (0, 0, 0)
LAYER1_STROKE_COLOR = utils.generate_random_color()
LAYER2_STROKE_COLOR = utils.generate_random_color()


layer1 = Layer()
layer2 = Layer()


(ORIGIN_X, ORIGIN_Y) = utils.generate_random_coord(0, WINDOW_SIZE[0], 0, WINDOW_SIZE[1])
layer1.set_position(utils.generate_random_coord(0, (WINDOW_SIZE[0] // 2), 0, (WINDOW_SIZE[1] // 2)))
layer2.set_position(utils.generate_random_coord(0, (WINDOW_SIZE[0] // 2), 0, (WINDOW_SIZE[1] // 2)))


def setup():
    size(*WINDOW_SIZE)
    noFill()
    strokeWeight(STROKE_WEIGHT)
    textSize(params.FPS_FONT_SIZE)

    # controller = Dualsense()
    # controls = Controls(controller, layer1, layer2)
    
    """controller.instance().left_joystick_changed += controls.left_joystick_moved
    controller.instance().right_joystick_changed += controls.right_joystick_moved
    controller.instance().dpad_up += controls.left_pad_up
    controller.instance().dpad_down += controls.left_pad_down
    controller.instance().dpad_left += controls.left_pad_left
    controller.instance().dpad_right += controls.left_pad_right
    controller.instance().triangle_pressed += controls.right_pad_up
    controller.instance().cross_pressed += controls.right_pad_down
    controller.instance().square_pressed += controls.right_pad_left
    controller.instance().circle_pressed += controls.right_pad_right"""


def draw():
    if (
        (abs(ORIGIN_X - layer1.get_position_X()) < 1) and
        (abs(ORIGIN_Y - layer1.get_position_Y()) < 1) and
        (abs(ORIGIN_X - layer2.get_position_X()) < 1) and
        (abs(ORIGIN_Y - layer2.get_position_Y()) < 1)
    ):
        background(255, 255, 255)
    else:
        start_time = time.time()
        background(*BACKGROUND_COLOR)
    
        # STATIC
        blendMode(BLEND)
        stroke(*STATIC_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            ellipse(
                ORIGIN_X,
                ORIGIN_Y,
                (WINDOW_SIZE[0] // 40) + (i * CIRCLE_SPACING),
                (WINDOW_SIZE[1] // 40) + (i * CIRCLE_SPACING)
            )
    
        # LAYER 1
        pushMatrix()
        blendMode(DIFFERENCE)
        stroke(*LAYER1_STROKE_COLOR)
        for i in range(CIRCLE_QUANTITY):
            ellipse(
                layer1.get_position_X(),
                layer1.get_position_Y(),
                (WINDOW_SIZE[0] // 40) + (i * CIRCLE_SPACING),
                (WINDOW_SIZE[1] // 40) + (i * CIRCLE_SPACING)
            )
        popMatrix()
    
        # LAYER 2
        with pushMatrix():
            blendMode(DIFFERENCE)
            stroke(*LAYER2_STROKE_COLOR)
            for i in range(CIRCLE_QUANTITY):
                ellipse(
                    layer2.get_position_X(),
                    layer2.get_position_Y(),
                    (WINDOW_SIZE[0] // 40) + (i * CIRCLE_SPACING),
                    (WINDOW_SIZE[1] // 40) + (i * CIRCLE_SPACING)
                )
        
        layer1.set_distance_to_origin(utils.get_distance_to_origin(ORIGIN_X, ORIGIN_Y, layer1))
        layer2.set_distance_to_origin(utils.get_distance_to_origin(ORIGIN_X, ORIGIN_Y, layer2))
    
        # FPS COUNTER
        stop_time = time.time()
        blendMode(BLEND)
        fps = int(1 / (stop_time - start_time))
        text("{} FPS".format(fps), 0, 20)


def keyPressed():
    # UP
    if keyCode == 38:
        # controls.left_pad_up()
        layer2.set_position_Y(layer2.get_position_Y() - 1)
    
    # DOWN
    elif keyCode == 40:
        # controls.left_pad_down()
        layer2.set_position_Y(layer2.get_position_Y() + 1)
    
    # LEFT
    elif keyCode == 37:
        # controls.left_pad_left()
        layer2.set_position_X(layer2.get_position_X() - 1)
    
    # RIGHT
    elif keyCode == 39:
        # controls.left_pad_right()
        layer2.set_position_X(layer2.get_position_X() + 1)
    
    # Z
    elif keyCode == 90:
        # controls.left_pad_up()
        layer1.set_position_Y(layer1.get_position_Y() - 1)
    
    # S
    elif keyCode == 83:
        # controls.left_pad_down()
        layer1.set_position_Y(layer1.get_position_Y() + 1)
    
    # Q
    elif keyCode == 81:
        # controls.left_pad_left()
        layer1.set_position_X(layer1.get_position_X() - 1)
    
    # D
    elif keyCode == 68:
        # controls.left_pad_right()
        layer1.set_position_X(layer1.get_position_X() + 1)
    
    print(keyCode)
