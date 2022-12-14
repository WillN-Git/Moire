import java.util.Map;

class LevelsParams{
    int levelQuantity;
    Map level1Params;
    Map level2Params;
    Map level3Params;
    Map level4Params;
    Map level5Params;
    Map level6Params;
    Map level7Params;
    Map level8Params;
    Map level9Params;
    Map level10Params;
    Map level11Params;
    Map level12Params;
    Map level13Params;
    Map level14Params;
    Map[] paramsList;

    LevelsParams() {
        this.levelQuantity = 14;

        // 1 CIRCLE, NO COLOR
        this.level1Params = Map.of(
            "ID", 1,
            "layerQuantity", 1,
            "shapeSides", -1,
            "hasColor", false,
            "rotationControlEnabled", false,
            "scaleControlEnabled", false
        );

        // 1 CIRCLE, COLORS
        this.level2Params = Map.of(
            "ID", 2,
            "layerQuantity", 1,
            "shapeSides", -1,
            "hasColor", true,
            "rotationControlEnabled", false,
            "scaleControlEnabled", false
        );

        // 2 CIRCLES, COLORS
        this.level3Params = Map.of(
            "ID", 3,
            "layerQuantity", 2,
            "shapeSides", -1,
            "hasColor", true,
            "rotationControlEnabled", false,
            "scaleControlEnabled", false
        );

        // 1 SQUARE, COLORS
        this.level4Params = Map.of(
            "ID", 4,
            "layerQuantity", 1,
            "shapeSides", 4,
            "hasColor", true,
            "rotationControlEnabled", false,
            "scaleControlEnabled", false
        );

        // 2 SQUARES, COLORS
        this.level5Params = Map.of(
            "ID", 5,
            "layerQuantity", 2,
            "shapeSides", 4,
            "hasColor", true,
            "rotationControlEnabled", false,
            "scaleControlEnabled", false
        );

        // 1 SQUARE, COLOR, ROTATION
        this.level6Params = Map.of(
            "ID", 6,
            "layerQuantity", 1,
            "shapeSides", 4,
            "hasColor", true,
            "rotationControlEnabled", true,
            "scaleControlEnabled", false
        );

        // 1 TRIANGLE, COLOR, ROTATION
        this.level7Params = Map.of(
            "ID", 7,
            "layerQuantity", 1,
            "shapeSides", 3,
            "hasColor", true,
            "rotationControlEnabled", true,
            "scaleControlEnabled", false
        );

        // 2 TRIANGLES, COLOR, ROTATION
        this.level8Params = Map.of(
            "ID", 8,
            "layerQuantity", 2,
            "shapeSides", 3,
            "hasColor", true,
            "rotationControlEnabled", true,
            "scaleControlEnabled", false
        );

        // 2 SQUARES, COLOR, ROTATION
        this.level9Params = Map.of(
            "ID", 9,
            "layerQuantity", 2,
            "shapeSides", 4,
            "hasColor", true,
            "rotationControlEnabled", true,
            "scaleControlEnabled", false
        );

        // 1 CIRCLE, COLOR, SCALE
        this.level10Params = Map.of(
            "ID", 10,
            "layerQuantity", 1,
            "shapeSides", -1,
            "hasColor", true,
            "rotationControlEnabled", false,
            "scaleControlEnabled", true
        );

        
        // 1 SQUARE, COLOR, ROTATION, SCALE
        this.level11Params = Map.of(
            "ID", 11,
            "layerQuantity", 1,
            "shapeSides", 4,
            "hasColor", true,
            "rotationControlEnabled", true,
            "scaleControlEnabled", true
        );

        // 2 CIRCLES, COLOR, SCALE
        this.level12Params = Map.of(
            "ID", 12,
            "layerQuantity", 2,
            "shapeSides", -1,
            "hasColor", true,
            "rotationControlEnabled", false,
            "scaleControlEnabled", true
        );

        // 2 SQUARES, COLOR, ROTATION, SCALE
        this.level13Params = Map.of(
            "ID", 13,
            "layerQuantity", 2,
            "shapeSides", 4,
            "hasColor", true,
            "rotationControlEnabled", true,
            "scaleControlEnabled", true
        );

        // 3 SQUARES, COLOR, ROTATION, SCALE
        this.level14Params = Map.of(
            "ID", 14,
            "layerQuantity", 3,
            "shapeSides", 4,
            "hasColor", true,
            "rotationControlEnabled", true,
            "scaleControlEnabled", true
        );            

        populateParamsList();
    }

    int getLevelQuantity() {
        return levelQuantity;
    }

    void populateParamsList() {
        this.paramsList = new Map[levelQuantity];
        this.paramsList[0] = level1Params;
        this.paramsList[1] = level2Params;
        this.paramsList[2] = level3Params;
        this.paramsList[3] = level4Params;
        this.paramsList[4] = level5Params;
        this.paramsList[5] = level6Params;
        this.paramsList[6] = level7Params;
        this.paramsList[7] = level8Params;
        this.paramsList[8] = level9Params;
        this.paramsList[9] = level10Params;
        this.paramsList[10] = level11Params;
        this.paramsList[11] = level12Params;
        this.paramsList[12] = level13Params;
        this.paramsList[13] = level14Params;
    }

    Map[] getParamsList() {
        return paramsList;
    }

    Map getLevel1Params() {
        return level1Params;
    }
}
