Board board;
int rows = 7;
int cols = 10;
int numberOfBombs = 40;
boolean firstClick = true;
void setup(){
  size(700, 700);
  board = new Board(rows, cols);
}

void draw(){
  board.draw();
}


void mouseReleased(){
  if(!board.gameOver() && !board.victory()){
    if(firstClick){
      board.placeBombs(mouseX, mouseY, numberOfBombs);
      firstClick = false;
    }
    if(mouseButton == LEFT){
      board.open(mouseX, mouseY);
    }else{//mouseButton == right
      board.flag(mouseX, mouseY);
    }
  }if(board.victory())
    print("victory");
  if(board.gameOver())
    print("game over");
}
