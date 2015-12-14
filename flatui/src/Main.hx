package ;

import flash.events.Event;
import flash.Lib;
import sx.backend.BitmapData;
import sx.groups.RadioGroup;
import sx.layout.LineLayout;
import sx.properties.Align;
import sx.transitions.FadeTransition;
import sx.Sx;
import sx.skins.*;
import sx.flatui.*;
import sx.widgets.*;


using Std;


/**
 * Flash backend example
 *
 */
class Main
{
    /** Tabs to select `viewStack` page */
    static private var menu : TabBar;
    /** View stack to switch components demos */
    static private var viewStack : ViewStack;


    /**
     * Entry point
     */
    static public function main () : Void
    {
        Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        Lib.current.stage.align     = flash.display.StageAlign.TOP_LEFT;

        // Sx.dipFactor  = 0.7;
        Sx.pixelSnapping = true;
        Sx.theme = new FlatUITheme();
        Sx.addInitTask(function(cb:Void->Void) haxe.Timer.delay(cb, 1000));
        Sx.init(run);
    }


    /**
     * Run application
     */
    static public function run () : Void
    {
        buildGui();

        var pages = [
            'Buttons'        => buttons(),
            'Toggle Buttons' => toggleButtons(),
            'Text Inputs'    => textInputs(),
            'Progress Bars'  => progressBars(),
            'Sliders'        => sliders(),
            'Checkboxes'     => checkBoxes(),
            'Radio Toggles'  => radios(),
            'Scroll'         => scroll(),
            'Skins'          => skins(),
            'Popup'          => popup(),
            'Callout'        => callout()
        ];

        //to ensure pages maintain order on each application run.
        var sorted = [for (pageName in pages.keys()) pageName];
        sorted.sort(Reflect.compare);

        for (pageName in sorted) {
            menu.createTab(pageName).name = pageName;

            var page = pages.get(pageName);
            page.name = pageName;
            page.width.pct  = 100;
            page.height.pct = 100;
            page.skin = whiteSkin();
            viewStack.addChild(page);
        }
    }


    /**
     * Create tabs & view stack
     */
    static private function buildGui () : Void
    {
        menu = new TabBar();
        menu.style = TabBarStyle.VERTICAL;

        viewStack = new ViewStack();
        viewStack.width.pct  = 100;
        viewStack.height.pct = 100;
        viewStack.transition = new FadeTransition();
        viewStack.transition.duration = 0.2;

        var adjustViewStack = function () {
            viewStack.left    = menu.width;
            viewStack.width.pct = 100 * (1 - (menu.width / Sx.root.width));
        }

        menu.viewStack = viewStack;
        menu.onResize.add(function(_,_,_,_) adjustViewStack());
        menu.onInitialize.add(function(_) adjustViewStack());

        Sx.root.addChild(viewStack);
        Sx.root.addChild(menu);

        checkStageSize();
    }


    /**
     * Show alert if device screen is too small
     */
    static public function checkStageSize () : Void
    {
        if (Sx.stageWidth.px >= 670 && Sx.stageHeight.px >= 380) {
            return;
        }

        var popup = new Popup();

        var message = new Text();
        message.text = 'This application is designed for bigger displays. Some content may not fit your screen.';
        message.width = 200;
        message.height = 80;

        var button = new Button();
        button.text = 'OK';
        button.onTrigger.add(function(b) popup.close());

        popup.addChild(message);
        popup.addChild(button);

        popup.show();
    }


    /**
     * Creates white skin to use as opaque background
     */
    static private function whiteSkin () : Skin
    {
        var skin = new PaintSkin();
        skin.color = 0xFFFFFF;
        skin.corners = 16;

        return skin;
    }


    /**
     * Description
     */
    static public function buttons () : Widget
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;

        var btn = new Button();
        btn.text = 'Default Button';
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Warning Button';
        btn.style = ButtonStyle.WARNING;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Danger Button';
        btn.style = ButtonStyle.DANGER;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Success Button';
        btn.style = ButtonStyle.SUCCESS;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Inverse Button';
        btn.style = ButtonStyle.INVERSE;
        box.addChild(btn);

        var btn = new Button();
        btn.text = 'Info Button';
        btn.style = ButtonStyle.INFO;
        btn.ico = Icons.infoCircle();
        box.addChild(btn);

        return box;
    }


    /**
     * Description
     */
    static public function textInputs () : Widget
    {
        var box = new VBox();
        box.gap = 20;

        var row = new HBox();
        row.gap = 10;
        row.padding = 10;

        var input = new TextInput();
        input.invitation = 'Default Input';
        row.addChild(input);

        var input = new TextInput();
        input.style = TextInputStyle.SUCCESS;
        input.invitation = 'Success Input';
        row.addChild(input);

        var input = new TextInput();
        input.style = TextInputStyle.ERROR;
        input.invitation = 'Error Input';
        row.addChild(input);

        box.addChild(row);

        var row = new HBox();
        row.gap = 10;
        row.padding = 10;

        var input = new TextInput();
        input.applyStyle();
        input.style = null;
        input.invitation = 'Search';
        input.padding.left = FlatUITheme.DEFAULT_ICO_SIZE + 10;
        var icon = Icons.search(FlatUITheme.DEFAULT_ICO_SIZE, FlatUITheme.COLOR_SILVER_DARK);
        icon.offset.top.pct = -50;
        icon.top.pct = 50;
        icon.left = 5;
        input.addChild(icon);
        row.addChild(input);

        var input = new TextInput();
        input.style = TextInputStyle.SUCCESS;
        input.invitation = 'Type message';
        input.padding.left = FlatUITheme.DEFAULT_ICO_SIZE + 10;
        var icon = Icons.chat(FlatUITheme.DEFAULT_ICO_SIZE, FlatUITheme.COLOR_EMERALD);
        icon.offset.top.pct = -50;
        icon.top.pct = 50;
        icon.left = 5;
        input.addChild(icon);
        row.addChild(input);

        var input = new TextInput();
        input.style = TextInputStyle.ERROR;
        input.invitation = 'Invalid value';
        input.padding.right = FlatUITheme.DEFAULT_ICO_SIZE + 10;
        var icon = Icons.alertCircle(FlatUITheme.DEFAULT_ICO_SIZE, FlatUITheme.COLOR_PUMPKIN);
        icon.offset.top.pct = -50;
        icon.top.pct = 50;
        icon.right = 5;
        input.addChild(icon);
        row.addChild(input);

        box.addChild(row);

        return box;
    }


    /**
     * Description
     */
    static public function progressBars () : Widget
    {
        function randomValue (p:ProgressBar) return p.min + (0.2 + 0.6 * Math.random()) * (p.max - p.min);

        var box = new VBox();
        box.gap     = 20;
        box.padding = 10;

        var tip = new Text();
        tip.text = 'Click bars to change values';
        box.addChild(tip);

        var progress = new ProgressBar();
        progress.value  = randomValue(progress);
        progress.interactive = true;
        box.addChild(progress);

        var progress = new ProgressBar();
        progress.style = ProgressBarStyle.WARNING;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        progress.bar.right.select();
        box.addChild(progress);

        var hbox = new HBox();
        hbox.gap = 30;
        hbox.padding = 10;

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.DANGER_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        hbox.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.SUCCESS_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        hbox.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.INVERSE_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        progress.bar.top.select();
        hbox.addChild(progress);

        var progress = new ProgressBar();
        progress.style  = ProgressBarStyle.INFO_VERTICAL;
        progress.value  = randomValue(progress);
        progress.interactive = true;
        progress.bar.top.select();
        hbox.addChild(progress);

        box.addChild(hbox);

        var randomize = new Button();
        randomize.text = 'Randomize values';
        randomize.onTrigger.add(function(_) {
            var child, bar;
            for (parent in [box, hbox]) {
                for (i in 0...parent.numChildren) {
                    child = parent.getChildAt(i);
                    if (Std.is(child, ProgressBar)) {
                        bar = cast(child, ProgressBar);
                        bar.value = randomValue(bar);
                    }
                }
            }
        });
        box.addChild(randomize);

        return box;
    }


    /**
     * Description
     */
    static public function sliders () : Widget
    {
        function randomValue (p:Slider) return p.min + (0.2 + 0.6 * Math.random()) * (p.max - p.min);

        var box = new VBox();
        box.gap     = 20;
        box.padding = 10;

        var slider = new Slider();
        slider.value  = randomValue(slider);
        box.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.WARNING;
        slider.value  = randomValue(slider);
        slider.thumb.right.select();
        box.addChild(slider);

        var hbox = new HBox();
        hbox.gap = 30;
        hbox.padding = 10;

        var slider = new Slider();
        slider.style  = SliderStyle.DANGER_VERTICAL;
        slider.value  = randomValue(slider);
        hbox.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.SUCCESS_VERTICAL;
        slider.value  = randomValue(slider);
        hbox.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.INVERSE_VERTICAL;
        slider.value  = randomValue(slider);
        slider.thumb.top.select();
        hbox.addChild(slider);

        var slider = new Slider();
        slider.style  = SliderStyle.INFO_VERTICAL;
        slider.value  = randomValue(slider);
        slider.thumb.top.select();
        hbox.addChild(slider);

        box.addChild(hbox);

        var randomize = new Button();
        randomize.text = 'Randomize values';
        randomize.onTrigger.add(function(_) {
            var child, slider;
            for (parent in [box, hbox]) {
                for (i in 0...parent.numChildren) {
                    child = parent.getChildAt(i);
                    if (Std.is(child, Slider)) {
                        slider = cast(child, Slider);
                        slider.value = randomValue(slider);
                    }
                }
            }
        });
        box.addChild(randomize);

        return box;
    }


    /**
     * Description
     */
    static public function toggleButtons () : Widget
    {
        var box = new VBox();
        box.padding = 10;
        box.gap = 10;

        var btn = new ToggleButton();
        btn.up.text = 'Default';
        btn.down.text = 'Default selected';
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Warning';
        btn.down.text = 'Warning selected';
        btn.style = ButtonStyle.WARNING;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Danger';
        btn.down.text = 'Danger selected';
        btn.style = ButtonStyle.DANGER;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Success';
        btn.down.text = 'Success selected';
        btn.style = ButtonStyle.SUCCESS;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Inverse';
        btn.down.text = 'Inverse selected';
        btn.style = ButtonStyle.INVERSE;
        box.addChild(btn);

        var btn = new ToggleButton();
        btn.text = 'Info';
        btn.down.text = 'Info selected';
        btn.style = ButtonStyle.INFO;
        box.addChild(btn);

        return box;
    }


    /**
     * Description
     */
    static public function checkBoxes () : Widget
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;
        box.align = Left & Top;

        var check = new CheckBox();
        check.text = 'Default';
        check.selected = true;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Warning';
        check.style = CheckBoxStyle.WARNING;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Danger';
        check.style = CheckBoxStyle.DANGER;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Success';
        check.selected = true;
        check.style = CheckBoxStyle.SUCCESS;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Inverse';
        check.style = CheckBoxStyle.INVERSE;
        box.addChild(check);

        var check = new CheckBox();
        check.text = 'Info';
        check.selected = true;
        check.style = CheckBoxStyle.INFO;
        box.addChild(check);

        var container = new VBox();
        container.addChild(box);

        return container;
    }


    /**
     * Description
     */
    static public function radios () : Widget
    {
        var box = new VBox();
        box.gap = 10;
        box.padding = 10;
        box.align = Left & Top;

        var group = new RadioGroup();

        var radio = new Radio();
        radio.text = 'Default';
        radio.selected = true;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Warning';
        radio.style = RadioStyle.WARNING;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Danger';
        radio.style = RadioStyle.DANGER;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Success';
        radio.style = RadioStyle.SUCCESS;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Inverse';
        radio.style = RadioStyle.INVERSE;
        radio.group = group;
        box.addChild(radio);

        var radio = new Radio();
        radio.text = 'Info';
        radio.style = RadioStyle.INFO;
        radio.group = group;
        box.addChild(radio);

        var container = new VBox();
        container.addChild(box);

        return container;
    }


    /**
     * Description
     */
    static public function scroll () : Widget
    {
        var bmp = new Bmp();
        bmp.bitmapData = Assets.getNoiseBitmapData(1000, 1000);

        var scroll = new Scroll();
        scroll.width  = 400;
        scroll.height = 300;
        scroll.addChild(bmp);
        scroll.scrollX = 0.5 * scroll.getMaxScrollX();
        scroll.scrollY = 0.5 * scroll.getMaxScrollY();

        var vertical = new CheckBox();
        vertical.selected = true;
        vertical.text = 'Vertical scrolling';
        vertical.onToggle.add(function(b) scroll.verticalScroll = vertical.selected);

        var horizontal = new CheckBox();
        horizontal.selected = true;
        horizontal.text = 'Horizontal scrolling';
        horizontal.onToggle.add(function(b) scroll.horizontalScroll = horizontal.selected);

        var checks = new HBox();
        checks.gap = 30;
        checks.addChild(horizontal);
        checks.addChild(vertical);

        var box = new VBox();
        box.gap = 10;
        box.addChild(checks);
        box.addChild(scroll);

        return box;
    }


    /**
     * Description
     */
    static public function skins () : Widget
    {
        var container = new Widget();
        container.width = 200;
        container.height = 200;

        var widget = new Widget();
        widget.width  = 100;
        widget.height = 100;
        widget.top = 30;
        widget.left = 30;

        var slice9 = new Slice9Skin();
        slice9.bitmapData = Assets.getBitmapData('assets/winxp.png');
        slice9.slice = [5, 10, 32, 48];
        widget.skin = slice9;
        container.addChild(widget);

        var tile = new TileSkin();
        tile.bitmapData = Assets.getBitmapData('assets/winxp.png');

        var hSlider = new Slider();
        hSlider.min = 60;
        hSlider.max = 160;
        hSlider.value = widget.width;
        hSlider.left = 30;
        hSlider.onChange.add(function(s) widget.width = s.value);
        container.addChild(hSlider);

        var vSlider = new Slider();
        vSlider.style = SliderStyle.VERTICAL;
        vSlider.min = 60;
        vSlider.max = 160;
        vSlider.value = widget.height;
        vSlider.top = 30;
        vSlider.thumb.top.select();
        vSlider.onChange.add(function(s) widget.height = s.value);
        container.addChild(vSlider);

        var group = new RadioGroup();
        var radioBox = new HBox();
        radioBox.gap = 20;

        var radio = new Radio();
        radio.selected = true;
        radio.text = '9-Slice';
        radio.group = group;
        radio.onToggle.add(function(toggle) if (toggle.selected) widget.skin = slice9);
        radioBox.addChild(radio);

        var radio = new Radio();
        radio.text = 'Tiling';
        radio.group = group;
        radio.onToggle.add(function(toggle) if (toggle.selected) widget.skin = tile);
        radioBox.addChild(radio);

        var box = new VBox();
        box.gap = 20;

        box.addChild(radioBox);
        box.addChild(container);

        return box;
    }


    /**
     * Description
     */
    static public function popup () : Widget
    {
        var title = new Text();
        title.text = 'Very important notification!';
        var closeButton = new Button();
        closeButton.text = 'Got it!';

        var popup = new Popup();
        popup.gap = 30;
        popup.addChild(title);
        popup.addChild(closeButton);
        closeButton.onTrigger.add(function(_) popup.close());

        var showButton = new Button();
        showButton.text = 'Show popup';
        showButton.onTrigger.add(function (_) popup.show());

        var box = new VBox();
        box.addChild(showButton);

        return box;
    }


    /**
     * Description
     */
    static public function callout () : Widget
    {
        var callout = new Callout();
        callout.gap = 5;

        var title = new Text();
        title.style = TextStyle.LIGHT;
        title.text = 'Very important information!';

        var closeButton = new Button();
        closeButton.applyStyle();
        closeButton.style = null;
        closeButton.padding = 5;
        closeButton.autoSize = true;
        closeButton.text = 'Ok!';
        closeButton.onTrigger.add(function(b) callout.close());

        callout.addChild(title);
        callout.addChild(closeButton);

        var showButton = new Button();
        showButton.text = 'Show callout';
        showButton.onTrigger.add(function(b) callout.show(b));

        var box = new VBox();
        box.addChild(showButton);

        return box;
    }

}//class Main