/**
 * Created by admin on 2016/7/29.
 */
package {
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getTimer;

public class WorkTest extends Sprite {
    public function WorkTest() {
        super();



        if (stage)
        {
            init();
        }
        else
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }

    private function init():void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        traceTime();
        Waiter.wait(1000);
        traceTime();
        Waiter.wait(2000);
        traceTime();
        Waiter.wait(3000);
        traceTime();
    }

    private function traceTime():void
    {
        trace("time : " + getTimer());
    }
}
}
