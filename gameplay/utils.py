import random


def generate_random_color() -> tuple:
    random.seed()
    return (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))


def generate_random_coord(min_X: int, max_X: int, min_Y: int, max_Y: int) -> tuple:
    random.seed()
    return (random.randint(min_X, max_X), random.randint(min_Y, max_Y))