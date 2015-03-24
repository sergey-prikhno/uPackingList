package com.Application.robotlegs.views.components.bottomMenu {
	import starling.events.Event;
	
	public class EventBottomMenu extends Event {
		
		public static const HOME:String = "HOME";
		public static const SEARCH:String = "SEARCH";
		public static const PACK:String = "PACK";
		public static const COLLAPSE:String = "COLLAPSE";
		public static const UNDO:String = "UNDO";
		public static const MAIL:String = "MAIL";
		public static const CHECK_ALL:String = "CHECK_ALL";
		
		public function EventBottomMenu(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}