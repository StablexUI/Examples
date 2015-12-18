package;

import sx.flatui.FlatUITheme;
import sx.Sx;


/**
 * Entry point
 *
 */
class Main
{

    /**
     * Entry point
     */
    static public function main () : Void
    {
        Sx.pixelSnapping = true;
        Sx.theme = new FlatUITheme();
        Sx.init(run);
    }


    /**
     * App entry point after StablexUI initialization
     */
    static public function run () : Void
    {
        var alerter = new Alerter();
        alerter.button.text = 'Surprise me';

        Sx.root.addChild(alerter);
    }

}//class Main