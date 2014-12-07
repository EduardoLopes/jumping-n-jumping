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

class Explosion extends FlxSprite {

  public var tween:FlxTween;
  public var explosion:FlxSound;
  public var appear:FlxSound;

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.explosion__png, true, 32, 32);

    animation.add('explosion', [0, 1, 2, 3, 4, 5, 6], 32, false);

    animation.play('explosion');

    explosion = FlxG.sound.load(AssetPaths.explosion__wav, .4);
    appear = FlxG.sound.load(AssetPaths.appear__wav, .4);

  }

  public function spawn(x,y, scaleVariation, sound){

    if(sound == 'appear'){
      appear.play(true);
    } else {
      explosion.play(true);
    }

    var variation = FlxRandom.floatRanged(0.5, 1);
    if(scaleVariation){
      scale.set(variation, variation);
    } else {
      scale.set(1,1);
    }

    setPosition(x,y);

    animation.play('explosion');

    angle = FlxRandom.floatRanged(0,360);

  }

//  override public function kill():Void{
//
//    super.kill();
//
//    tween.cancel();
//
//  }

  override public function destroy():Void
  {

    super.destroy();

  }


  override public function update():Void
  {

    if(animation.finished){
      kill();
    }

    super.update();


  }

}
