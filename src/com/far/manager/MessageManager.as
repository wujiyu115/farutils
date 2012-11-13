package badyoo.badYooFrameWork.core
{

    public class MessageManager extends Object
    {
        private var _this:MessageCore;

        public function MessageManager()
        {
            this._this = MessageCore.getInstance();
            return;
        } 

        public function dispatchMessage(Message:String, ... args) : void
        {
            this._this.sendMessageCore(Message, args);
            return;
        } 

        public function addMessageListener(Message:String, Fun:Function) : void
        {
            this._this.collectMessageCore(Message, Fun);
            return;
        } 

        public function removeMessageListener(Message:String, fun:Function) : void
        {
            this._this.removeMessageCore(Message, fun);
            return;
        }// end function

    }
}
