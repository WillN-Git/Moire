class Polygon extends Layer {
    int sides;
    float radius;

    Polygon() {
        this.sides = 3;
        this.radius = width / 40;
    }

    void draw() {
        pushMatrix();
        
        translate(this.positionX, this.positionY);
        rotate( radians(this.rotation) );
        scale(this.scale);

        for(int i=0; i < this.shapeQuantity; i++) {
            drawPoly(this.radius + i * this.shapeQuantity);
        }

        popMatrix();
    }


    private void drawPoly(float radius) {
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