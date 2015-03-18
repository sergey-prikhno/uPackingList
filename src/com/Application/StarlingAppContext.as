package com.Application {
	import com.Application.robotlegs.controller.CommandCallTestService;
	import com.Application.robotlegs.controller.CommandCreateNewList;
	import com.Application.robotlegs.controller.CommandMainFunctionCallback;
	import com.Application.robotlegs.controller.CommandSetNewListName;
	import com.Application.robotlegs.controller.service.CommandServiceError;
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.Model;
	import com.Application.robotlegs.model.managerPopup.EventManagerPopup;
	import com.Application.robotlegs.model.managerPopup.IManagerPopup;
	import com.Application.robotlegs.model.managerPopup.ManagerPopup;
	import com.Application.robotlegs.services.test.IServiceTest;
	import com.Application.robotlegs.services.test.ServiceTest;
	import com.Application.robotlegs.views.main.EventViewMain;
	import com.Application.robotlegs.views.main.MediatorViewMain;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.settings.MediatorViewSettings;
	import com.Application.robotlegs.views.settings.ViewSettings;
	import com.Application.robotlegs.views.welcome.MediatorViewWelcome;
	import com.Application.robotlegs.views.welcome.ViewWelcome;
	import com.http.robotlegs.events.EventServiceAbstract;
	
	import org.robotlegs.starling.mvcs.Context;
	
	import starling.display.DisplayObjectContainer;
	
	public class StarlingAppContext extends Context {
		
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
		public function StarlingAppContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true){
			super(contextView, autoStartup);
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function startup():void {
			//Mediator MAP
			mediatorMap.mapView(Main, MediatorMain);
			mediatorMap.mapView(ViewMain, MediatorViewMain);
			mediatorMap.mapView(ViewWelcome, MediatorViewWelcome);
			mediatorMap.mapView(ViewSettings, MediatorViewSettings);
		
			
			injector.mapSingletonOf(IModel, Model);
			injector.mapSingletonOf(IManagerPopup, ManagerPopup);
					
			//Services
			injector.mapSingletonOf(IServiceTest, ServiceTest);
						
			//Command MAP									
			commandMap.mapEvent(EventServiceAbstract.ERROR, CommandServiceError, EventServiceAbstract);
			commandMap.mapEvent(EventViewMain.CALL_TEST_SERVICE, CommandCallTestService, EventViewMain);
			commandMap.mapEvent(EventMain.GET_APP_SETTINGS, CommandMainFunctionCallback, EventMain);
			commandMap.mapEvent(EventViewMain.CREATE_NEW_LIST, CommandCreateNewList, EventViewMain);
			commandMap.mapEvent(EventManagerPopup.SET_NEW_LIST_NAME, CommandSetNewListName, EventManagerPopup);
			
		
			super.startup();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
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