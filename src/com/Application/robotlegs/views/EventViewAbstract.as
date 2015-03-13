package com.Application.robotlegs.views {
	import starling.events.Event;
	
	public class EventViewAbstract extends Event {
		
		
		public static const ERROR:String = "ERROR";
		
		public function EventViewAbstract(type:String, bubbles:Boolean=false, data:Object=null)	{
			super(type, bubbles, data);
		}
		
	}
}