package;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.util.FlxRandom;

class SpawnExplosions extends FlxObject {

  public static var explosions:FlxTypedGroup<Explosion>;

  public static function spawn(x,y, scaleVariation)
  {

    explosions.recycle(Explosion).spawn(x,y, scaleVariation);

  };



  public function new (Spikes){

    super();

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
