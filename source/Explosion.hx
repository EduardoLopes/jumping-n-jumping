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

class Explosion extends FlxSprite {

  public var tween:FlxTween;

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.explosion__png, true, 32, 32);

    animation.add('explosion', [0, 1, 2, 3, 4, 5, 6], 32, false);

    animation.play('explosion');

  }

  public function spawn(x,y){

    setPosition(x,y);

    animation.play('explosion');

  }

  override public function kill():Void{

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
