package com.Application.robotlegs.views.packedList {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.services.categories.EventServiceCategories;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	
	public class MediatorViewPackedList extends MediatorViewAbstract {		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function MediatorViewPackedList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
			
			addContextListener(EventServiceCategories.UPDATED, _handlerUpdated, EventServiceCategories);
			
		
			
			addViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract); 
			
			dispatch(new EventViewAbstract(EventViewAbstract.GET_PACKED_ITEMS, false, null, _setPackedItems));
		}
		
		
		override public function onRemove():void {
			super.onRemove();
			
			removeContextListener(EventServiceCategories.UPDATED, _handlerUpdated, EventServiceCategories);
			
			removeViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract);
		}
		
	
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewPackedList{
			return ViewPackedList(viewComponent);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function _setPackedItems(value:Vector.<VOPackedItem>):void {
			view.items = value;
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerUpdateItemDB(event:EventViewAbstract):void{
			event.stopPropagation();						
			dispatch(new EventViewAbstract(EventViewAbstract.UPDATE_DB_PACKED_ITEM, false, event.data));
		}
		
		private function _handlerUpdated(event:EventServiceCategories):void{
			view.update(VOPackedItem(event.data));			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}