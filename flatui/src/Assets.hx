package ;

import flash.display.Shape;
import flash.geom.Point;
import sx.backend.BitmapData;


@:bitmap('assets/winxp.png') class WinXPBitmap extends flash.display.BitmapData { }


/**
 * Assets for this example
 *
 */
class Assets
{

    /**
     * Get specified BitmapData
     */
    static public function getBitmapData (path:String) : BitmapData
    {
        return switch (path) {
            case 'assets/winxp.png' : new WinXPBitmap(0, 0);
            case _                  : null;
        }
    }


    /**
     * Generate bitmapdata of specified size
     */
    static public function getNoiseBitmapData (width:Int, height:Int) : BitmapData
    {
        var shapes = [
            new BitmapData(100, 100, false, 0xEEEEEE),
            new BitmapData(100, 100, false, 0xCCCCCC)
        ];

        var data = new BitmapData(width, height);
        var i = 0;
        var p = new Point(0, 0);
        while (p.x < width) {
            p.y = 0;
            while (p.y < height) {
                data.copyPixels(shapes[i], shapes[i].rect, p);

                p.y += shapes[i].height;
                i = (i + 1) % shapes.length;
            }
            i = (i + 1) % shapes.length;
            p.x += shapes[i].width;
        }

        return data;
    }

}//class Assets