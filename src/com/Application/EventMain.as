package com.Application {
	import starling.events.Event;
	
	public class EventMain extends Event {
		
		public static const ERROR:String = "ERROR";		
		public static const GET_APP_SETTINGS:String = "GET_APP_SETTINGS";	
		
		public static const SHOW_VIEW_MAIN:String = "SHOW_VIEW_MAIN";		

		private var _functionCallback:Function;
		
		public function EventMain(type:String, data:Object=null, bubbles:Boolean=false, pFunctionCallback:Function = null) {
			super(type, bubbles, data);
			_functionCallback = pFunctionCallback;
		}
		
		public function get functionCallback():Function{
			return _functionCallback;
		}
		
	}
}