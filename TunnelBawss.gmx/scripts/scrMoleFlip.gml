if(self.timer > 10){
    self.direction = 1 - self.direction
    if(self.direction > 0){
        x -= self.flipOffset
        image_xscale = 1
    } else {
        x += self.flipOffset
        image_xscale = -1
    }
    self.timer = 0
}
