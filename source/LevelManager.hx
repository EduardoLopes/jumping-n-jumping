package;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;

class LevelManager extends FlxObject {

  //the worst name for a var ever
  public var currentSet:Bool;
  public var when:Int = 0;
  public var index:Int = 0;
  public var currentIndex:Int = 0;
  public var callbacks:Array<Dynamic> = [];
  public var lastCalled:Int = 0;

  public function new (){

    super();

  }

  public function registerLevel(cb){

    callbacks[index] = cb;

    index++;

  }

  public function callLevel(index){

    lastCalled = index;
    callbacks[index]();

  }

  override public function destroy():Void
  {

    super.destroy();

  }


  override public function update():Void
  {

    super.update();

    if(lastCalled != currentIndex){
      callLevel(currentIndex);
    }

  }

}
