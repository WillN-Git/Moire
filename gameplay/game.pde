class Game {
    ControlDevice controller;
    LevelsParams levelsParams;
    Map[] levelsParamsList;
    int levelQuantity;
    int currentLevel;
    Level[] levels;
    boolean isFinished;
    PApplet parentPApplet; // needed for sound library

    // BEADS
    // String ambiantSoundPath;
    // SamplePlayer ambiantSoundPlayer;
    // String rotationClapPath;
    // SamplePlayer rotationClapPlayer;

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

        // BEADS
        // this.ambiantSoundPath = (sketchPath("") + "data/ambiant.wav");
        // this.ambiantSoundPlayer = new SamplePlayer(SampleManager.sample(this.ambiantSoundPath));
        // this.ambiantSoundPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
        // this.rotationClapPath = (sketchPath("") + "data/rotationClap.wav");
        // this.rotationClapPlayer = new SamplePlayer(SampleManager.sample(this.rotationClapPath));

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

    void levelComplete() {
        if (this.currentLevel == this.levelQuantity) {
            this.isFinished = true;
        }

        if (this.isFinished) {
            gameComplete();
        }
        else {
            this.levels[currentLevel].levelComplete();

            int pauseTime = 3000; // ms
            boolean timeElapsed = false;
            int time = millis();

            while (! timeElapsed) {
                if (millis() - time > pauseTime) {
                    timeElapsed = true;
                }
            }

            goToNextLevel();
        }
    }

    void gameComplete() {
        background(0, 0, 0);
        text("THANKS FOR PLAYING", width / 2, height / 2);
        delay(5000);
        System.exit(-1); // End the program
    }
}

