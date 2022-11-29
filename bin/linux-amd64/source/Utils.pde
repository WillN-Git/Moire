class Utils {
    color generateRandomColor() {
        return color(random(256), random(256), random(256));
    }

    int[] generateRandomCoord(int minX, int maxX, int minY, int maxY) {
        return new int[] {(int)random(minX, maxX), (int)random(minY, maxY)};
    }

    float generateRandomRot() {
        return random(0, 361);
    }

    float generateRandomScale() {
        return random(1, 3);
    }
}
