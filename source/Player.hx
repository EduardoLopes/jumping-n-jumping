package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Player extends FlxSprite {

  public var canMove = true;
  public var touchFloorTween:Dynamic = null;

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.player__png, true, 16, 16);

    collisonXDrag = true;
    drag.x = drag.y = 740;
    acceleration.y = 1600;
    maxVelocity.set(200, 800);

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);

  }

  private var gamepad(get, never):FlxGamepad;
  private function get_gamepad():FlxGamepad
  {
    var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
    if (gamepad == null)
    {
      // Make sure we don't get a crash on neko when no gamepad is active
      gamepad = FlxG.gamepads.getByID(0);
    }
    return gamepad;
  }

  private function movement():Void
  {

    var up:Bool = false;
    var down:Bool = false;
    var left:Bool = false;
    var right:Bool = false;
    var shootButton:Bool = false;
    var jumpButton:Bool = false;
    var bunnyHopJump:Bool = false;

    acceleration.x = 0;

    down = FlxG.keys.anyPressed(["DOWN", "S"]);
    left = FlxG.keys.anyPressed(["LEFT", "A"]);
    right = FlxG.keys.anyPressed(["RIGHT", "D"]);
    shootButton = FlxG.keys.anyPressed(["X"]);
    jumpButton = FlxG.keys.anyJustPressed(["Z"]);
    bunnyHopJump = FlxG.keys.anyPressed(["Z"]);

    if(justTouched(FlxObject.FLOOR)){

        scale.set(1.5, 0.5);
        touchFloorTween = FlxTween.tween(scale, { x: 1, y: 1 }, 0.1, { ease:FlxEase.sineOut } );

    }

    if(left || right || jumpButton || shootButton #if !flash || gamepad.dpadLeft || gamepad.dpadRight || gamepad.pressed(2) #end) {
      if(left #if !flash || gamepad.dpadLeft #end){

        acceleration.x -= drag.x;
        facing = FlxObject.LEFT;

      } else if(right #if !flash || gamepad.dpadRight #end ){

        acceleration.x += drag.x;
        facing = FlxObject.RIGHT;

      }
       //isTouching(FlxObject.FLOOR)
      if ((jumpButton #if !flash || gamepad.justPressed(2) #end )){

       jump();

      }

    }

    if ( !isTouching(FlxObject.FLOOR) && velocity.y < -170 && velocity.y > -220 && (bunnyHopJump #if !flash || gamepad.pressed(2) #end)){

      velocity.y -= 20;

    }

  }

  public function jump():Void{

    velocity.y = -350;

    touchFloorTween.cancel();

    scale.set(0.6, 1.5);
    FlxTween.tween(scale, { x: 1, y: 1 }, 0.4, { ease:FlxEase.sineOut } );

  }

  override public function destroy():Void
  {
    super.destroy();
  }


  override public function update():Void
  {

    if(canMove){
      movement();
    }

    super.update();

  }

}
