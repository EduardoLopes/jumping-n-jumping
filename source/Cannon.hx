package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Cannon extends FlxSprite {

  public var colected:Bool;
  public var nextPosition:FlxPoint;
  public var speed:Int = 60;
  public var bullets:FlxTypedGroup<Bullet>;
  public var shootTime:Float = 0;

  public function new (bullet){
    super();
    loadGraphic(AssetPaths.cannon__png, true, 32, 32);

    bullets = bullet;


    width = 32;
    height = 26;
    offset.set(0, 3);

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);

    velocity.y = speed;

  }

  public function spawnLeft(){

    setPosition(16, FlxRandom.floatRanged(16, FlxG.height - 16));


    SpawnExplosions.spawn(x,y, false);

    facing = FlxObject.LEFT;

    if(FlxRandom.chanceRoll()){

      velocity.y = speed;

    } else {

      velocity.y = -speed;

    }


  }

  public function spawnRight(){

    setPosition(FlxG.width - 48, FlxRandom.floatRanged(16, FlxG.height - 16));

    facing = FlxObject.RIGHT;

    SpawnExplosions.spawn(x,y, false);

    if(FlxRandom.chanceRoll()){

      velocity.y = speed;

    } else {

      velocity.y = -speed;

    }

  }

  override public function destroy():Void
  {

    super.destroy();

  }


  override public function update():Void
  {

    shootTime += FlxG.elapsed;

    if(y <= 16){
      velocity.y = speed;
    } else if(y + height >= FlxG.height - 16) {
      velocity.y = -speed;
    }

    if(shootTime > 1){

      if(FlxRandom.chanceRoll(40)){

        if(facing == FlxObject.RIGHT){
          bullets.recycle(Bullet).shootRight(x, getMidpoint().y);
        }

        if(facing == FlxObject.LEFT){
          bullets.recycle(Bullet).shootLeft(x, getMidpoint().y);
        }

        scale.set(1.3, 1);
        FlxTween.tween(scale, { x: 1, y: 1 }, 0.2, { ease:FlxEase.sineOut } );
  //      setPosition(x+16,y);
  //      FlxTween.tween(this, { x: x-16}, 0.2, { ease:FlxEase.sineOut } );

      }

      shootTime = 0;

    }

    super.update();




  }

}
