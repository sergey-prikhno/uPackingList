package com.Application.robotlegs.views.start {
	import starling.events.Event;
	
	public class EventViewStart extends Event {
	
		public static const CALL_TEST_SERVICE:String = "CALL_TEST_SERVICE";	
		
		public function EventViewStart(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}