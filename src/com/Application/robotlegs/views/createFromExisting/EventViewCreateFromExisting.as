package com.Application.robotlegs.views.createFromExisting {
	import starling.events.Event;
	
	public class EventViewCreateFromExisting extends Event {
				
		public static const CALL_TEST_SERVICE:String = "CALL_TEST_SERVICE";	
		public static const SHOW_SETTINGS_SCREEN:String = "SHOW_SETTINGS_SCREEN";	
		public static const CREATE_NEW_LIST:String = "CREATE_NEW_LIST";	
		
		public function EventViewCreateFromExisting(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}