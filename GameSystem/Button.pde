public class Button {
  private int x, y, width, height, bev;
  
  public Button(int x, int y, int width, int height, int bev) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.bev = bev;
  }
  
   public boolean overButton() {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
  public void drawButton(color v1, color v2, color v3, boolean v4) {
    push();
    fill(v1);
    rect(x, y, width, height, bev);
    fill(v2);
    rect(x + 5, y + 5, width - 10, height - 10, bev - 5);
    fill(v3);
    rect(x + 10, y + 10, width - 20, height - 20, bev - 10);
    if(v4) {
      fill(255);
      rect(x + 30 , y + 15, width - 60, height - 30, bev - 25);
    }
    pop();
  }
  
  //For BagMenu
  public void drawButton(color v1, color v2) {
    push();
    fill(v1);
    rect(x, y, width, height);
    fill(v2);
    rect(x + 5, y + 5, width - 10, height - 10);
    pop();
  }
  
  public void drawText(String string, int size, color c1, color c2) {
    push();
    textAlign(CENTER, CENTER);
    textSize(size);
    fill(c1);
    text(string, x + 2, y + 2, width, height);
    fill(c2);
    text(string, x, y, width, height);
    pop();
  }
}
