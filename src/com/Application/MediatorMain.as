package com.Application {
	import com.http.robotlegs.model.modelLoading.EventActorLoader;
	
	import org.robotlegs.starling.mvcs.Mediator;
	
	public class MediatorMain extends Mediator 	{		
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
		public function MediatorMain() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void {
			super.onRegister();
			
			addContextListener(EventActorLoader.LOADING_STARTED, _handlerLoadingEventService, EventActorLoader);
			addContextListener(EventActorLoader.LOADING_FINISHED, _handlerLoadingEventService, EventActorLoader);	
			
		}			
		
		
		override public function onRemove():void {
			super.onRemove();
			
			
			removeContextListener(EventActorLoader.LOADING_STARTED, _handlerLoadingEventService, EventActorLoader);
			removeContextListener(EventActorLoader.LOADING_FINISHED, _handlerLoadingEventService, EventActorLoader);
		}		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():Main{
			return Main(viewComponent);
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
		private function _handlerLoadingEventService(event:EventActorLoader):void{			
			
			if(event.type == EventActorLoader.LOADING_STARTED){
				view.addLoader();
			}
			
			if(event.type == EventActorLoader.LOADING_FINISHED){
				view.removeLoader();
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