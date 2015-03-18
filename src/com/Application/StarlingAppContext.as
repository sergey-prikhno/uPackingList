package com.Application {
	import com.Application.robotlegs.controller.CommandCreateNewList;
	import com.Application.robotlegs.controller.CommandMainFunctionCallback;
	import com.Application.robotlegs.controller.CommandSetNewListName;
	import com.Application.robotlegs.controller.service.CommandServiceError;
	import com.Application.robotlegs.controller.service.settings.CommandUpdateSettings;
	import com.Application.robotlegs.controller.service.sql.init.CommandConfigureModel;
	import com.Application.robotlegs.controller.service.sql.init.CommandConfigureSql;
	import com.Application.robotlegs.controller.service.sql.init.CommandCreateDB;
	import com.Application.robotlegs.controller.service.sql.init.CommandSettingConfigured;
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.Model;
	import com.Application.robotlegs.model.managerPopup.EventManagerPopup;
	import com.Application.robotlegs.model.managerPopup.IManagerPopup;
	import com.Application.robotlegs.model.managerPopup.ManagerPopup;
	import com.Application.robotlegs.services.categories.IServiceCategories;
	import com.Application.robotlegs.services.categories.ServiceCategories;
	import com.Application.robotlegs.services.dbCreator.IServiceDBCreator;
	import com.Application.robotlegs.services.dbCreator.ServiceDBCreator;
	import com.Application.robotlegs.services.settings.EventServiceSettings;
	import com.Application.robotlegs.services.settings.IServiceSettings;
	import com.Application.robotlegs.services.settings.ServiceSettings;
	import com.Application.robotlegs.services.test.IServiceTest;
	import com.Application.robotlegs.services.test.ServiceTest;
	import com.Application.robotlegs.views.EventViewAbstract;
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
			injector.mapSingletonOf(IServiceDBCreator, ServiceDBCreator);
			injector.mapSingletonOf(IServiceSettings, ServiceSettings);
			injector.mapSingletonOf(IServiceCategories, ServiceCategories);
						
			//Command MAP									
			commandMap.mapEvent(EventServiceAbstract.ERROR, CommandServiceError, EventServiceAbstract);			
			commandMap.mapEvent(EventViewAbstract.GET_APP_SETTINGS, CommandMainFunctionCallback, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.UPDATE_SETTINGS, CommandUpdateSettings, EventViewAbstract);
			commandMap.mapEvent(EventViewMain.CREATE_NEW_LIST, CommandCreateNewList, EventViewMain);
			commandMap.mapEvent(EventManagerPopup.SET_NEW_LIST_NAME, CommandSetNewListName, EventManagerPopup);
			
			commandMap.mapEvent(EventMain.INITIALIZE_DATABASE, CommandConfigureSql, EventMain);
			commandMap.mapEvent(EventMain.CONFIGURE_DATABASE, CommandCreateDB, EventMain);
			commandMap.mapEvent(EventMain.CONFIGURE_MODEL, CommandConfigureModel, EventMain);
			commandMap.mapEvent(EventServiceSettings.FIRST_SETTINGS_LOADED, CommandSettingConfigured, EventServiceSettings);
		
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