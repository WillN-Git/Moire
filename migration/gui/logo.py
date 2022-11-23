"""
    Responsible to render the Logo
"""
class Logo:
    def __init__(self, cx, cy, radius):
        self.cx = cx
        self.cy = cy
        self.radius = radius
        self.num_slices = 80 

    def set_num_slices(self, n):
        self.num_slices = n
    
    def set_num_slices(self, r):
        self.radius = r

    def draw():
        # self.cx = width * 0.5
        # self.cy = height * 0.5
        # self.radius = width * 0.1

        w = width * 0.3
        h = height * 0.3

        for i in range(0, num_slices):
            slice = deg_to_rad(360) / num_slices
            theta = slice * i

            x = cx + radius * cos(theta)
            y = cy + radius * sin(theta)

            # translate(marg_x, marg_y)
            with pushMatrix(): 
                translate(x, y)
                rotate(theta + deg_to_rad(delta))
                noFill();
                # rect(-w / 2, -h / 2, w, h)
                stroke(*color)
                triangle(w * -0.5, h, 0, 0,  w * 0.5, h)