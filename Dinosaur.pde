class Dinosaur extends Enemy{
	// Requirement #4: Complete Dinosaur Class

	final float TRIGGERED_SPEED_MULTIPLIER = 5;
  float speed = 2f;
  int col, row;
  
  Dinosaur(float x, float y){
    super(x, y);
    col = (int) x / SOIL_SIZE;
    row = (int) y / SOIL_SIZE;
  }
  
  void display(){
    int direction = (speed > 0) ? RIGHT : LEFT;
    
    pushMatrix();
    translate(x, y);
    if(direction == RIGHT){
      scale(1, 1);
      image(dinosaur, 0, 0, w, h);
    }else{
      scale(-1, 1);
      image(dinosaur, -w, 0, w, h);
    }
    popMatrix();
  }
  
  void update(){
    if(x > width - w || x < 0 ){      
      speed *= -1;
    }
    
    float currentSpeed = speed;
    if(player.row == this.row){
      int direction = (speed > 0) ? RIGHT : LEFT;
      
      if(direction == RIGHT && player.x > x){
        currentSpeed *= TRIGGERED_SPEED_MULTIPLIER;
        x += currentSpeed;
      }else if(direction == LEFT && player.x < x){
        currentSpeed *= TRIGGERED_SPEED_MULTIPLIER;
        x += currentSpeed;
      }
    }
    x += speed; 
  }
}
