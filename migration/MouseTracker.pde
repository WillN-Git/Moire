class MouseTracker {
    /*
    * =============================
    *         DATA 
    * =============================
    */
    private float maxDistance = dist(0, 0, width, height);
    private float ellipseSize = 300;

    /*
    * =============================
    *         METHODS 
    * =============================
    */
    public void draw() {
        background(0);
        float size;

        for(int i = 0; i <= width; i += 20) {
            for(int j = 0; j <= height; j += 20) {

                size = dist(mouseX, mouseY, i, j);
                size = size / maxDistance * ellipseSize;
                ellipse(i, j, size, size);
                //noStroke();

            }
        }
    }
}
