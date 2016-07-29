/**
 * Created by admin on 2016/7/29.
 */
package {
import flash.system.MessageChannel;
import flash.system.Worker;
import flash.system.WorkerDomain;
import flash.utils.ByteArray;

public class Waiter {

    [Embed(source="../WorkSwf/WorkerWait.swf", mimeType="application/octet-stream")]
    private static var WaitWorker_ByteClass:Class;
    public static function wait(time:Number):void
    {
        var worker:Worker = WorkerDomain.current.createWorker(new WaitWorker_ByteClass as ByteArray);
        var inChannel:MessageChannel = worker.createMessageChannel(Worker.current);
        worker.setSharedProperty("channel", inChannel);
        worker.setSharedProperty("time", time);
        worker.start();
        inChannel.receive(true);
    }
}
}
