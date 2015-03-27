package com.Application.robotlegs.services.bluetooth{
	import starling.events.Event;
	
	public class EventServiceBluetooth extends Event{
		
		//public static const INSERTED:String = "INSERTED";
		
		public function EventServiceBluetooth(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}