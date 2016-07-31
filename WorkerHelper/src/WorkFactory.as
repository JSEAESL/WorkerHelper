/**
 * Created by Administrator on 2016/7/31.
 */
package {
public class WorkFactory {
    public function WorkFactory() {
    }

    public static const WORK_WAIT:String = "work_wait";
    public static const WORK_OGG_ENCODE:String = "work_ogg_encode";
    public static var WrokList:Array = [];
    public static function creatWork(Work:String):*
    {
        switch(Work)
        {
            case WORK_OGG_ENCODE:
                    var work:WorkPrimordialOggEncode = new WorkPrimordialOggEncode();
                    WrokList.push(work);
                    return work;
                break;
        }
    }
}
}
