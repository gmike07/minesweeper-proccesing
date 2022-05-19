class Board{
  int rows;
  int cols;
  int w;
  int h;
  int openedCells = 0;
  int numberOfBombs;
  boolean gameOver = false;
  Cell[][] cells;
  public Board(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
    cells = new Cell[rows][cols];
    w = width / rows;
    h = height / cols;
    initCells();
  }
  
  void initCells(){
  for(int i = 0; i < rows; i++)
    for(int j = 0; j < cols; j++)
      cells[i][j] = new Cell(i, j, w, h);
  }
  
  void draw(){
    for(int i = 0; i < rows; i++)
      for(int j = 0; j < cols; j++)
        cells[i][j].draw();
  }
  
  void placeBombs(int clickX, int clickY, int numberOfBombs){
    this.numberOfBombs = numberOfBombs;
    int createdBombs = 0;
    while(createdBombs < numberOfBombs){
      int x = (int)random(rows);
      int y = (int)random(cols);
      if(!Neighbors(x, y, clickX, clickY)){
        if(canPlaceBomb(x,y)){
          placeBomb(x, y);
          createdBombs++;
        }
      }
    }
  }
  
  boolean canPlaceBomb(int x, int y){
    if(cells[x][y].isBomb)
      return false;
    for(int i = -1; i < 2; i++)
      for(int j = -1; j < 2; j++)
          if(validIndex(x + i, y + j) && cells[x + i][y + j].isBomb == false)
              return true;
    return false;
  }
  
  boolean validIndex(int i, int j){
    return i >= 0 && j >= 0 && i < rows && j < cols;
  }

  void placeBomb(int x, int y){
    cells[x][y].placeBomb();
    for(int i = -1; i < 2; i++)
      for(int j = -1; j < 2; j++)
          if(validIndex(x + i, y + j))
            cells[x + i][y + j].updateNumberOfBombs();
  }
  
  void open(int x, int y){
    openCells(x / w, y / h);
  }
  
  void flag(int x, int y){
    cells[x / w][y / h].flag();
  }
  
  void openCells(int x, int y){
    if(!validIndex(x, y) || cells[x][y].isOpened() || cells[x][y].flagged)
      return;
    if(cells[x][y].isBomb){
      gameOver = true;
      showBoard();
      draw();
    }
    cells[x][y].open();
    openedCells++;
    if(cells[x][y].numberBombs() == 0){
      for(int i = -1; i < 2; i++)
        for(int j = -1; j < 2; j++)
          openCells(x + i, y + j);
    }
  }
  
  boolean victory(){
    return this.openedCells >= rows * cols - numberOfBombs && gameOver == false; 
  }
  
  boolean gameOver(){
    return gameOver;
  }
  
  boolean Neighbors(int x, int y, int clickX, int clickY){
    int x1 = clickX / w;
    int y1 = clickY / h;
    for(int i = -1; i < 2; i++)
        for(int j = -1; j < 2; j++)
          if(x == x1 + i && y == y1 + j)
              return true;
    return false;
  }
  
  void showBoard(){
   for(int i = 0; i < rows; i++)
    for(int j = 0; j < cols; j++)
      cells[i][j].open();
  }
 
}
