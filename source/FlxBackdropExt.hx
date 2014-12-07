package;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.layer.DrawStackItem;
import flixel.system.layer.Region;
import flixel.util.FlxDestroyUtil;
import flixel.util.loaders.TextureRegion;
import flixel.addons.display.FlxBackdrop;

class FlxBackdropExt extends FlxBackdrop
{

    var playerPositionX:Float;
    var playerPositionY:Float;
    var scrollX:Float = 0;

    public function updatePlayerPosition(x,y){

        playerPositionX = x;
        playerPositionY = y;

    }

    override public function draw():Void
    {

        _ppoint.x = scrollX + (x - playerPositionX * scrollFactor.x) % _scrollW;
        _ppoint.y = (y - playerPositionY * scrollFactor.y) % _scrollH;

        if (_repeatX){

            if (_ppoint.x > 0) {
                _ppoint.x -= _scrollW;
                scrollX-= _scrollW;
            }
        }

        if (_repeatY){
            scrollX+=0.2;
        }

        if (_repeatX && !_repeatY){
            scrollX+=0.1;
        }







        super.draw();

    }
}
