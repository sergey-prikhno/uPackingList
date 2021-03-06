package com.Application.robotlegs.views.packedList {
	import com.Application.Main;
	import com.Application.robotlegs.model.EventModel;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOScreenID;
	import com.Application.robotlegs.model.vo.VOTableName;
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
			addContextListener(EventServiceCategories.REMOVED, _handlerRemoved, EventServiceCategories);			
			
			addViewListener(EventViewAbstract.REMOVE_PACKED_ITEM, _handlerRemoveItemDB, EventViewAbstract);			
			addViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract); 
			addViewListener(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, _handlerUpdateItemOrderIndexDB, EventViewAbstract);
			
			
			addViewListener(EventViewPackedList.ADD_NEW_CATEGORY, _handlerAddNewCategory, EventViewPackedList);
			addViewListener(EventViewPackedList.ADD_NEW_ITEM, _handlerAddNewItem, EventViewPackedList);
						
			
			dispatch(new EventViewAbstract(EventViewAbstract.GET_PACKED_ITEMS, false, null, _setPackedListItems));
		}
		
		
		override public function onRemove():void {
			super.onRemove();
			
			removeContextListener(EventServiceCategories.UPDATED, _handlerUpdated, EventServiceCategories);
			removeContextListener(EventServiceCategories.REMOVED, _handlerRemoved, EventServiceCategories);
			
			removeViewListener(EventViewAbstract.REMOVE_PACKED_ITEM, _handlerRemoveItemDB, EventViewAbstract);		
			removeViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract);
			removeViewListener(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, _handlerUpdateItemOrderIndexDB, EventViewAbstract);
			
			removeViewListener(EventViewPackedList.ADD_NEW_CATEGORY, _handlerAddNewCategory, EventViewPackedList);
			removeViewListener(EventViewPackedList.ADD_NEW_ITEM, _handlerAddNewItem, EventViewPackedList);
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
		private function _setPackedListItems(value:Vector.<VOPackedItem>,pTableName:VOTableName):void {
			view.items = value;
			view.tableName = pTableName;
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
		
		private function _handlerUpdateItemOrderIndexDB(event:EventViewAbstract):void{
			event.stopPropagation();						
			dispatch(new EventViewAbstract(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, false, event.data));
		}
		
		private function _handlerRemoveItemDB(event:EventViewAbstract):void{
			event.stopPropagation();						
			dispatch(new EventViewAbstract(EventViewAbstract.REMOVE_PACKED_ITEM, false, event.data));
		}
		
		
		private function _handlerUpdated(event:EventServiceCategories):void{
			view.update(VOPackedItem(event.data));			
		}
		
		private function _handlerRemoved(event:EventServiceCategories):void{
			view.removed(VOPackedItem(event.data));
		}
		
		private function _handlerAddNewCategory(event:EventViewPackedList):void{
			
			
			var pVO:VOScreenID = new VOScreenID();
				pVO.screenID = Main.VIEW_ADD_CATEGORY;
			dispatch(new EventModel(EventModel.CHANGE_APP_SCREEN, false, pVO));
		}
		
		private function _handlerAddNewItem(event:EventViewPackedList):void{
			var pVO:VOScreenID = new VOScreenID();
			pVO.screenID = Main.VIEW_ADD_ITEM;
			dispatch(new EventModel(EventModel.CHANGE_APP_SCREEN, false, pVO));
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