package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.group.FlxTypedGroup;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  public var level:TiledLevel;
  public var player:Player;
  public var gem:Gem;
  public var jumpText:FlxTypedGroup<JumpText>;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {

    FlxG.mouse.visible = false;

    level = new TiledLevel("assets/maps/map-1.tmx");

    add(level.foregroundTiles);
    add(level.backgroundTiles);

    jumpText = new FlxTypedGroup<JumpText>();
    jumpText.maxSize = 20;
    add(jumpText);

    level.loadObjects(this);

    //add(new FlxText(16, 2, 0, "3 / 3", 8));

//    hud = new HUD();
//    add(hud);

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
      player.jumpsCount += 3;
      //player.maxJumps = 1;

      player.textColor = 0x95dc83;

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
