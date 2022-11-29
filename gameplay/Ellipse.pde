class Ellipse extends Layer {
    float radiusY;

    // ELLIPSE
    Ellipse(Map levelParams, float radiusYMultiplier) {
    super(levelParams);
    this.radiusY = this.radius * radiusYMultiplier;
    }

    // CIRCLE
    Ellipse(Map levelParams) {
        super(levelParams);
        this.radiusY = this.radius;
    }

    void draw() {
        pushMatrix();
        stroke(this.strokeColor);
        translate(this.positionX, this.positionY);
        rotate(radians(this.rotation));
        scale(this.scale);

        for(int i=0; i < this.shapeQuantity; i++) {
            ellipse(0, 0, this.radius + i * this.shapeSpacing, this.radiusY + i * this.shapeSpacing);
        }

        popMatrix();
    }
}