package com.Application.robotlegs.views.main {
	import starling.events.Event;
	
	public class EventViewMain extends Event {
				
		public static const CALL_TEST_SERVICE:String = "CALL_TEST_SERVICE";	
		public static const SHOW_SETTINGS_SCREEN:String = "SHOW_SETTINGS_SCREEN";	
		
		public function EventViewMain(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}