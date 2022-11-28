class Polygon extends Layer {
    float radius;


    Polygon(Map levelParams) {
        super(levelParams);
        this.radius = width / 40;
    }

    void init(boolean hasColor) {
        strokeWeight(strokeWeight);

        int[] coordLayer = utils.generateRandomCoord(0, width, 0, height);
        this.positionX = coordLayer[0];
        this.positionY = coordLayer[1];


        if (hasColor) {
            this.strokeColor = utils.generateRandomColor();
        }
        else {
            this.strokeColor = color(0, 0, 0);
        }

        if (this.rotationControlEnabled) {
            this.rotation = utils.generateRandomRot() % (360 / this.shapeSides);
        }

        if (this.scaleControlEnabled) {
            this.scale = utils.generateRandomScale();
        }
    }

    void draw() {
        pushMatrix();
        stroke(this.strokeColor);
        translate(this.positionX, this.positionY);
        rotate(radians(this.rotation));
        scale(this.scale);

        for(int i=0; i < this.shapeQuantity; i++) {
            drawPoly(this.radius + i * this.shapeSpacing);
        }

        popMatrix();
    }


    void drawPoly(float radius) {
        float angle = TWO_PI / this.shapeSides;
        beginShape();
        for(float a = 0; a < TWO_PI; a += angle) {
            float sx = radius * cos(a);
            float sy = radius * sin(a);
            vertex(sx, sy);
        }
        endShape(CLOSE);
    }
}