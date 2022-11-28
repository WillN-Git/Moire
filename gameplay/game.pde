class Game {
    ControlDevice controller;
    LevelsParams levelsParams;
    Map[] levelsParamsList;
    int levelQuantity;
    int currentLevel;
    Level[] levels;
    boolean isFinished;
    PApplet parentPApplet; // needed for sound library

    Game(ControlDevice controller, PApplet parentPApplet) {
        this.controller = controller;
        this.levelsParams = new LevelsParams();
        this.levelsParamsList = levelsParams.getParamsList();
        println(levelsParamsList);
        this.levelQuantity = levelsParams.getLevelQuantity();
        this.currentLevel = 1;
        this.levels = new Level[levelQuantity];
        this.isFinished = false;
        this.parentPApplet = parentPApplet;
        populateLevels();
    }

    
    int getLevelQuantity() {
        return levelQuantity;
    }

    int getCurrentLevel() {
        return currentLevel;
    }

    void nextLevel() {
        this.currentLevel += 1;
    }

    
    void populateLevels() {
        for (int i = 0; i < levelQuantity; i++) {
            this.levels[i] = new Level(levelsParamsList[i], controller, parentPApplet);
            println(levelsParamsList[i]);
        }
    }

    Level[] getLevels() {
        return levels;
    }

    boolean isFinished() {
        return isFinished;
    }

    void markFinished() {
        this.isFinished = true;
    }
}

