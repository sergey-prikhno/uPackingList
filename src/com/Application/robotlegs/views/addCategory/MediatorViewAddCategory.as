package com.Application.robotlegs.views.addCategory {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	import com.Application.robotlegs.views.addItem.ViewAddItem;
	
	public class MediatorViewAddCategory extends MediatorViewAbstract {
		
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
		public function MediatorViewAddCategory() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
			
					
			addViewListener(EventViewAbstract.ADD_NEW_CATEGORY, _handlerAddNewCategory, EventViewAbstract);
			
			
			dispatch(new EventViewAbstract(EventViewAbstract.GET_DEFAULT_CATEGORIES, false, null, _setCategories));
		}
		
		
		override public function onRemove():void {
			super.onRemove();
			
			removeViewListener(EventViewAbstract.ADD_NEW_CATEGORY, _handlerAddNewCategory, EventViewAbstract);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewAddCategory{
			return ViewAddCategory(viewComponent);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function _setCategories(pData:Vector.<VOPackedItem>):void{			
			if(pData && pData.length > 0){
				view.defaultCategories = pData;
			}			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerAddNewCategory(event:EventViewAbstract):void{
			dispatch(event);
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