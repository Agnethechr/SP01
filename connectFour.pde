int wide = 7;
int hight = 6;
int blokSize = 100;
int player = 1;
int[][] board = new int[hight][wide];

void setup() {
  size(700, 600);
  ellipseMode(CORNER);
}

//Tjekker at de fire på stribe ikke går udover spillepladen.
int p(int y, int x) {
  return (y<0 || x<0 || y>=hight || x>=wide) ?0:board[y][x];
}

//Tjekker om en af spillerne har fire på stribe.
//Tjekker rækker, kolloner, diagonalt .
int getWinner() {
  for (int y=0; y<hight; y++) for (int x=0; x<wide; x++)
    if (p(y, x) !=0 && p(y, x) == p(y, x+1) && p(y, x)==p(y, x+2) && p(y, x)==p(y, x+3)) return p(y, x);
  for (int y=0; y<hight; y++) for (int x=0; x<wide; x++)
    if (p(y, x)!=0 && p(y, x) == p(y+1, x) && p(y, x) == p(y+2, x) && p(y, x) == p(y+3, x)) return p(y, x);
  for (int y=0; y<hight; y++) for (int x=0; x<wide; x++) for (int d=-1; d<=1; d+=2)
    if (p(y, x)!=0&&p(y, x)==p(y+1, x+1*d)&&p(y, x)==p(y+2, x+2*d)&&p(y, x)==p(y+3, x+3*d)) return p(y, x);
  for (int y=0; y<hight; y++) for (int x=0; x<wide; x++) if (p(y, x)==0) return 0;
  return -1; //Uafgjort
}


//Her bliver der tjekket om der allerede er en cirkel.
int nextSpace(int x) {
  for (int y=hight-1; y>=0; y--) if (board[y][x] == 0) return y;
  return -1;
}

//Her bliver de to cirkler placeret ud fra om det er spiller 1 eller 2.
//Der skiftes mellem spiller 1 og 2 for hver gang man trykker på et felt.
void mousePressed() {
  int x = mouseX / blokSize, y = nextSpace(x);
  if (y>=0) {
    board[y][x] = player;
    player = player==1?2:1;
  }
}
//boardet og de to forskellige cirkler(spiller 1 og 2) bliver tegnet.
void draw() {
  if (getWinner()==0) {
    for (int j=0; j<hight; j++) {
      for (int i=0; i<wide; i++) {
        fill(255);
        rect(i*blokSize, j*blokSize, blokSize, blokSize);
        if (board[j] [i] > 0) {
          fill(board[j][i]==1?160:0, board[j][i]==2?190:0, 0);
          ellipse(i*blokSize, j*blokSize, blokSize, blokSize);
        }
      }
    } 
  }else { //Her bliver vinderne fundet ud fra om en af spillerne har fire på stribe.
  background(0);
  fill(255);
  text("Vinderen er: " + getWinner() + " . Tryk på mellemrum for at begynde forfra", width/2, height/2);
  if (keyPressed&&key==' ') {
    player = 1;
    for (int y=0; y<hight; y++) for (int x=0; x<wide; x++) board[y][x] =0;
  }
}
}
