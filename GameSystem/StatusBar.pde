public class StatusBar {
  private final int x1 = width - 400, y1 = height - 350;
  private final int x2 = width, y2 = height - 350;
  private final int x3 = width, y3 = height - 220;
  private final int x4 = width - 425, y4 = height - 220;
  private final int p1 = 0, q1 = 60;
  private final int p2 = 400, q2 = 60;
  private final int p3 = 425, q3 = 170;
  private final int p4 = 0, q4 = 170;
  private int max;
  private String name;
  private color c;
  private boolean player;
  
  public StatusBar(String name, int max, boolean player) {
    this.name = name;
    this.max = max;
    this.player = player;
  }
  
 
  
  public void display(int current) {
    if (player) {
      //Creates the status bar outline for the player
      push();
      fill(245);
      quad(x1, y1, x2, y2, x3, y3, x4, y4);
      triangle(x4 + 20, y4 - 38, x4 + 15, y4, x4 - 30, y4);
      fill(60);
      quad(x1 + 5, y1 + 5, x2, y2 + 5, x3, y3 - 5, x4 + 7.5, y4 - 5);
      triangle(x4 + 15, y4 - 25, x4 + 10, y4 - 5, x4 - 15, y4 - 5);
      fill(230);
      quad(x1 + 11.5, y1 + 15, x2, y2 + 15, x3, y3 - 15, x4 + 17.5, y4 - 15);
      pop();
      
      //Creates the health bar for the player
      drawHealthBar(width - 280, 415, current);
      
      //Creates pokemon name & current / max health for the player
      drawTextUser(current);
      
    } else {
      //Creates the status bar outline for the opponent
      push();
      fill(245);
      quad(p1, q1, p2, q2, p3, q3, p4, q4);
      triangle(p3 - 20, q3 - 38, p3 + 30, q3, p3 - 15, q3);
      fill(60);
      quad(p1, q1 + 5, p2 - 5, q2 + 5, p3 - 7.5, q3 - 5, p4, q4 - 5);
      triangle(p3 - 25, q3 - 33, p3 + 15, q3 - 5, p3 - 20, q3 - 5);
      fill(230);
      quad(p1, q1 + 15, p2 - 10, q2 + 15, p3 - 17.5, q3 - 15, p4, q4 - 15);
      pop();
      
      //Creates the health bar for the opponent
      drawHealthBar(100, 110, current);
      
      //Creates the name for the opponent
      drawTextEnemy();
    }
  }
  
  private void drawTextUser(int current) {
    if (current < 0) {
     current = 0; 
    }
    push();
    textAlign(LEFT, CENTER);
    textSize(25);
    fill(200);
    text(name, 632, 402);
    fill(60);
    text(name, 630, 400);
    textAlign(RIGHT, CENTER);
    text(String.format("%s/%s", current, max), 915, 465);
    fill(255, 195, 0);
    text("HP", 770, 432);
    pop();
  }
  
  private void drawTextEnemy() {
    push();
    textAlign(LEFT, CENTER);
    textSize(25);
    fill(200);
    text(name, 12, 95);
    fill(60);
    text(name, 10, 93);
    fill(255, 195, 0);
    text("HP", 110, 127);
    pop();
  }
  
  private void drawHealthBar(int x, int y, int current) {
    push();
    fill(60);
    rect(x, y, 260, 35, 10);
    float percent = current / (float) max;
    fill(255);
    rect(x + 55, y + 5, 200, 25, 15);
    if (current <= (max * 0.25)) {
      c = color(200, 0, 0);
    } else if (current <= (max * 0.5)) {
      c = color(255, 220, 44);
    } else {
      c = color(0, 200, 0);
    }
    if (current > 0) {
      fill(c);
      rect(x + 55, y + 5, (200 * percent), 25, 15);
    }
    pop();
  }
}
