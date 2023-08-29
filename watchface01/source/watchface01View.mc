import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;


var myfont = null;
var lfont = null;
var mfont = null;
var bground = null;


class watchface01View extends WatchUi.WatchFace {

    function onTimer() {WatchUi.requestUpdate();}

    function initialize() {WatchFace.initialize();}

    function onLayout(dc as Dc) as Void {
        myfont = Toybox.WatchUi.loadResource(Rez.Fonts.myfont);
        lfont = Toybox.WatchUi.loadResource(Rez.Fonts.lfont);
        mfont = Toybox.WatchUi.loadResource(Rez.Fonts.mfont);
        bground = Toybox.WatchUi.loadResource(Rez.Drawables.bground);
    }

    function onUpdate(dc as Dc) as Void {

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        dc.drawBitmap(0, 0, bground);

        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);
        dc.drawText(88, 68, lfont, timeString, Graphics.TEXT_JUSTIFY_CENTER);

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var todayLong = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateString = Lang.format(
        "$1$$2$$3$",
        [
            today.year,
            today.month.format("%02d"),
            today.day.format("%02d"),
        ]);
        dc.drawText(87, 55, myfont, todayLong.day_of_week.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(88, 120, mfont, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        var myStats = System.getSystemStats();
        dc.drawText(144, 20, myfont, myStats.batteryInDays.format("%02d") + "D", Graphics.TEXT_JUSTIFY_CENTER);
        


        var bat = myStats.battery.toNumber() % 20;
        var adj = (bat < 10) ? - bat : 20 - bat;
        var rounded = myStats.battery + adj;
        rounded = (rounded > 21) ? (rounded/20 -1) * 10 : rounded/20 ;
        dc.setPenWidth(10);
        dc.drawLine(10, 112, 10, 112 - rounded);

    }

}
