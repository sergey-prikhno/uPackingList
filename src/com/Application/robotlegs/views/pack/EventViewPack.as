package com.Application.robotlegs.views.pack{
	import starling.events.Event;
	
	public class EventViewPack extends Event {
				
		//public static const GET_VOOPEN_LIST_DATA:String = "GET_VOOPEN_LIST_DATA";
		
		
		private var _functionCallback:Function;
		
		public function EventViewPack(type:String, bubbles:Boolean=false, data:Object=null,pFunctionCallback:Function = null)	{
			super(type, bubbles, data);
			_functionCallback = pFunctionCallback;
		}
		
		public function get functionCallback():Function{
			return _functionCallback;
		}
	}
}