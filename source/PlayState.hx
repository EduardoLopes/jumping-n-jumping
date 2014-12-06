package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  public var level:TiledLevel;
  public var player:Player;
  public var gem:Gem;
  public var jumpText:FlxTypedGroup<JumpText>;
  public var gemCount:Int = 0;
  public var gemCountText:FlxText;
  public var lastGemPosition:FlxPoint;
  public var timeToReapear:Float = 0;

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

    lastGemPosition = new FlxPoint(0,0);

    lastGemPosition.x = Std.int(gem.x);
    lastGemPosition.y = Std.int(gem.y);

    gemCountText = new FlxText(0, 16, FlxG.width, Std.string(gemCount), 20);
    gemCountText.setFormat(null, 20, 0xFFFFFF, "center", FlxText.BORDER_OUTLINE_FAST, 0x131c1b);

    add(gemCountText);


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

    super.update();

    timeToReapear += FlxG.elapsed;

    level.collideWithLevel(player, function(obj1, obj2){

      //trace('a');

    });

    FlxG.overlap(gem, player, function(gem, player){

      gem.colected = true;
      gem.kill();

      timeToReapear = 0;

      gemCount += 1;

      player.velocity.y = 0;
      player.jumpsCount += 3;

      player.textColor = 0x95dc83;

      gemCountText.text = Std.string(gemCount);

      player.jump();

    });

    if(timeToReapear > 0.2 && gem.colected){

      gem.colected = false;

      gem.revive();

      gem.x = FlxRandom.floatRanged(0, FlxG.width, [player.x]);
      gem.y = FlxRandom.floatRanged(0, FlxG.height, [player.y]);

      if(level.checkTile(gem.x, gem.y, gem.width, gem.height)){

        gem.x = FlxRandom.floatRanged(0, FlxG.width, [player.x]);
        gem.y = FlxRandom.floatRanged(0, FlxG.height, [player.y]);

      };

    }

  }
}
