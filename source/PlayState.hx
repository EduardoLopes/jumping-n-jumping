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
import flixel.system.FlxSound;
import flixel.addons.display.FlxBackdrop;

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
  public var explosions:FlxTypedGroup<Explosion>;
  public var gemCount:Int = 0;
  public var gemCountText:FlxText;
  public var spikes:FlxTypedGroup<Spike>;
  public var timeToReapear:Float = 0;
  public var searchingPlaceForGem = true;
  public var bullets:FlxTypedGroup<Bullet>;
  public var spawnSpikes:SpawnSpike;
  public var levelManager:LevelManager;
  public var looseSound:FlxSound;
  public var powerUpSound:FlxSound;
  public var background:FlxBackdropExt;
  public var background2:FlxBackdropExt;
  public var background3:FlxBackdropExt; //fog
  public var background4:FlxBackdropExt; //fog 2


  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {

    FlxG.mouse.visible = false;

    background2 = new FlxBackdropExt('assets/images/background2.png', 0.05, 0.05, false, false);
    add(background2);

    background3 = new FlxBackdropExt('assets/images/fog.png', 0.03, 0.03, true, false);
    add(background3);

    background = new FlxBackdropExt('assets/images/background.png', 0.1, 0.1, false, false);
    add(background);

    background4 = new FlxBackdropExt('assets/images/fog2.png', 0.08, 0.08, true, true);
    add(background4);

    looseSound = FlxG.sound.load(AssetPaths.loose__wav, .4);
    powerUpSound = FlxG.sound.load(AssetPaths.powerup__wav, .4);

    level = new TiledLevel("assets/maps/map-1.tmx");

    add(level.foregroundTiles);
    add(level.backgroundTiles);

    spikes = new FlxTypedGroup<Spike>();
    spikes.maxSize = 20;
    add(spikes);

    jumpText = new FlxTypedGroup<JumpText>();
    jumpText.maxSize = 8;
    add(jumpText);

    cannons = new FlxTypedGroup<Cannon>();
    cannons.maxSize = 4;
    add(cannons);

    bullets = new FlxTypedGroup<Bullet>();
    bullets.maxSize = 5;
    add(bullets);

    explosions = new FlxTypedGroup<Explosion>();
    explosions.maxSize = 20;
    add(explosions);

    SpawnExplosions.explosions = explosions;

    spawnSpikes = new SpawnSpike(spikes);
    add(spawnSpikes);

    levelManager = new LevelManager();
    add(levelManager);

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

      //SpawnExplosions.spawn(T.x,T.y, true);

      T.kill();

    });
  }

  public function resetLevel(){
    looseSound.play();
    levelManager.currentIndex = 0;
    gemCount = 0;
    timeToReapear = 0;
    player.jumpsCount = 3;
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

    background.updatePlayerPosition(player.x, player.y);
    background2.updatePlayerPosition(player.x, player.y);
    background3.updatePlayerPosition(player.x, player.y);
    background4.updatePlayerPosition(player.x, player.y);


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
      SpawnExplosions.spawn(bullet.x,bullet.y, true, 'explosion');

      resetLevel();

    });

    FlxG.overlap(gem, player, function(gem, player){

      gem.colected = true;
      gem.kill();

      powerUpSound.play();

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
