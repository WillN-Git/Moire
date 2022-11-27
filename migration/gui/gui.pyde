from math import pi, cos, sin
from logo import Logo

width = 800
height = 800


def setup(): 
    size(width, height)
    
def draw():
    draw_logo((240, 0, 32))
    draw_logo_a((35, 190, 255), 10)


def draw_logo(color):
    cx = width * 0.5
    cy = height * 0.5
    radius = width * 0.1

    w = width * 0.3
    h = height * 0.3

    num_slices = 80

    for i in range(0, num_slices):
        slice = deg_to_rad(360) / num_slices
        theta = slice * i

        x = cx + radius * cos(theta)
        y = cy + radius * sin(theta)

        # translate(marg_x, marg_y)
        with pushMatrix(): 
            translate(x, y)
            rotate(theta)
            noFill();
            # rect(-w / 2, -h / 2, w, h)
            stroke(*color)
            triangle(w * -0.5, h, 0, 0,  w * 0.5, h)
            

    