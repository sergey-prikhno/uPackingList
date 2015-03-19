package com.Application.robotlegs.services.categories {
	import starling.events.Event;
	
	public class EventServiceCategories extends Event {
		
		
		public static const LOADED:String = "LOADED";
		public static const UPDATED:String = "UPDATED";
		
		public function EventServiceCategories(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}