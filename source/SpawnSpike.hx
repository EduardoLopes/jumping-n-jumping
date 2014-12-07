package;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;

class SpawnSpike extends FlxObject {

  public var spikesLayouts:Array<Array<Int>> = [];
  public var spikes:FlxTypedGroup<Spike>;
  public var index:Int = 0;
  public var timeToNext:Float = 0.2;
  public var time:Float = 0;
  public var layout = 0;

  public function new (Spikes){

    super();

    spikes = Spikes;

    spikesLayouts[0] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    spikesLayouts[1] = [0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0];
    spikesLayouts[2] = [0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,1,1,1,0,0];
    spikesLayouts[3] = [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0];
    spikesLayouts[4] = [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0];

  }

  public function setLayout(layoutID){

    remove();

    layout = layoutID;
    index = 0;
    time = 0;

  }

  public function remove(){

    spikes.forEach(function(T){

      T.kill();

    });

  }


  override public function destroy():Void
  {

    super.destroy();

  }


  override public function update():Void
  {

    super.update();

    time += FlxG.elapsed;

    if(time >= timeToNext && index < spikesLayouts[layout].length - 1){

      if(spikesLayouts[layout][index] == 1){

        spikes.recycle(Spike).spawn(index * 16, FlxG.height - 32, 'up');
        time = 0;
      }

      index++;
    }

  }

}
