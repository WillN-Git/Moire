class Layer:
    def __init__(self):
        self._position_X = 0
        self._position_Y = 0
        self._scale = 1
        self._rotation = 0
        self._distance_to_origin = 0
    
    def get_position_X(self):
        return self._position_X
    
    def set_position_X(self, input):
        self._position_X = input
    
    def get_position_Y(self):
        return self._position_Y
    
    def set_position_Y(self, input):
        self._position_Y = input
    
    def get_position(self):
        return (self._position_X, self._position_Y)
    
    def set_position(self, input):
        self._position_X = input[0]
        self._position_Y = input[1]
    
    def get_scale(self):
        return self._scale
    
    def set_scale(self, input):
        self._scale = input
    
    def get_rotation(self):
        return self._rotation
    
    def set_rotation(self, input):
        self._rotation = input
    
    def get_distance_to_origin(self):
        return self._distance_to_origin
    
    def set_distance_to_origin(self, input):
        self._distance_to_origin = input
