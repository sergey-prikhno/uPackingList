package com.Application.robotlegs.views {
	import starling.events.Event;
	
	public class EventViewAbstract extends Event {
		
		
		public static const UPDATE_SETTINGS:String = "UPDATE_SETTINGS";
		public static const GET_APP_SETTINGS:String = "GET_APP_SETTINGS";
		public static const GET_CATEGORY_DATA:String = "GET_CATEGORY_DATA";
		public static const GET_PACKED_ITEMS:String = "GET_PACKED_ITEMS";
		
		public static const UPDATE_DB_PACKED_ITEM:String = "UPDATE_DB_PACKED_ITEM";
		
		
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