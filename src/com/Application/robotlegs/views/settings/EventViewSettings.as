package com.Application.robotlegs.views.settings{
	import starling.events.Event;
	
	public class EventViewSettings extends Event {
				
		public static const CALL_TEST_SERVICE:String = "CALL_TEST_SERVICE";	
		public static const SHOW_SETTINGS_SCREEN:String = "SHOW_SETTINGS_SCREEN";	
		
		public function EventViewSettings(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}