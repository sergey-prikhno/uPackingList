package com.Application.robotlegs.views {
	import starling.events.Event;
	
	public class EventViewAbstract extends Event {
		
		
		public static const UPDATE_SETTINGS:String = "UPDATE_SETTINGS";
		public static const GET_APP_SETTINGS:String = "GET_APP_SETTINGS";
		
		public static const ERROR:String = "ERROR";
		
		private var _functionCallback:Function;
		
		public function EventViewAbstract(type:String, bubbles:Boolean=false, data:Object=null,pFunctionCallback:Function = null)	{
			super(type, bubbles, data);
			_functionCallback = pFunctionCallback;
		}
		
		
		public function get functionCallback():Function{
			return _functionCallback;
		}
		
		
	}
}