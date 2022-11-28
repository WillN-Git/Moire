class Game {
    ControlDevice controller;
    LevelsParams levelsParams;
    Map[] levelsParamsList;
    int levelQuantity;
    int currentLevel;
    Level[] levels;
    boolean isFinished;

    Game(ControlDevice controller) {
        this.controller = controller;
        this.levelsParams = new LevelsParams();
        this.levelsParamsList = levelsParams.getParamsList();
        this.levelQuantity = levelsParams.getLevelQuantity();
        this.currentLevel = 1;
        this.levels = new Level[levelQuantity];
        this.isFinished = false;
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
            this.levels[i] = new Level(levelsParamsList[i], controller);
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

