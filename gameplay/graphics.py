class Layer:
    def __init__(self) -> None:
        self._position_X: int
        self._position_Y: int
        self._scale: float
        self._rotation: float
    
    def get_position_X(self) -> int:
        return self._position_X
    
    def set_position_X(self, input: int):
        self._position_X = input
    
    def get_position_Y(self) -> int:
        return self._position_Y
    
    def set_position_Y(self, input: int):
        self._position_Y = input
    
    def get_position(self) -> tuple:
        return (self._position_X, self._position_Y)
    
    def set_position(self, input: tuple):
        self._position_X = input[0]
        self._position_Y = input[1]
    
    def get_scale(self) -> float:
        return self._scale
    
    def set_scale(self, input: float):
        self._scale = input
    
    def get_rotation(self) -> float:
        return self._rotation
    
    def set_rotation(self, input: float):
        self._rotation = input
