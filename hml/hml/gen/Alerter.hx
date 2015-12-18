package ;

import sx.properties.Orientation;
import sx.properties.Align.HorizontalAlign;
import sx.properties.Align.VerticalAlign;
import sx.properties.Align.NoneAlign;
import sx.properties.metric.Units;

class Alerter extends sx.widgets.VBox {

    var popup_initialized:Bool = false;

    @:isVar var popup(get, set):sx.widgets.Popup;

    var button_initialized:Bool = false;

    @:isVar public var button(get, set):sx.widgets.Button;

    public function destroyHml():Void {
        
    }
    

    function set_popup(value:sx.widgets.Popup):sx.widgets.Popup {
        popup_initialized = true;
        return popup = value;
    }

    inline function get_text__0():sx.widgets.Text {
        /* hml/xml/Alerter.xml:4 characters: 13-17 */
        var res = new sx.widgets.Text();
        /* hml/xml/Alerter.xml:4 characters: 19-23 */
        res.text = 'Surprise!!!';
        return res;
    }

    inline function get_button__0():sx.widgets.Button {
        /* hml/xml/Alerter.xml:5 characters: 13-19 */
        var res = new sx.widgets.Button();
        /* hml/xml/Alerter.xml:5 characters: 36-43 */
        res.onClick.add(function(__0, __1, __2) {
            popup.close();
        });
        /* hml/xml/Alerter.xml:5 characters: 21-25 */
        res.text = 'Close';
        return res;
    }

    function get_popup():sx.widgets.Popup {
        /* hml/xml/Alerter.xml:3 characters: 9-14 */
        if (popup_initialized) return popup;
        popup_initialized = true;
        this.popup = new sx.widgets.Popup();
        var res = this.popup;
        /* hml/xml/Alerter.xml:3 characters: 27-30 */
        res.gap = 20;
        res.addChild(get_text__0());
        res.addChild(get_button__0());
        return res;
    }

    function set_button(value:sx.widgets.Button):sx.widgets.Button {
        button_initialized = true;
        return button = value;
    }

    function get_button():sx.widgets.Button {
        /* hml/xml/Alerter.xml:9 characters: 5-11 */
        if (button_initialized) return button;
        button_initialized = true;
        this.button = new sx.widgets.Button();
        var res = this.button;
        /* hml/xml/Alerter.xml:9 characters: 45-52 */
        res.onClick.add(function(__0, __1, __2) {
            popup.show();
        });
        /* hml/xml/Alerter.xml:9 characters: 25-29 */
        res.text = 'Show alert';
        return res;
    }

    public function new() {
        /* hml/xml/Alerter.xml:1 characters: 1-5 */
        super();
        /* hml/xml/Alerter.xml:1 characters: 7-12 */
        this.width.pct = 100;
        /* hml/xml/Alerter.xml:1 characters: 20-26 */
        this.height.pct = 100;
        this.addChild(button);
    }

    




        
}
