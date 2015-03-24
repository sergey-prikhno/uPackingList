package com.Application.robotlegs.views.open {
	import com.Application.robotlegs.model.vo.VOOpenList;
	import com.Application.robotlegs.model.vo.VOTableName;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	
	public class MediatorViewOpen extends MediatorViewAbstract {		
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
		
		private var _listData:VOTableName;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function MediatorViewOpen() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
						
			
			addViewListener(EventViewAbstract.GET_CATEGORY_DATA, _handlerGetPachedItems, EventViewAbstract);
			
			
			dispatch(new EventViewAbstract(EventViewAbstract.GET_CREATED_LISTS, false, null, _setLists));
			
		}
		
		
		override public function onRemove():void {
			super.onRemove();
					
			removeViewListener(EventViewAbstract.GET_CATEGORY_DATA, _handlerGetPachedItems, EventViewAbstract);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewOpen{
			return ViewOpen(viewComponent);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		private function _setVOOpenListData(value:VOOpenList):void {
			view.voOpenList = value;
			if(value.isOpen){
				dispatch(new EventViewAbstract(EventViewAbstract.GET_CATEGORY_DATA, false, _listData));
			}else{
				dispatch(new EventViewOpen(EventViewOpen.CREATE_NEW_LIST_FROM_EXISTING, false, _listData));
			}
		}
		
		private function _setLists(value:Vector.<VOTableName>):void {
			view.vectorLists = value;
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerGetPachedItems(event:EventViewAbstract):void{
			event.stopPropagation();
			_listData = VOTableName(event.data);
			dispatch(new EventViewOpen(EventViewOpen.GET_VOOPEN_LIST_DATA, false, null, _setVOOpenListData));
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