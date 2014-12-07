package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.system.FlxSound;


class Bullet extends FlxSprite {

  public var colected:Bool;
  public var nextPosition:FlxPoint;
  public var speed:Int = 240;
  public var shootSound:FlxSound;

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.bullet__png, true, 16, 16);

    shootSound = FlxG.sound.load(AssetPaths.shoot__wav, .4);

    width = 15;
    height = 15;
    offset.set(1, 1);

  }

  public function shootLeft(x, y){

    setPosition(x, Std.int(y) - (height / 2));

    velocity.x = speed;
    velocity.y = 0;

    shootSound.play();

  }

  public function shootRight(x,y){

    setPosition(x, Std.int(y) - (height / 2));

    velocity.x = -speed;
    velocity.y = 0;

    shootSound.play();


  }

  override public function destroy():Void
  {

    super.destroy();

  }


  override public function update():Void
  {

    if(!isOnScreen()){
      kill();
    }

    angle += 6;
    super.update();

  }

}
