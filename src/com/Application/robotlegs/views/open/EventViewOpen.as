package com.Application.robotlegs.views.open{
	import starling.events.Event;
	
	public class EventViewOpen extends Event {
				
		public static const GET_VOOPEN_LIST_DATA:String = "GET_VOOPEN_LIST_DATA";
		
		
		private var _functionCallback:Function;
		
		public function EventViewOpen(type:String, bubbles:Boolean=false, data:Object=null,pFunctionCallback:Function = null)	{
			super(type, bubbles, data);
			_functionCallback = pFunctionCallback;
		}
		
		public function get functionCallback():Function{
			return _functionCallback;
		}
	}
}