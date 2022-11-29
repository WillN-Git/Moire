class Polygon extends Layer {

    Polygon(Map levelParams) {
        super(levelParams);
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
