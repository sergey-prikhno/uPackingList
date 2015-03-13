package com.Application.robotlegs.views.welcome {
	import starling.events.Event;
	
	public class EventViewWelcome extends Event {
	
		public static const CALL_TEST_SERVICE:String = "CALL_TEST_SERVICE";	
		
		public function EventViewWelcome(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}