package com.Application.robotlegs.views.mainmenu {
	import starling.events.Event;
	
	public class EventViewMain extends Event {
				
		public static const CALL_TEST_SERVICE:String = "CALL_TEST_SERVICE";	
		
		public function EventViewMain(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}