class Clock extends Item{
	// Requirement #2: Complete Clock Class
  Clock(float x, float y){
    super(x, y);
  }
	
  void display(){
    image(clock, x, y);    
  }
  
  void checkCollision(Player player){
    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){
      x = y = -1000;   
      addTime(CLOCK_BONUS_SECONDS);
    }
  }
}
