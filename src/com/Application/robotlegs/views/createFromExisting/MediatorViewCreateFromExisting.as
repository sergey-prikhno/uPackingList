package com.Application.robotlegs.views.createFromExisting{
	import com.Application.robotlegs.model.vo.VOMainMenu;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	import com.Application.robotlegs.views.components.renderers.EventRenderer;
	import com.common.Constants;
	
	public class MediatorViewCreateFromExisting extends MediatorViewAbstract {		
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
		public function MediatorViewCreateFromExisting() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
			
			addViewListener(EventViewCreateFromExisting.CALL_TEST_SERVICE, _handlerCallTestService, EventViewCreateFromExisting);
			addViewListener(EventRenderer.CLICK, _handlerRendererClick, EventRenderer);
		}
		
		
		override public function onRemove():void {
			super.onRemove();
		
			removeViewListener(EventViewCreateFromExisting.CALL_TEST_SERVICE, _handlerCallTestService, EventViewCreateFromExisting);
			removeViewListener(EventViewCreateFromExisting.CREATE_NEW_LIST, _handlerRendererClick, EventViewCreateFromExisting);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewMain{
			return ViewMain(viewComponent);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerCallTestService(event:EventViewCreateFromExisting):void{
			dispatch(event);
		}
		
		private function _handlerRendererClick(event:EventRenderer):void{
			var pVO:VOMainMenu = VOMainMenu(event.payload);
			if(view.resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.newList") == pVO.title){
				dispatch(new EventViewCreateFromExisting(EventViewCreateFromExisting.CREATE_NEW_LIST));
			}
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