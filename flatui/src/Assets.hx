package ;

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

}//class Assets