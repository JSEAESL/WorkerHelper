/**
 * Created by Administrator on 2016/7/31.
 */
package {
import flash.events.Event;
import flash.system.MessageChannel;
import flash.system.Worker;
import flash.system.WorkerDomain;
import flash.utils.ByteArray;

public class WorkPrimordialOggEncode {
    public function WorkPrimordialOggEncode()
    {
    }

    private var endFun:Function;
    public function setEncodeBackFun(callFun:Function):void
    {
        endFun = callFun;
    }

    [Embed(source="../WorkSwf/WorkerOggEncodeSwf/WorkerOggEncode.swf", mimeType="application/octet-stream")]
    private  var Worker_ByteClass:Class;
    private var PrimordialBack:MessageChannel;
    private var HelpWorkBack:MessageChannel;
    public function oggEncode(byte:ByteArray):void
    {
        if(Worker.current.isPrimordial)
        {
            var worker:Worker = WorkerDomain.current.createWorker(new Worker_ByteClass as ByteArray);
            PrimordialBack = worker.createMessageChannel(Worker.current);
            PrimordialBack.addEventListener(Event.CHANNEL_MESSAGE, onMessage);

            HelpWorkBack = worker.createMessageChannel(worker);

            byte.shareable = true;
            worker.setSharedProperty("HelpWorkBack", HelpWorkBack);
            worker.setSharedProperty("PrimordialBack", PrimordialBack);
            worker.setSharedProperty("dimByte", byte);
            worker.start();
        }
    }

    public function get DecodedBytes():ByteArray
    {
        return _DecodedBytes
    }

    private var _DecodedBytes:ByteArray;
    private function onMessage(e:Event):void
    {
        var mess:String = PrimordialBack.receive();
        if(mess == "onAllComplete" )
        {
            _DecodedBytes = PrimordialBack.receive();
            if(mess == "onAllComplete" && null != endFun)
            {
                endFun.call();
            }
        }

    }
}
}
