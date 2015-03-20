package com.Application.robotlegs.views.popups.removeItem
{	
	
	import starling.events.Event;
	
	public class EventPopupRemoveItem extends starling.events.Event {
		
		public static const YES:String = "YES";
		public static const NO:String = "NO";
		
		public function EventPopupRemoveItem(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}