class Cell{
  int number = 0;
  boolean isBomb;
  int x;
  int y;
  int w;
  int h;
  boolean Opened;
  boolean flagged;
  public Cell(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.isBomb = false;
    this.Opened = false;
    this.flagged = false;
  }
  
  void draw(){
    fill(255);
    int x1 = this.x * w;
    int y1 = this.y * h;
    rect(x1, y1, w, h);
    fill(0);
    textSize(20);
    if(flagged)
      text("flagged", x1 + w / 3, y1 + h / 2);
    else if(!isBomb && Opened)
      text("" + number, x1 + w / 3, y1 + h / 2);
    else if(Opened){
      text("bomb", x1 + w / 3, y1 + h / 2);
    }
  }
  
  void placeBomb(){
    isBomb = true;
  }
  
  void updateNumberOfBombs(){
    number++;
  }
  
  void open(){
    Opened = true;
  }
  
  boolean isOpened(){
    return Opened;
  }
  
  int numberBombs(){
    return number;
  }
  
  void flag(){
    flagged = !flagged;
  }
}
