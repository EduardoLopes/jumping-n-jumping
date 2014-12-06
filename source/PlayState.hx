package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  public var level:TiledLevel;
  public var player:Player;
  public var gem:Gem;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {

    FlxG.mouse.visible = false;

    level = new TiledLevel("assets/maps/map-1.tmx");

    add(level.foregroundTiles);
    add(level.backgroundTiles);

    level.loadObjects(this);

    super.create();

  }

  /**
   * Function that is called when this state is destroyed - you might want to
   * consider setting all objects this state uses to null to help garbage collection.
   */
  override public function destroy():Void
  {
    super.destroy();
  }

  /**
   * Function that is called once every frame.
   */
  override public function update():Void
  {

    level.collideWithLevel(player, function(obj1, obj2){

      //trace('a');

    });

    FlxG.overlap(gem, player, function(gem, player){

      player.velocity.y = 0;

      player.jump();

      gem.x = FlxRandom.intRanged(0, FlxG.width);
      gem.y = FlxRandom.intRanged(0, FlxG.height);

    });

    if(level.checkTile(gem.x, gem.y, gem.width, gem.height)){

      gem.x = FlxRandom.intRanged(0, FlxG.width);
      gem.y = FlxRandom.intRanged(0, FlxG.height);

    };

    super.update();
  }
}
