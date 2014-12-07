package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Spike extends FlxSprite {

  public var direction:String = 'up';
  public var initialPosition:FlxPoint;
  public var delay = 1;
  public var tween:FlxTween;

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.spikes__png, true, 16, 16);

    height = 7;
    offset.set(0, 9);


    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.DOWN, false, true);

    animation.frameIndex = FlxRandom.intRanged(0,1);
    immovable = true;
  }

  public function spawn(x,y, direction){

    SpawnExplosions.spawn(x,y, true);

    if(direction == 'up'){
       y = y + 11;
       initialPosition = FlxPoint.weak(x,y);
       facing = FlxObject.UP;
       tween = FlxTween.tween(this, {y: initialPosition.y + 7}, 0.2, { type:FlxTween.PINGPONG, ease:FlxEase.elasticInOut, loopDelay: 1, startDelay: delay} );
    }

    setPosition(x,y);

  }

  override public function kill():Void{

    //SpawnExplosions.spawn(x,y, true);

    super.kill();

    tween.cancel();

  }

  override public function destroy():Void
  {

    super.destroy();

  }


  override public function update():Void
  {

    super.update();


  }

}
