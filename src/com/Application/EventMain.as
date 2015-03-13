package com.Application {
	import starling.events.Event;
	
	public class EventMain extends Event {
		
		public static const ERROR:String = "ERROR";	
		
		
		
		public function EventMain(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
		
	}
}