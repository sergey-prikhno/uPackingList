package com.Application.robotlegs.views.main {
	import com.Application.robotlegs.model.vo.VOMainMenu;
	import com.Application.robotlegs.model.vo.VOOpenList;
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
						
		}
		
		
		override public function onRemove():void {
			super.onRemove();
					
			removeViewListener(EventRenderer.CLICK, _handlerRendererClick, EventRenderer);		
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
		private function _handlerRendererClick(event:EventRenderer):void{
			var pVO:VOMainMenu = VOMainMenu(event.payload);
			if(view.resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.newList") == pVO.title){
				dispatch(new EventViewAbstract(EventViewAbstract.CREATE_NEW_LIST));
			}
			if(view.resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.openList") == pVO.title){
				var pVOOpen:VOOpenList = new VOOpenList();
				pVOOpen.isOpen = true;
				dispatch(new EventViewAbstract(EventViewAbstract.OPEN_LIST, pVOOpen));
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