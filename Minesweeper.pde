import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
public boolean l = false;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();//ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for(int rows = 0; rows < NUM_ROWS; rows++){
      for(int columns = 0; columns < NUM_COLS; columns++){
        buttons [rows][columns] = new MSButton(rows, columns);
      }
    }
    for(int bombNum = 0; bombNum < 50; bombNum++){
      setBombs();
    }
}
public void setBombs()
{
    int rows = (int)(Math.random()*NUM_ROWS);
    int columns = (int)(Math.random()*NUM_COLS);
    if(bombs.contains(buttons[rows][columns])){
      setBombs();
    }
    else{
      bombs.add(buttons[rows][columns]);
    }
    
}

public void draw ()
{
    stroke(#8A00D6);
    background( 0 );
     if(isWon()){
        displayWinningMessage();
        noLoop();
    }
    if(l == true){
      displayLosingMessage();
      noLoop();
    }
}
public boolean isWon()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(buttons[r][c].isClicked() == false && !bombs.contains(buttons[r][c])){
           return false;
        }
      }
    }
   return true;
}
public void displayLosingMessage()
{
    buttons[9][10].setLabel("Y");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("U");
    buttons[12][10].setLabel("L");
    buttons[12][11].setLabel("O");
    buttons[12][12].setLabel("S");
    buttons[12][13].setLabel("E");
    buttons[12][14].setLabel("!");
}
public void displayWinningMessage()
{
    //your code here
    buttons[9][10].setLabel("Y");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("U");
    buttons[12][10].setLabel("W");
    buttons[12][11].setLabel("I");
    buttons[12][12].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true){
          marked = !marked;
          if(marked == false){
            clicked = false;
          }
        }
        else if(bombs.contains(this)){
          clicked = true;
          l = true;
        }
        else if(countBombs(r,c) > 0){
          setLabel(str(countBombs(r,c)));
        }
        else{
          for(int ro = r-1; ro < r+2; ro++){
            for(int col = c-1; col < c+2; col++){
              if(isValid(ro, col) && !buttons[ro][col].isClicked()){
                buttons[ro][col].mousePressed();
              }
             }
            }
        }
    }


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
        return true;
    }
    return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int rX = row-1; rX < row+2; rX++){
          for(int cX = col-1; cX < col+2; cX++){
            if(isValid(rX,cX) && bombs.contains(buttons[rX][cX])){
              numBombs++;
            }
          }
        }
        return numBombs;
          }
    }

       
