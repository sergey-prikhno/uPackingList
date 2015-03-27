package com.Application.robotlegs.views.settings{
	import starling.events.Event;
	
	public class EventViewSettings extends Event {
				
		public static const SHOW_VIEW_MAIN_SCREEN:String = "SHOW_VIEW_MAIN_SCREEN";	
		public static const USE_BLUETOOTH:String = "USE_BLUETOOTH";	
		
		public function EventViewSettings(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}