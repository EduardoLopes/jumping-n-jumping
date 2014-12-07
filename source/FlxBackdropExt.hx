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

    public function updatePlayerPosition(x,y){

        playerPositionX = x;
        playerPositionY = y;

    }

    override public function draw():Void
    {

        _ppoint.x = (x - playerPositionX * scrollFactor.x) % _scrollW;
        _ppoint.y = (y - playerPositionY * scrollFactor.y) % _scrollH;

        super.draw();

    }
}
