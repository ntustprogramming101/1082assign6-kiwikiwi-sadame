class Robot extends Enemy{
	// Requirement #5: Complete Dinosaur Class

	final int PLAYER_DETECT_RANGE_ROW = 2;
	final int LASER_COOLDOWN = 180;
	final int HAND_OFFSET_Y = 37;
	final int HAND_OFFSET_X_FORWARD = 64;
	final int HAND_OFFSET_X_BACKWARD = 16;
  float speed = 2f;
  int cooldown = LASER_COOLDOWN;
  Laser laser;
  
  void display(){

    int direction = (speed > 0) ? RIGHT : LEFT;    
    pushMatrix();
    translate(x, y);
    if(direction == RIGHT){
      scale(1, 1);
      image(robot, 0, 0, w, h);
    }else{
      scale(-1, 1);
      image(robot, -w, 0, w, h);
    }
    popMatrix();
    laser.display();
  }
  
  void update(){  
    float currentSpeed = speed;
    
    if(checkX() && checkY()){
      if(cooldown < LASER_COOLDOWN)  cooldown ++;
      if(cooldown == LASER_COOLDOWN){
        if(currentSpeed > 0){
          laser.fire(x+HAND_OFFSET_X_FORWARD, y+HAND_OFFSET_Y, player.x+player.w/2, player.y+player.h/2);
        }else if(currentSpeed < 0){
          laser.fire(x+HAND_OFFSET_X_BACKWARD, y+HAND_OFFSET_Y, player.x+player.w/2, player.y+player.h/2);
        }
        cooldown = 0;
      }
    }else{
      x += currentSpeed;
      if(x < 0 || x > width-w){
        speed *= -1;
      }
    }
    laser.update();
  }
  
  void checkCollision(Player player){
    laser.checkCollision(player);
  }
  
  boolean checkX(){
    float playerCenter = player.x + player.w/2;
    if((speed > 0 && playerCenter > x + HAND_OFFSET_X_FORWARD) ||
        speed < 0 && playerCenter < x + HAND_OFFSET_X_BACKWARD){
      return true;
    }
    return false;
  }
  
  boolean checkY(){
    if(player.row <= (y/SOIL_SIZE) + PLAYER_DETECT_RANGE_ROW &&
       player.row >= (y/SOIL_SIZE) - PLAYER_DETECT_RANGE_ROW){
      return true;
    }
    return false;
  }
  
  Robot(float x, float y){
    super(x, y);
    laser = new Laser();
  }
}
