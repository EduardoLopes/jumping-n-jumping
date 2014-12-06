package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class JumpText extends FlxText{

  public function new(){

    super();



    setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.BLACK, 1, 1);

  }

  override function update(){

    super.update();

  }

  public function finishKill(_):Void{
    if (!alive){
      return;
    }

    alive = false;
    solid = false;
  }

  public function getText(newX:Int, newY:Int, newText:String, newColor){

    //FlxTween.tween(this, { alpha:0, y: y + 16 }, 0.1, { ease:FlxEase.sineOut } );
    alpha = 1;

    setPosition(newX, newY);

    FlxTween.tween(this, { alpha:0, y: y - 16 }, 2, {ease:FlxEase.sineOut, complete:finishKill } );
    text = newText +' Jumps';
    color = newColor;
  }

}
