import random
# import pydualsense.pydualsense as ds

WINDOW_SIZE = 800
CIRCLE_QUANTITY = 100
CIRCLE_SPACING = 20
STROKE_WEIGHT = 5

shape_scale = 1.0




def setup():
    global origin_x, origin_y, offset_x, offset_y
    random.seed()
    origin_x = random.randint(0, int(WINDOW_SIZE))
    origin_y = random.randint(0, int(WINDOW_SIZE))
    random.seed()
    offset_x = random.randint(0, int(WINDOW_SIZE / 2))
    offset_y = random.randint(0, int(WINDOW_SIZE / 2))

    size(WINDOW_SIZE, WINDOW_SIZE)
    noFill()
    strokeWeight(STROKE_WEIGHT)

    """dualsense = ds.pydualsense()
    dualsense.init()
    dualsense.left_joystick_changed += joystick"""


def draw():
    if (offset_x == origin_x) and (offset_y == origin_y):
        background(255, 0, 0)
    else:
        background(100, 100, 100)

        for i in range(CIRCLE_QUANTITY):
            ellipse(origin_x, origin_y, WINDOW_SIZE / 40 + i * CIRCLE_SPACING, WINDOW_SIZE / 40 + i * CIRCLE_SPACING)

        pushMatrix()
        # scale(shape_scale)
        for i in range(CIRCLE_QUANTITY):
            ellipse(offset_x, offset_y, WINDOW_SIZE / 40 + i * CIRCLE_SPACING, WINDOW_SIZE / 40 + i * CIRCLE_SPACING)
        
        popMatrix()



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


