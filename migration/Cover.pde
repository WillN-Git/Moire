public class Cover {
    /*
    * =============================
    *         DATA 
    * =============================
    */

    private float n;
    private float w; // 2D space width
    private float h; // 2D space height
    private float dx; // Increment x this amount per pixel 
    private float dy; // Increment y this amount per pixel
    private float x; // Start x at -1 * width / 2



    /*
    * =============================
    *         CONSTRUCTOR 
    * =============================
    */

    public Cover() {
        n = (mouseY * 10.0) / width;
        w = 16.0;         
        h = 16.0;         
        dx = w / width;    
        dy = h / height;   
        x = -w/2;          
    }


    /*
    * =============================
    *         METHODS 
    * =============================
    */

    public void draw() {
        loadPixels();

        float r, theta, val;

        for (int i = 0; i < width; i++) {
                float y = -h/2;        // Start y at -1 * height / 2
                for (int j = 0; j < height; j++) {
                r = sqrt((x*x) + (y*y));    // Convert cartesian to polar
                theta = atan2(y,x);         // Convert cartesian to polar
                
                // Compute 2D polar coordinate function
                val = sin(n*cos(r) + 5 * theta);           // Results in a value between -1 and 1
                
                // Map resulting vale to grayscale value
                pixels[i+j*width] = color((val + 1.0) * 255.0/2.0);     // Scale to between 0 and 255
                y += dy; // Increment y
            }
            x += dx; // Increment x
        }

        updatePixels();
    }
}