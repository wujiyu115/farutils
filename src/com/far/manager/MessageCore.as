package badyoo.badYooFrameWork.core
{
    import flash.utils.*;

    public class MessageCore extends Object
    {
        private var MessageArray:Dictionary;
        private static var Instance:MessageCore;

        public function MessageCore()
        {
            this.MessageArray = new Dictionary(true);
            return;
        } 

        public function sendMessageCore(Message:String, array:Array) : void
        {
            if (!this.MessageArray[Message])
            {
                return;
            }
            var _loc_3:int = 0;
            var _loc_4:* = this.MessageArray[Message];
            var _loc_5:* = _loc_4.length;
            if (array.length == 0)
            {
                if (_loc_5 > 0)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _loc_5)
                    {
                        
                        if (_loc_4[_loc_3].length == 0)
                        {
                            var _loc_6:* = _loc_4;
                            _loc_6._loc_4[_loc_3]();
                        }
                        else
                        {
                            throw new Error("MessageCore ::: 信息\"" + Message + "\"的回调函数参数个数不正确，当前有" + (_loc_4[_loc_3] as Function).length + "个，应有" + array.length + "个");
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
            }
            else if (_loc_5 > 0)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_5)
                {
                    
                    if ((_loc_4[_loc_3] as Function).length != array.length)
                    {
                        throw new Error("MessageCore ::: 信息\"" + Message + "\"的回调函数参数个数不正确，当前有" + (_loc_4[_loc_3] as Function).length + "个，应有" + array.length + "个");
                    }
                    (_loc_4[_loc_3] as Function).apply(null, array);
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        } 

        public function collectMessageCore(Message:String, Fun:Function) : void
        {
            var _loc_3:Array = null;
            if (this.MessageArray[Message])
            {
                _loc_3 = this.MessageArray[Message];
                if (_loc_3.indexOf(Fun) != -1)
                {
                    throw new Error("MessageCore ::: 回调函数已被同名的message \"" + Message + " \"注册过");
                }
                _loc_3[_loc_3.length] = Fun;
                return;
            }
            var _loc_4:* = new Array();
            _loc_3 = new Array();
            this.MessageArray[Message] = _loc_4;
            _loc_3[_loc_3.length] = Fun;
            return;
        } 

        public function removeMessageCore(Message:String, fun:Function) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            if (!this.MessageArray[Message])
            {
                return;
            }
            _loc_3 = this.MessageArray[Message];
            _loc_4 = _loc_3.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (_loc_3[_loc_5] == fun)
                {
                    _loc_3.splice(_loc_5, 1);
                    if (_loc_4 < 1)
                    {
                        this.MessageArray[Message] = null;
                        delete this.MessageArray[Message];
                    }
                    return;
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        } 

        public static function getInstance() : MessageCore
        {
            if (Instance == null)
            {
                Instance = new MessageCore;
                return Instance;
            }
            return Instance;
        } 

    }
}
