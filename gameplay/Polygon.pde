class Polygon extends Layer {
    int sides;
    float radius;
    // boolean rotationControlEnabled;


    Polygon(Map levelParams) {
        super(levelParams);
        this.sides = (int)levelParams.get("shapeSides");
        this.radius = width / 40;
        // this.rotationControlEnabled = (boolean)levelParams.get("rotationControlEnabled");
        println(sides);
    }

    void init() {
        int[] coordLayer = utils.generateRandomCoord(0, width / 2, 0, height / 2);
        positionX = coordLayer[0];
        positionY = coordLayer[1];


        if (hasColor) {
            this.strokeColor = utils.generateRandomColor();
        }
        else {
            this.strokeColor = color(0, 0, 0);
        }

        // if (rotationControlEnabled) {
        //     this.rotation = utils.generateRandomRot() % (360 / this.sides);
        // }

        // if (scaleControlEnabled) {
        //     layers[i].setScale(utils.generateRandomScale());
        // }
    }

    void draw() {
        pushMatrix();
        stroke(this.strokeColor);
        translate(this.positionX, this.positionY);
        rotate(radians(this.rotation));
        scale(this.scale);

        for(int i=0; i < shapeQuantity; i++) {
            drawPoly(this.radius + i * this.shapeSpacing);
            
        }

        popMatrix();
    }


    void drawPoly(float radius) {
        float angle = TWO_PI / this.sides;
        beginShape();
        for(float a = 0; a < TWO_PI; a += angle) {
            float sx = radius * cos(a);
            float sy = radius * sin(a);
            vertex(sx, sy);
        }
        endShape(CLOSE);
    }
}