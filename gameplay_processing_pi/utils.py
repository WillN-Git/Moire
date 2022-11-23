import random


def generate_random_color():
    random.seed()
    return (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))


def generate_random_coord(min_X, max_X, min_Y, max_Y):
    random.seed()
    return (random.randint(min_X, max_X), random.randint(min_Y, max_Y))

def get_distance_to_origin(origin_X, origin_Y, layer):
    layer_X = layer.get_position_X()
    layer_Y = layer.get_position_Y()
    return sqrt((abs(origin_X - layer_X) ** 2) + (abs(origin_Y - layer_Y) ** 2))
