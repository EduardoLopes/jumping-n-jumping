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
import flixel.system.FlxSound;
import flixel.util.FlxDestroyUtil;

class Spike extends FlxSprite {

  public var direction:String = 'up';
  public var initialPosition:FlxPoint;
  public var delay = 1;
  public var tween:FlxTween;
  public var spikeSound:FlxSound;

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.spikes__png, true, 16, 16);

    height = 7;
    offset.set(0, 9);

    //spikeSound = FlxG.sound.load(AssetPaths.spike__wav, .4);
    //spikeSound.proximity(x,y,FlxG.camera.target, 1);

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.DOWN, false, true);

    animation.frameIndex = FlxRandom.intRanged(0,1);
    immovable = true;
  }

  public function spawn(x,y, direction){

    SpawnExplosions.spawn(x,y, true, 'appear');

    if(direction == 'up'){
       y = y + 11;
       initialPosition = FlxPoint.weak(x,y);
       facing = FlxObject.UP;
       tween = FlxTween.tween(this, {y: initialPosition.y + 16}, 0.2, { type:FlxTween.PINGPONG, ease:FlxEase.elasticInOut, loopDelay: 1, startDelay: delay, complete:finishSpike} );
    }

    setPosition(x,y);

  }

  private function finishSpike(T:FlxTween):Void
  {

    //spikeSound.play(true);

  }


  override public function kill():Void{

    //SpawnExplosions.spawn(x,y, true);

    super.kill();

    tween.cancel();

  }

  override public function destroy():Void
  {

    super.destroy();

    spikeSound = FlxDestroyUtil.destroy(spikeSound);

  }


  override public function update():Void
  {

    super.update();


  }

}
