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
  public var cannons:FlxTypedGroup<Cannon>;
  public var gemCount:Int = 0;
  public var gemCountText:FlxText;
  public var spikes:FlxTypedGroup<Spike>;
  public var timeToReapear:Float = 0;
  public var searchingPlaceForGem = true;
  public var bullets:FlxTypedGroup<Bullet>;
  public var spawnSpikes:SpawnSpike;
  public var levelManager:LevelManager;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {

    FlxG.mouse.visible = false;

    level = new TiledLevel("assets/maps/map-1.tmx");

    spikes = new FlxTypedGroup<Spike>();
    spikes.maxSize = 20;
    add(spikes);

    add(level.foregroundTiles);
    add(level.backgroundTiles);

    jumpText = new FlxTypedGroup<JumpText>();
    jumpText.maxSize = 20;
    add(jumpText);

    cannons = new FlxTypedGroup<Cannon>();
    cannons.maxSize = 4;
    add(cannons);

    bullets = new FlxTypedGroup<Bullet>();
    bullets.maxSize = 10;
    add(bullets);

    spawnSpikes = new SpawnSpike(spikes);
    add(spawnSpikes);

    levelManager = new LevelManager();
    add(levelManager);

    //add(new Explosion(150,150));

    //0
    levelManager.registerLevel(function(){

      spawnSpikes.setLayout(0);

      spawnSpikes.remove();
      killCannons();

    });

    //1
    levelManager.registerLevel(function(){

      killCannons();

      if(FlxRandom.chanceRoll()){
        cannons.recycle(Cannon, [bullets]).spawnRight();
      } else {
        cannons.recycle(Cannon, [bullets]).spawnLeft();
      }


    });

    //2
    levelManager.registerLevel(function(){

      spawnSpikes.setLayout(1);

      killCannons();

      if(FlxRandom.chanceRoll()){
        cannons.recycle(Cannon, [bullets]).spawnRight();
      } else {
        cannons.recycle(Cannon, [bullets]).spawnLeft();
      }


    });

    //3
    levelManager.registerLevel(function(){
      spawnSpikes.setLayout(2);

      killCannons();

      if(FlxRandom.chanceRoll()){
        cannons.recycle(Cannon, [bullets]).spawnRight();
      } else {
        cannons.recycle(Cannon, [bullets]).spawnLeft();
      }


    });

    //4
    levelManager.registerLevel(function(){

      spawnSpikes.setLayout(3);

      killCannons();

      cannons.recycle(Cannon, [bullets]).spawnRight();
      cannons.recycle(Cannon, [bullets]).spawnLeft();

    });

    //5
    levelManager.registerLevel(function(){

      spawnSpikes.setLayout(4);

      killCannons();

      cannons.recycle(Cannon, [bullets]).spawnRight();
      cannons.recycle(Cannon, [bullets]).spawnLeft();

    });

    gemCountText = new FlxText(0, 16, FlxG.width, Std.string(gemCount), 20);
    gemCountText.setFormat(null, 20, 0xFFFFFF, "center", FlxText.BORDER_OUTLINE_FAST, 0x131c1b);

    add(gemCountText);

    level.loadObjects(this);


    super.create();

  }

  public function killCannons()
  {
    cannons.forEach(function(T){

      T.kill();

    });
  }

  public function resetLevel(){
    levelManager.currentIndex = 0;
    gemCount = 0;
    timeToReapear = 0;
    gem.nextPosition.x = FlxRandom.floatRanged(0, FlxG.width, [player.x]);
    gem.nextPosition.y = FlxRandom.floatRanged(0, FlxG.height, [player.y]);
    gemCountText.text = Std.string(gemCount);
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

    FlxG.overlap(player, spikes, function(player, spike){

      resetLevel();

    });

    super.update();

    switch (gemCount)
    {
      case 2:
        levelManager.currentIndex = 1;

      case 6:
        levelManager.currentIndex = 2;

      case 8:
        levelManager.currentIndex = 3;

      case 10:
        levelManager.currentIndex = 4;

      case 12:
        levelManager.currentIndex = 5;

    }

    if(gemCount > 2){



    }

    timeToReapear += FlxG.elapsed;

    level.collideWithLevel(player, function(obj1, obj2){

      //trace('a');

    });



    FlxG.overlap(player, bullets, function(player, bullet){

      bullet.kill();

      resetLevel();

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

        searchingPlaceForGem = false;

        gem.nextPosition.x = FlxRandom.floatRanged(0, FlxG.width, [player.x]);
        gem.nextPosition.y = FlxRandom.floatRanged(0, FlxG.height, [player.y]);

        if(level.checkTile(gem.nextPosition.x, gem.nextPosition.y, gem.width, gem.height)){

          gem.nextPosition.x = FlxRandom.floatRanged(0, FlxG.width, [player.x]);
          gem.nextPosition.y = FlxRandom.floatRanged(0, FlxG.height, [player.y]);

          searchingPlaceForGem = true;

        };

        if(!searchingPlaceForGem){

          gem.colected = false;

          gem.x = gem.nextPosition.x;
          gem.y = gem.nextPosition.y;

          gem.revive();

        }

      }

    }

}
