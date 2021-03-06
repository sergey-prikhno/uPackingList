package com.Application.robotlegs.views.open{
	import starling.events.Event;
	
	public class EventViewOpen extends Event {
				
		public static const GET_VOOPEN_LIST_DATA:String = "GET_VOOPEN_LIST_DATA";
		public static const CREATE_NEW_LIST_FROM_EXISTING:String = "CREATE_NEW_LIST_FROM_EXISTING";
		public static const EDIT_DEACTAVATE:String = "EDIT_DEACTAVATE";
		public static const EDIT_ACTAVATE:String = "EDIT_ACTAVATE";
		
		
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