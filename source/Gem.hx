package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Gem extends FlxSprite {

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.gem__png, true, 16, 16);

    width = 10;
    height = 10;
    offset.set(3, 3);

    drag.x = drag.y = 740;
    maxVelocity.set(200, 800);

  }

  override public function destroy():Void
  {

    super.destroy();

  }


  override public function update():Void
  {

    angle += 4;

    super.update();


  }

}
