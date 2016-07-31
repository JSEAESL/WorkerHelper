/**
 * Created by admin on 2016/7/22.
 */
package Sound.newSoundManager {
import Sound.ogg.OggManager;
import Sound.ogg.events.OggManagerEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;

public class OggEncode extends EventDispatcher
    {
        private var _oggBytes:ByteArray;
        private var _oggManager:OggManager;
        private var $samplesPerLoop:int=8192;
        private var $delayPerLoopInMS:int=33;
        public function OggEncode()
        {
            super();
            _oggBytes = new ByteArray();
            _oggManager = new OggManager();
        }

        public function toDecode(data:*):void
        {
            _oggBytes.length = 0;
            _oggBytes.writeBytes(data);
            _oggBytes.position = 0;
            _oggManager.addEventListener(OggManagerEvent.DECODE_BEGIN, handleDecodeBegin, false, 0, true);
            _oggManager.addEventListener(OggManagerEvent.DECODE_PROGRESS, handleDecodeProgress, false, 0, true);
            _oggManager.addEventListener(OggManagerEvent.DECODE_COMPLETE, handleDecodeComplete, false, 0, true);
            _oggManager.addEventListener(OggManagerEvent.DECODE_CANCEL, handleDecodeCancel, false, 0, true);
            _oggManager.decode(_oggBytes,$samplesPerLoop,$delayPerLoopInMS,true);
        }

        private function handleDecodeBegin(e:OggManagerEvent):void
        {
            trace("handleDecodeBegin")
        }
        private function handleDecodeProgress(e:OggManagerEvent):void
        {
            trace("handleDecodeProgress")
        }

        private function handleDecodeComplete(e:OggManagerEvent):void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
        private function handleDecodeCancel(e:OggManagerEvent):void
        {
            trace("handleDecodeCancel")
        }

    }
}
