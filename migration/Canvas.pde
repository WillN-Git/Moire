public class Canvas {
    public float x;
    public float y;
    public float width;
    public float height;

    public Canvas(float xx, float yy, float width, float height) {
        this.x = xx;
        this.y = yy;
        this.width = width;
        this.height = height;
    }

    public void draw() {
        rectMode(CENTER);
        rect(this.x, this.y, this.width, this.height);
    }
}