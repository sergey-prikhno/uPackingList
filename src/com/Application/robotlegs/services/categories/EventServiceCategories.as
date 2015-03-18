package com.Application.robotlegs.services.categories
{
	import starling.events.Event;
	
	public class EventServiceCategories extends Event
	{		
		public static const FIRST_CATEGORIES_LOADED:String = "FIRST_CATEGORIES_LOADED";
		
		public function EventServiceCategories(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}