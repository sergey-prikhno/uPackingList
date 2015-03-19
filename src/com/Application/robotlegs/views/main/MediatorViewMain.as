package com.Application.robotlegs.views.main {
	import com.Application.robotlegs.model.vo.VOMainMenu;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	import com.Application.robotlegs.views.components.renderers.EventRenderer;
	import com.common.Constants;
	
	public class MediatorViewMain extends MediatorViewAbstract {		
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
		public function MediatorViewMain() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
						
			addViewListener(EventRenderer.CLICK, _handlerRendererClick, EventRenderer);
			
			addViewListener(EventViewAbstract.GET_CATEGORY_DATA, _handlerGetPachedItems, EventViewAbstract);
		}
		
		
		override public function onRemove():void {
			super.onRemove();
					
			removeViewListener(EventViewMain.CREATE_NEW_LIST, _handlerRendererClick, EventViewMain);
			
			
			removeViewListener(EventViewAbstract.GET_CATEGORY_DATA, _handlerGetPachedItems, EventViewAbstract);
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
		private function _handlerCallTestService(event:EventViewMain):void{
			dispatch(event);
		}
		
		private function _handlerRendererClick(event:EventRenderer):void{
			var pVO:VOMainMenu = VOMainMenu(event.payload);
			if(view.resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.newList") == pVO.title){
				dispatch(new EventViewMain(EventViewMain.CREATE_NEW_LIST));
			}
		}
		
		private function _handlerGetPachedItems(event:EventViewAbstract):void{
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