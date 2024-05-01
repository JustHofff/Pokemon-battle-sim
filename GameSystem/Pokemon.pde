import gifAnimation.*;

class Move {
  private String name;
  private int attack;
  private String type;
  
  public Move(String name, int attack, String type) {
    this.name = name;
    this.attack = attack;
    this.type = type;
  }
  
  public String getName() {
    return name;
  }
  public int getAttack() {
    return attack;
  }
  public String getType() {
    return type;
  }
}

public class Pokemon {
  protected final int UIMAGEX = 250;
  protected final int UIMAGEY = 450;
  protected final int UIMAGE_SIZE = 500;
  protected final float EIMAGEX = 750;
  protected final int EIMAGEY = 220;
  protected final int EIMAGE_SIZE = 300;
  private String type;
  private String name;
  private int max_health;
  private int current_health;
  protected Move[] moveset;
  protected boolean player;
  protected Gif image;
  private String image1;
  private String image2;

  public Pokemon(String name, String type, int max_health, int current_health, Move[] moveset, boolean player, String image1, String image2 ) {
    this.name = name;
    this.type = type;
    this.max_health = max_health;
    this.current_health = current_health;
    this.moveset = moveset;
    this.player = player;
    this.image1 = image1;
    this.image2 = image2;
  }
  
  public void display() {
    push();
    imageMode(CENTER);
    if (frameCount % 5 == 0) {
      image.loop();
    } else {
      image.pause();
    }
    if (player) {
      image(image, UIMAGEX, UIMAGEY, UIMAGE_SIZE, UIMAGE_SIZE);
    } else {
      image(image, EIMAGEX, EIMAGEY, EIMAGE_SIZE, EIMAGE_SIZE);
    }
    pop();
  }
  
  public void loadGif() {
    image = new Gif(GameSystem.this, player ? image2 : image1);
  }
  
  public String getName() {
    return name;
  }
  public String getType() {
    return type;
  }
  public int getMHealth() {
    return max_health;
  }
  public int getCHealth() {
    return current_health;
  }
  public void setCHealth(float factor) {
    this.current_health += factor;
  }
  public boolean isPlayer() {
    return player;
  }
  public void setPlayer(boolean choice) {
    player = choice;
  }
  public String getImage1() {
    return image1;
  }
  public String getImage2() {
    return image2;
  }
  
  public String getMoveName(int move) {
    return moveset[move - 1].getName();
  }
  public int getMoveAttack(int move) {
    return moveset[move - 1].getAttack();
  }
  public String getMoveType(int move) {
    return moveset[move - 1].getType();
  }
}

class Pikachu extends Pokemon {
  
  Pikachu(int max_health, boolean player) {
    super("Pikachu", "Electric", max_health, max_health, new Move[4], player, "gifs/pikachu1.gif", "gifs/pikachu2.gif");
    moveset[0] = new Move("Thunderbolt", 90, "Electric");
    moveset[1] = new Move("Thundershock", 120, "Electric");
    moveset[2] = new Move("Quick Attack", 40, "Normal");
    moveset[3] = new Move("Iron Tail", 100, "Normal");

  }
  @Override
  public void display() {
    push();
    imageMode(CENTER);
    if (frameCount % 5 == 0) {
      image.loop();
    } else {
      image.pause();
    }
    if (player) {
      image(image, UIMAGEX, UIMAGEY, UIMAGE_SIZE - 200, UIMAGE_SIZE - 200);
    } else {
      image(image, EIMAGEX, EIMAGEY + 40, EIMAGE_SIZE - 100, EIMAGE_SIZE - 100);
    }
    pop();
  }
}

class Charizard extends Pokemon {
  
  Charizard(int max_health, boolean player) {
    super("Charizard", "Fire", max_health, max_health, new Move[4], player, "gifs/charizard1.gif", "gifs/charizard2.gif");
    moveset[0] = new Move("Flamethrower", 90, "Fire");
    moveset[1] = new Move("Dragon Claw", 80, "Dragon");
    moveset[2] = new Move("Air Slash", 75, "Flying");
    moveset[3] = new Move("Solar Beam", 120, "Grass");
  }
}

class Blastoise extends Pokemon {
  
  Blastoise(int max_health, boolean player) {
    super("Blastoise", "Water", max_health, max_health, new Move[4], player, "gifs/blastoise1.gif", "gifs/blastoise2.gif" );
    moveset[0] = new Move("Hydro Pump", 110, "Water");
    moveset[1] = new Move("Ice Beam", 95, "Ice");
    moveset[2] = new Move("Aqua Tail", 90, "Water");
    moveset[3] = new Move("Skull Bash", 100, "Normal");
  }
}

class Venusaur extends Pokemon {
  
  Venusaur(int max_health, boolean player) {
    super("Venusaur", "Grass", max_health, max_health, new Move[4], player, "gifs/venusaur1.gif", "gifs/venusaur2.gif");
    moveset[0] = new Move("Solar Beam", 120, "Grass");
    moveset[1] = new Move("Razor Leaf", 55, "Grass");
    moveset[2] = new Move("Sludge Bomb", 90, "Poison");
    moveset[3] = new Move("Earthquake", 100, "Ground");
  }
}

class Dragonite extends Pokemon {
  
  Dragonite(int max_health, boolean player) {
    super("Dragonite", "Dragon", max_health, max_health, new Move[4], player, "gifs/dragonite1.gif", "gifs/dragonite2.gif");
    moveset[0] = new Move("Dragon Claw", 80, "Dragon");
    moveset[1] = new Move("Outrage", 120, "Dragon");
    moveset[2] = new Move("Thunder Punch", 75, "Electric");
    moveset[3] = new Move("Aerial Ace", 60, "Flying");
  }
}

class Alakazam extends Pokemon {
  
  Alakazam(int max_health, boolean player) {
    super("Alakazam", "Psychic", max_health, max_health, new Move[4], player, "gifs/alakazam1.gif", "gifs/alakazam2.gif");
    moveset[0] = new Move("Psychic", 90, "Psychic");
    moveset[1] = new Move("Shadow Ball", 80, "Ghost");
    moveset[2] = new Move("Focus Blast", 85, "Fighting");
    moveset[3] = new Move("Psycho Cut", 70, "Psychic");
  }
}

class Onix extends Pokemon {
  
  Onix(int max_health, boolean player) {
    super("Onix", "Rock", max_health, max_health, new Move[4], player, "gifs/onix1.gif", "gifs/onix2.gif");
    moveset[0] = new Move("Rock Slide", 75, "Rock");
    moveset[1] = new Move("Earthquake", 100, "Ground");
    moveset[2] = new Move("Iron Tail", 100, "Ground");
    moveset[3] = new Move("Stone Edge", 100, "Rock");
  }
}

class Machamp extends Pokemon {
  
  Machamp(int max_health, boolean player) {
    super("Machamp", "Fighting", max_health, max_health, new Move[4], player, "gifs/machamp1.gif", "gifs/machamp2.gif");
    moveset[0] = new Move("Dynamic Punch", 100, "Fighting");
    moveset[1] = new Move("Cross Chop", 80, "Fighting");
    moveset[2] = new Move("Stone Edge", 100, "Rock");
    moveset[3] = new Move("Earthquake", 100, "Ground");
  }
}

class Gengar extends Pokemon {
  
  Gengar(int max_health, boolean player) {
    super("Gengar", "Ghost", max_health, max_health, new Move[4], player, "gifs/gengar1.gif", "gifs/gengar2.gif");
    moveset[0] = new Move("Shadow Ball", 80, "Ghost");
    moveset[1] = new Move("Sludge Bomb", 90, "Poison");
    moveset[2] = new Move("Dark Pulse", 80, "Dark");
    moveset[3] = new Move("Psychic", 90, "Psychic");
  }
}
