package {

import flash.display.Sprite;
import flash.events.Event;
import flash.system.MessageChannel;
import flash.system.Worker;
import flash.utils.ByteArray;

public class WorkerOggEncode extends Sprite {

    private var PrimordialBack:MessageChannel;
    private var HelpWorkBack:MessageChannel;

    private var oggEncodeByteArray:ByteArray;
    public function WorkerOggEncode() {
        if(!Worker.current.isPrimordial)
        {

            HelpWorkBack = Worker.current.getSharedProperty("HelpWorkBack");
            PrimordialBack = Worker.current.getSharedProperty("PrimordialBack");
            oggEncodeByteArray = Worker.current.getSharedProperty("dimByte");

            oggEncode = new OggEncode();
            oggEncode.addEventListener(Event.COMPLETE,onAllComplete);
            oggEncode.toDecode(oggEncodeByteArray)
        }
    }

    private var oggEncode:OggEncode;
    private function onAllComplete(e:Event):void
    {
        PrimordialBack.send("onAllComplete");
        PrimordialBack.send(oggEncode.decodedBytes);
        oggEncode.removeEventListener(Event.COMPLETE,onAllComplete);
    }

}
}
