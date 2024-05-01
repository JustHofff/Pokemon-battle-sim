public class Colors {
  
  public color lighten(color in) { return changeColor(in, 2); }
  public color darken(color in) { return changeColor(in, -2); }
  
  //Method that alters a color using the hexadecimal number system
  private color changeColor(color input, int amount) {
    String oldString = hex(input, 6);
    String newString = "FF";
    for (int i = 0; i < oldString.length(); i++) {
      char c = oldString.charAt(i);
      if (i % 2 == 0) {
        c += amount;
        c = checkChar(c);
      }
      newString += c;
    }
    return unhex(newString);
  }
  //Helper method to check if the char goes out of bounds for the hexadecimal system
  private char checkChar(char c) {
    switch(c) {
      case 'G' : return 'F';
      case 'H' : return 'F';
      case ':' : return 'A';
      case ';' : return 'B';
      case '/' : return '0';
      case '.' : return '0';
      case '@' : return '9';
      case '?' : return '8';
      default : return c;
    }
  }
}


public class Menu extends Colors {
  private final int BUTTON_WIDTH = 235, BUTTON_HEIGHT = 73, BUTTON_XL = 521, BUTTON_YT = 566, BUTTON_BEV = 30;
  private final int BUTTON_XR = BUTTON_XL + BUTTON_WIDTH;
  private final int BUTTON_YB = BUTTON_YT + BUTTON_HEIGHT;
  private final int POPUP_X = 4, POPUP_WIDTH = 475;
  private final color RED = #FF6464, YELLOW = #DEB031, GREEN = #67BF4F, BLUE = #63A1F5 ;
  private final color BLACK = color(0);
  private color current;
  private boolean fightOver, bagOver, pokeOver, runOver;
  private Button fight, bag, poke, run;
  private PopUp screen;
  private String name;
  
  public Menu(String name) {
    fight = new Button(BUTTON_XL, BUTTON_YT, BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_BEV);
    bag = new Button(BUTTON_XR, BUTTON_YT, BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_BEV);
    poke = new Button(BUTTON_XL, BUTTON_YB, BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_BEV);
    run = new Button(BUTTON_XR, BUTTON_YB, BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_BEV);
    screen = new PopUp(POPUP_X, POPUP_WIDTH);
    this.name = name;
  }
  
  //Method that updates the button to tell when the mouse is above it
  public void update() {
    fightOver = fight.overButton();
    bagOver = bag.overButton();
    pokeOver = poke.overButton();
    runOver = run.overButton();
  }
  //Method that draws each button as well as the screen on the left
  public void display() {
   if (name != null) {
     screen.display(String.format("What will\n%s do?", name), 30, false);
   } else {
     screen.display();
   }
   drawButton(fight, RED, lighten(RED), fightOver, "Fight");
   drawButton(bag, YELLOW, lighten(YELLOW), bagOver, "Bag");
   drawButton(poke, GREEN, lighten(GREEN), pokeOver, "Pokemon");
   drawButton(run, BLUE, lighten(BLUE), runOver, "Run");
  }
  
  //Helper method to create all 4 buttons
  private void drawButton(Button button, color base, color highlight, boolean over, String text) {
    if (over) { current = highlight; }
    else { current = BLACK;}
    button.drawButton(current, 255, base, false);
    button.drawText(text, 30, 255, 0);
  }
  
  public void setName(String name) {
    this.name = name;
  }
  
  //Returns if the mouse is over the button
  public boolean getFight() { return fightOver; }
  
  public boolean getBag() { return bagOver; }
  
  public boolean getPoke() { return pokeOver; }
  
  public boolean getRun() { return runOver; }
}


public class FightMenu extends Colors {
  private final int BUTTON_WIDTH = 300, BUTTON_HEIGHT = 73, BUTTON_X = 100, BUTTON_Y = 566, BUTTON_BEV = 30;
  private final color BLACK = color(0); 
  private Button[] moves = new Button[4];
  private boolean[] moveOver = new boolean[4];
  private PopUp screen;
  private color current;
  private String[] attacks, types;
  
  public FightMenu(String[] attacks, String[] types) {
    this.attacks = attacks;
    this.types = types;
    screen = new PopUp(796, 200);
    for (int i = 0; i < 4; i++) {
      int x = BUTTON_X + ((i % 2) * BUTTON_WIDTH);
      int y = BUTTON_Y + ((i / 2) * BUTTON_HEIGHT);
      moves[i] = new Button(x, y, BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_BEV);
    }
  }
  
  public void display() {
    screen.display();
  
    for (int i = 0; i < 4; i++) {
      color c = typeColor(types[i]);
      if (moveOver[i]) {
        current = c;
        screen.display(types[i], 20, c);
      } else {
        current = BLACK;
      }
      moves[i].drawButton(current, 255, c, true);
      moves[i].drawText(attacks[i], 20, 200, 0);
    }
  }
  
  private color typeColor(String s) {
    switch(s) {
      case "Normal" : return #A8A77A;
      case "Fire" : return #EE8130;
      case "Water" : return #6390F0;
      case "Electric" : return #F7D02C;
      case "Grass" : return #7AC74C;
      case "Ice" : return #96D9D6;
      case "Fighting" : return #C22E28;
      case "Poison" : return #A33EA1;
      case "Ground" : return #E2BF65;
      case "Flying" : return #A98FF3;
      case "Psychic" : return #F95587;
      case "Bug" : return #A6B91A;
      case "Rock" : return #B6A136;
      case "Ghost" : return #735797;
      case "Dragon" : return #6F35FC;
      default : return BLACK;
    }
  }
  
  public void update() {
    for (int i = 0; i < 4; i++) {
      moveOver[i] = moves[i].overButton();
    }
  }
  
  public boolean getOver(int i) {
    return moveOver[i - 1];
  }
  
  public void setOver(int i, boolean b) {
    moveOver[i - 1] = b;
  }
 
  public String getAttacks(int i) {
    return attacks[i - 1];
  }
  public String getTypes(int i) {
    return types[i - 1];
  }
}

public class PokeMenu {
  private final int IMAGE_SIZE = 100;
  private final int IMAGE_X = (width + IMAGE_SIZE)/5;
  private final int IMAGE_Y = 590;
  private final color WHITE = color(255), RED = color(230, 0, 0);
  private ArrayList<Pokemon> team;
  private PImage[] images = new PImage[3];
  private Button[] pokemon = new Button[3];
  private boolean[] imageOver = new boolean[3];
  private PopUp screen;
  
  public PokeMenu(ArrayList<Pokemon> team) {
    this.team = team;
    screen = new PopUp();
    for (int i = 1; i <= team.size(); i++) {
      int x = IMAGE_X * i;
      images[i - 1] = loadImage(team.get(i - 1).getImage1());
      pokemon[i - 1] = new Button(x, IMAGE_Y, IMAGE_SIZE, IMAGE_SIZE, 0);
    }
  }
  
  public void display() {
    screen.display();
    
    for (int i = 0; i < team.size(); i++) {
      color c = WHITE;
      if (imageOver[i]) {
        c = RED;
      }
      pokemon[i].drawButton(c, WHITE);
      int x = IMAGE_X * (i + 1);
      image(images[i], x, IMAGE_Y, IMAGE_SIZE, IMAGE_SIZE);
    }
    
  }
  
  public void update() {
    for (int i = 0; i < team.size(); i++) {
      imageOver[i] = pokemon[i].overButton();
    }
  }
  
  public boolean getOver(int i) {
    return imageOver[i - 1];
  }
  
  public void setOver(int i, boolean b) {
    imageOver[i] = b;
  }
  
  public Pokemon getPokemon(int i ) {
    return team.get(i - 1);
  }
}
