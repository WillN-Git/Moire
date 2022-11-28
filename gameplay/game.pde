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

    void goToNextLevel() {
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

    // boolean isFinished() {
    //     return isFinished;
    // }

    // void markFinished() {
    //     this.isFinished = true;
    // }

    void levelComplete() {
        background(0, 0, 0);
        text("LEVEL COMPLETE", width / 2, height / 2);
        delay(5000);

        if (this.currentLevel == this.levelQuantity) {
            this.isFinished = true;
        }

        if (this.isFinished) {
            background(0, 0, 0);
            text("THANKS FOR PLAYING", width / 2, height / 2);
            delay(5000);
            System.exit(-1); // End the program
        }
        else {
            this.levels[currentLevel].levelComplete();
            goToNextLevel();
        }
    }
}

