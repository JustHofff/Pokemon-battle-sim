import java.util.Collections;

final int TEAM_SIZE = 3;
final String ICON = "pokeball.png";


PFont font;
PImage bg;

int rounds;
int turns;
int time;

Menu menu;
PopUp popup;
FightMenu fightMenu;
PokeMenu pokeMenu;
StatusBar userStatus;
StatusBar enemyStatus;
Pokemon[] pokedex1 = {
  new Pikachu(250, true),
  new Charizard(250, true),
  new Blastoise(250, true),
  new Venusaur(250, true),
  new Dragonite(250, true),
  new Alakazam(250, true),
  new Onix(250, true),
  new Machamp(250, true),
  new Gengar(250, true)
};
Pokemon[] pokedex2 = {
  new Pikachu(250, false),
  new Charizard(250, false),
  new Blastoise(250, false),
  new Venusaur(250, false),
  new Dragonite(250, false),
  new Alakazam(250, false),
  new Onix(250, false),
  new Machamp(250, false),
  new Gengar(250, false)
};

ArrayList<Pokemon> userTeam;
ArrayList<Pokemon> enemyTeam;

Pokemon currentUser;
Pokemon currentEnemy;

int userHealth;
int enemyHealth;

String gameState;
String battleState;
String currentUserState;
String currentEnemyState;

int userMove;
int enemyMove;
boolean moveSelected;
boolean pokemonSelected;

boolean winner;
boolean endless;
boolean startText;
boolean quit;

//Transitions / Animations
boolean gameStateTransition;
boolean endStateTransition;
int statusBarTransition1;
int statusBarTransition2;
int pokemonTransition1;
int pokemonTransition2;
boolean menuTransition;
int menuTransitionAmount;
boolean hurtAnimation;
int hurtAnimationAmount;
int topY;
int botY;
float opacity;

boolean isFaster;
int phase;
int faster;


void setup() {
 size(1000, 715);
 windowTitle("Pokemon Battle Simulator");
 surface.setIcon(loadImage(ICON));
 bg = loadImage("BattleBackground.png");
 font = createFont("retro.ttf", 35);
 textFont(font);
 noStroke();
 frameRate(60);
 setVariables();
 
 loadGif(pokedex1);
 loadGif(pokedex2);
 
 userTeam = new ArrayList<Pokemon>();
 enemyTeam = new ArrayList<Pokemon>();
 
 popup = new PopUp();
 
 gameState = "Startup";
}

void draw() {
  background(bg);

  switch(gameState) {
    case "Battle":
      createTeams();
    
      runPokemonStates();
      drawOutline();
      
      runBattleStates();
      break;
      
    case "Startup":
      drawOutline();
      push();
      fill(0);
      rect(0, topY, width, height/2);
      rect(0, botY, width, height/2);
      
      if (startText) {
        textAlign(CENTER);
        textSize(65);
        fill(255);
        text("Pokemon Battle\nSimulator", width/2, 250);
        textSize(30);
        if (floor(frameCount / 40) % 2 == 0) text("Press any key to start", width/2, 450);
      }
      pop();
      
      if (gameStateTransition) {
        topY-=5;
        botY+=5;
      }
      
      if (topY <= (-height/2) && botY >= height) {
        topY = 0;
        botY = height/2;
        gameState = "Battle";
        battleState = "Create";
      }
      break;
      
    case "End":
      push();
      if (quit) {
        fill(0);
        rect(0, 0, width, height);
        fill(255);
        textSize(30);
        textAlign(CENTER, CENTER);
        text("Rounds won:", width/2, 290);
        textSize(65);
        text(rounds, width/2, 350);
        time++;
        if (time == 100) exit();
        
      } else {
        fill(0);
        rect(0, 0, width, height);
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(70);
        text(winner ? "You win!" : "You Lose!", width/2, 200);
        textSize(30);
        text("\"ESC\" to quit", width/2, 275);
        
        if (endless && !winner) {
          text("Rounds won:", width/2, 400); 
          textSize(65);
          text(rounds - 1, width/2, 460);
        } else {
          if (floor(frameCount / 50) % 2 == 0 && winner) text("\"SPACE\" to continue", width/2, 450);
        }
      }
      pop();
      break;
  }
}

void mouseClicked() {
  if(gameState == "Battle") {
    if (menu.getFight()) battleState = "Fight";
    else if (menu.getBag()) battleState = "Bag";
    else if (menu.getPoke()) battleState = "Pokemon";
    else if (menu.getRun()) battleState = "Run";
    
    if (battleState == "Fight") {
      for (int i = 1; i < 5; i++) {
        if (fightMenu.getOver(i)) {
          userMove = i;
          enemyMove = (int)random(1, 5);
          faster = (int)random(0, 2);
          moveSelected = true;
          
        }
      }
    }
    
    if (battleState == "Pokemon") {
      for (int i = 1; i <= userTeam.size(); i++) {
        if (pokeMenu.getOver(i)) {
          if (userTeam.get(0) == userTeam.get(i - 1)) {
            battleState = "Default";
          } else {
            Collections.swap(userTeam, 0, (i - 1));
            statusBarTransition2 = 450;
            pokemonTransition2 = 500;
            currentUserState = "New";
            enemyMove = (int)random(1, 5);
            pokemonSelected = true;
            phase = 5;
          }
        }
      }
    }
  }
}

void keyPressed() {
  if (gameState == "Startup") {
    if (key == ESC) key = 0;
    gameStateTransition = true;
    startText = false;
 
  } else if (gameState == "Battle") {
    if (battleState == "Bag" ||  battleState == "Run" || (battleState == "Pokemon" && !pokemonSelected) || (battleState == "Fight" && !moveSelected)) {
      if (key == ESC) {
       key = 0;
       battleState = "Default";
       }
    }
    /*
    if (battleState == "Fight" && moveSelected) {
      if (key == RIGHT) {
        time = 100;
      }
    }
    */
  } else if (gameState == "End") {
    if (winner && key == ' ' ) {
      endless = true;
      gameState = "Startup";
    } else if (endless && winner && key == ESC) {
      key = 0;
      quit = true;
    }
  }
 
 //if (key == 'p') currentUserState = "Dead"; //For testing
 //if (key == 'o') currentEnemyState = "Dead";
}

//A simple timer that helps to limit how long certain screens last
boolean timer(int s, int limit) {
  if (s >= limit) {
    time = 0;
    return true;
  }
  return false;
}

//Helper method for generating a team, this randomly picks 3 unique pokemon from the pokedex
ArrayList<Pokemon> generateTeam(Pokemon[] arr) {
  ArrayList<Integer> list = new ArrayList<Integer>();
  ArrayList<Pokemon> team = new ArrayList<Pokemon>();
   for (int i=0; i<arr.length; i++){
     list.add(i);
   }
   Collections.shuffle(list);
   for (int i=0; i<TEAM_SIZE; i++) {
     team.add(arr[list.get(i)]);
   }
   return team;
}

//Creates all of the teams when starting a new game
void createTeams() {
  if (battleState == "Create") {
    userTeam = generateTeam(pokedex1);
    enemyTeam = generateTeam(pokedex2);
    currentUserState = "New";
    currentEnemyState = "New";
    menuTransition = true;
    hurtAnimation = true;
    rounds++;
    battleState = "Default";
  }
}

//This has the states for both of the pokemon on screen: New, Alive & Dead
void runPokemonStates() {
  switch(currentEnemyState) {
    case "New":
      currentEnemy = enemyTeam.get(0);
      enemyStatus = new StatusBar(currentEnemy.getName(), currentEnemy.getMHealth(), false);
      enemyHealth = currentEnemy.getMHealth();
      push();
      translate(statusBarTransition1, 0);
      enemyStatus.display(currentEnemy.getCHealth());
      statusBarTransition1 += 20;
      pop();
      if (statusBarTransition1 >= 0) {
        statusBarTransition1 = 0;
        push();
        translate(0, pokemonTransition1);
        currentEnemy.display();
        pokemonTransition1 -= 20;
        pop();
        if (pokemonTransition1 <= 0) pokemonTransition1 = 0;
      }
      
      if (statusBarTransition1 >= 0 && pokemonTransition1 <= 0) currentEnemyState = "Alive";
      break;
      
    case "Alive":
      enemyStatus.display(currentEnemy.getCHealth());
      if (enemyHealth < currentEnemy.getCHealth()) {
        
        if (hurtAnimation) {
          hurtAnimation(currentEnemy);
        } else {
          currentEnemy.display();
          currentEnemy.setCHealth(-0.5);
        }
        
      } else {
        currentEnemy.display();   
      }
      break;
      
    case "Dead":
      push();
      translate(0, pokemonTransition1);
      currentEnemy.display();
      pokemonTransition1 += 20;
      pop();
      if (pokemonTransition1 >= 400) {
        pokemonTransition1 = 400;
        push();
        translate(statusBarTransition1, 0);
        enemyStatus.display(0);
        statusBarTransition1 -= 20;
        pop();
        if (statusBarTransition1 <= -900) statusBarTransition1 = -450;
          
      } else enemyStatus.display(0);
        
      if (pokemonTransition1 >= 400 && statusBarTransition1 <= -450) {
        if (enemyTeam.size() == 1) {
          winner = true;
          endStateTransition = true;;
        } else {
          enemyTeam.remove(0);
          currentEnemyState = "New";
        }
      }     
      break;
  }
  
  switch(currentUserState) {
    case "New":
      currentUser = userTeam.get(0);
      userStatus = new StatusBar(currentUser.getName(), currentUser.getMHealth(), true);
      userHealth = currentUser.getCHealth();
      String[] userAttacks = new String[4];
      String[] userAttackTypes = new String[4];
      for (int i = 0; i < 4; i++) {
        userAttacks[i] = currentUser.getMoveName(i + 1);
        userAttackTypes[i] = currentUser.getMoveType(i + 1);
      }
      fightMenu = new FightMenu(userAttacks, userAttackTypes);
      pokeMenu = new PokeMenu(userTeam);
      push();
      translate(statusBarTransition2, 0);
      userStatus.display(currentUser.getCHealth());
      statusBarTransition2 -= 20;
      pop();
      if (statusBarTransition2 <= 0) {
        statusBarTransition2 = 0;
        push();
        translate(0, pokemonTransition2);
        currentUser.display();
        pokemonTransition2 -= 25;
        pop();
        if (pokemonTransition2 <= 0)  pokemonTransition2 = 0;
      }
      
      if (statusBarTransition2 <= 0 && pokemonTransition2 <= 0) currentUserState = "Alive";
      break;
    
    case "Alive":
      userStatus.display(currentUser.getCHealth());
      if (userHealth < currentUser.getCHealth()) {
        
        if (hurtAnimation) {
          hurtAnimation(currentUser);
        } else {
          currentUser.display();
          currentUser.setCHealth(-0.5);
        }
        
      } else {
        currentUser.display();   
      }
      
      break;
      
    case "Dead":
      push();
      translate(0, pokemonTransition2);
      currentUser.display();
      pokemonTransition2 += 25;
      pop();
      if (pokemonTransition2 >= 500) { 
        pokemonTransition2 = 500;
        push();
        translate(statusBarTransition2, 0);
        userStatus.display(0);
        statusBarTransition2 += 20;
        pop();
        if (statusBarTransition2 >= 900) statusBarTransition2 = 450;
        
      } else userStatus.display(0);
        
      if (pokemonTransition2 >= 500 && statusBarTransition2 >= 450) {
        if (userTeam.size() == 1) {
          winner = false;
          endStateTransition = true;
        } else {
          userTeam.remove(0);
          currentUserState = "New";
        }
      }
      break;
  }
}

//Displays on the screen what menu the user is currently in
void runBattleStates() {
  switch(battleState) {
    case "Default":
      if (menuTransition) {
        push();
        menu = new Menu(null);
        translate(menuTransitionAmount, 0);
        menu.display();
        menuTransitionAmount -= 40;
        pop();
        if (menuTransitionAmount <= 0) {
          menuTransitionAmount = width;
          menuTransition = false;
        }
      } else {
        menu = new Menu(currentUser.getName());
        menu.update();
        menu.display();
        for (int i = 1; i < 5; i++) {
          fightMenu.setOver(i, false);
        }
        for (int i = 0; i < TEAM_SIZE; i++) {
          pokeMenu.setOver(i, false);
        }
         if (endStateTransition) {
          if (!winner) menu.setName(null);
          menu.display();
          fadeOut();
        }
      }
      break;
          
    case "Fight":
      if (moveSelected) {
        popup.display();
        if (faster == 0) { //Check which pokemon isFaster
          fightSequence(false, currentUser, userMove, currentEnemy, enemyMove); // User attacks first
        } else {
          fightSequence(true, currentEnemy, enemyMove, currentUser, userMove); // Enemy attacks first
        }
      } else {
        fightMenu.display();
        fightMenu.update();
      }
      break;
          
    case "Bag":
      popup.display("Work In Progess", 30, false);
      time++;
      if (timer(time, 100)) battleState = "Default";
      break;
          
    case "Pokemon":
      if (pokemonSelected) {
        popup.display();
        if (currentUserState == "Alive") {
          fightSequence(false, currentUser, userMove, currentEnemy, enemyMove);
        }
      } else {
        pokeMenu.update();
        pokeMenu.display();
      }
      break;
          
    case "Run":
      popup.display("You can't run away from a battle!", 30, false);
      time++;
      if (timer(time, 100)) battleState = "Default";
      break;
  }
}

//The user booleans says if the user is being attacked first or not
//This is the whole fight scene, it is designed to move from phase to phase
void fightSequence(boolean user, Pokemon first, int move1, Pokemon second, int move2) {
  switch(phase) {
    case 1: //Displays what attack was used by the first pokemon
      popup.display(first.getName() + " used\n" + first.getMoveName(move1) + "!", 30, false);
      time++;
      if (timer(time, 80)) phase = 2;
      break;
       
    case 2: //Sends attack data to the pokemon's health
      popup.display(first.getName() + " used\n" + first.getMoveName(move1) + "!", 30, false);
      hurtAnimation = true;
      if (user) {
        userHealth -= first.getMoveAttack(move1);
      } else {
        enemyHealth -= first.getMoveAttack(move1);
      }
      if (user && (userHealth < 0)) {
        userHealth = 0;
      } else if (!user && (enemyHealth < 0)) {
        enemyHealth = 0;
      }
      phase = 3;
      break;
     
    case 3: //Checks to see how effective attack was & display it if applicable
      popup.display(first.getName() + " used\n" + first.getMoveName(move1) + "!", 30, false);
      if ((user ? userHealth : enemyHealth) == second.getCHealth()) {
        phase = 4;
        //display if attack was super effective
      }
      break;
    
    case 4: //Checks to see if pokemon fainted, if fainted, moves to farther phase
      if (second.getCHealth() <= 0) {
        popup.display(second.getName() + " has fainted", 30, false);
        time++;
        if (timer(time, 90)) phase = 9;
      } else {
        phase = 5;
      }
      break;
       
    case 5: //Repeat of phase 1, but with the second pokemon
      popup.display(second.getName() + " used\n" + second.getMoveName(move2) + "!", 30, false);
      time++;
      if (timer(time, 80)) phase = 6;
      break;
     
    case 6: //Has the opposite pokemon take damage of phase 2
      popup.display(second.getName() + " used\n" + second.getMoveName(move2) + "!", 30, false);
      hurtAnimation = true;
      if (user) {
        enemyHealth -= second.getMoveAttack(move2);
      } else {
        userHealth -= second.getMoveAttack(move2);
      }
      if (user && (enemyHealth <= 0)) {
        enemyHealth = 0;
      } else if (!user && (userHealth <= 0)) {
        userHealth = 0;
      }
      phase = 7;
      break;
       
    case 7: //Same as phase 3, but flipped
      popup.display(second.getName() + " used\n" + second.getMoveName(move2) + "!", 30, false);      
      if ((user ? enemyHealth : userHealth) == first.getCHealth()) {
        phase = 8;
        //display if attack was super effective
      }
      break;
       
    case 8: //Same as phase 4, but flipped
      if (first.getCHealth() <= 0) {
        popup.display(first.getName() + " has fainted", 30, false);
        time++;
        if (timer(time, 90)) phase = 9;
      } else {
        phase = 9;
      }
      break;
       
    case 9: //Checks to see if any pokemon fainted, ends fight sequence
      if (second.getCHealth() <= 0) {
        
        if (user) {
          currentUserState = "Dead";
        } else {
          currentEnemyState = "Dead";
        }
         
      } else if (first.getCHealth() <= 0) {
         
        if (user) {
          currentEnemyState = "Dead";
        } else {
          currentUserState = "Dead";
        }
        
      }
      turns++;
      phase = 1;
      moveSelected = false;
      pokemonSelected = false;
      battleState = "Default";
      break;
  }
}

//Loads all of the Gifs in the pokedex
void loadGif(Pokemon[] p) {
  for (Pokemon current : p) {
    current.loadGif();
  }
}

//Sets all of the needed variables to their specific values
void setVariables() {
  topY = 0;
  botY = height/2;
  startText = true;
  statusBarTransition1 = -450;
  statusBarTransition2 = 450;
  pokemonTransition1 = 400;
  pokemonTransition2 = 500;
  menuTransitionAmount = 1000;
  phase = 1;
}

//Draws an outline for the menu or popups that appear on screen
void drawOutline() {
  copy(bg, 550, 495, 450, 60, 550, 495, 450, 60); //Helps with the pokemon transition
  push();
  fill(245);
  rect(0, height - 155, width, 155); 
  fill(0);
  rect(0, height - 160, width, 5);
  pop();
}

//Fades the screen when ending the game
void fadeOut() {
  push();
  fill(0, opacity);
  rect(0, 0, width, height);
  pop();
  opacity += 3;
  if (opacity >= 255) {
    opacity = 0;
    gameState = "End";
    endStateTransition = false;
  }
}

//Flashes the pokemon that is getting damaged
void hurtAnimation(Pokemon p) {
  if (hurtAnimationAmount < 50) {
    if (floor(frameCount / 8) % 2 == 0) p.display();
  }
  hurtAnimationAmount++;
  if (hurtAnimationAmount > 50) {
    hurtAnimation = false;
    hurtAnimationAmount = 0;
  }
}
