package com.Application.robotlegs.views.popups.listScratch{
	import starling.events.Event;

	public class EventPopupCreateListScratch extends Event{
		
		
		
		public static const CLOSE_POPUP_CREATE:String = "CLOSE_POPUP_CREATE";
		public static const POPUP_CREATE_SET_NAME:String = "POPUP_CREATE_SET_NAME";
		
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventPopupCreateListScratch(type:String, pPayload:Object=null,pBubbles:Boolean=false,pFunctionCallback:Function = null) {
			super(type, pBubbles);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}
		
		
	}
}