class Layer:
    def __init__(self, blend_mode: str) -> None:
        self._position_X: int
        self._position_Y: int
        self._scale: float
        self._rotation: float
        self._blend_mode: str = blend_mode
    
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
    
    def set_position(self, input_X: int, input_Y: int):
        self._position_X = input_X
        self._position_Y = input_Y
    
    def get_scale(self) -> float:
        return self._scale
    
    def set_scale(self, input: float):
        self._scale = input
    
    def get_rotation(self) -> float:
        return self._rotation
    
    def set_rotation(self, input: float):
        self._rotation = input
