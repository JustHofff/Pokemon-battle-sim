public class PopUp {
 private final int Y = 566;
 private final int HEIGHT = 145;
 private final int BEV = 20;
 private int x = 4;
 private int width = 992;
 private int textX = 45;
 
 public PopUp() {
 }
 
  public PopUp(int x, int width) {
   this.x = x;
   this.width = width;
 }
 
 public void display() {
   push();
   fill(0);
   rect(x, Y, width, HEIGHT, BEV);
   fill(255, 195, 0);
   rect(x + 5, Y + 5, width - 10, HEIGHT - 10, BEV - 5);
   fill(167);
   rect(x + 10, Y + 10, width - 20, HEIGHT - 20, BEV - 10);
   fill(255);
   rect(x + 20, Y + 15, width - 40, HEIGHT - 30, BEV - 15);
   pop();
 }
 
 public void display(String string, int size, boolean align) {
   display();
   push();
   textSize(size);
   if (align) {
     textX = x;
     textAlign(CENTER, CENTER);
   } else {
     textAlign(LEFT, CENTER);
   }
   fill(200);
   text(string, textX + 2, Y + 2, width, HEIGHT);
   fill(0);
   text(string, textX, Y, width, HEIGHT);
   pop();
 }
 
 //Only for fight menu, displays the element of each attack
 public void display(String string, int size, color c) {
   display();
   push();
   textSize(size);
   textAlign(CENTER, CENTER);
   fill(c);
   rect(x + 25, 615, width - 50, 50, BEV - 5);
   fill(0);
   text(string, x + 2, Y + 2, width, HEIGHT);
   fill(255);
   text(string, x, Y, width, HEIGHT);
   pop();
 }
}
