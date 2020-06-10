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
    if(laser.isAlive){
      laser.display();
    }
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
    
  }
  
  void update(){  
    if(x > width - w || x < 0 ){      
      speed *= -1;
    }
    
    laser = new Laser();
    if(checkX() && checkY()){
      if(cooldown == 0){
        if(speed > 0){
          laser.fire(x+HAND_OFFSET_X_FORWARD, y+HAND_OFFSET_Y, player.x+player.w/2, player.y+player.h/2);
          cooldown = LASER_COOLDOWN;
        }else{
          laser.fire(x+HAND_OFFSET_X_BACKWARD, y+HAND_OFFSET_Y, player.x+player.w/2, player.y+player.h/2);
          cooldown = LASER_COOLDOWN;
        }
      }else{
        cooldown --;
      }
    }else{
      x += speed;
    }
    
    if(laser.isAlive){
      laser.update();
    }
  }
  
  void checkCollision(Player player){
    if(laser.isAlive){
      laser.checkCollision(player);
    }
    super.checkCollision(player);
  }
  
  boolean checkX(){
    int direction = (speed > 0) ? RIGHT : LEFT;
    float playerCenter = player.x + player.w/2;
    if((direction == RIGHT && playerCenter > x + HAND_OFFSET_X_FORWARD) ||
        direction == LEFT && playerCenter < x + HAND_OFFSET_X_BACKWARD){
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
	// HINT: Player Detection in update()
	/*
  
	boolean checkX = ( Is facing forward AND player's center point is in front of my hand point )
					OR ( Is facing backward AND player's center point (x + w/2) is in front of my hand point )

	boolean checkY = player is less than (or equal to) 2 rows higher or lower than me

	if(checkX AND checkY){
		Is laser's cooldown ready?
			True  > Fire laser from my hand!
			False > Don't do anything
	}else{
		Keep moving!
	}

	*/

  Robot(float x, float y){
    super(x, y);
  }
}
