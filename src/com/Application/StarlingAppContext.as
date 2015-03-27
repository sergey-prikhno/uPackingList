package com.Application {
	import com.Application.robotlegs.controller.CommandAddNewList;
	import com.Application.robotlegs.controller.CommandCreateNewList;
	import com.Application.robotlegs.controller.CommandCreateNewListFromExisting;
	import com.Application.robotlegs.controller.CommandGetCreatedLists;
	import com.Application.robotlegs.controller.CommandGetDefaultCategoriesFunctionCallback;
	import com.Application.robotlegs.controller.CommandGetPackedItemsFunctionCallback;
	import com.Application.robotlegs.controller.CommandGetVOOpenList;
	import com.Application.robotlegs.controller.CommandMainFunctionCallback;
	import com.Application.robotlegs.controller.CommandSetNewListName;
	import com.Application.robotlegs.controller.CommandUpdateVOOpenList;
	import com.Application.robotlegs.controller.popup.CommandPopupRemove;
	import com.Application.robotlegs.controller.service.CommandServiceError;
	import com.Application.robotlegs.controller.service.categories.CommandAddCategory;
	import com.Application.robotlegs.controller.service.categories.CommandAddItemToCategory;
	import com.Application.robotlegs.controller.service.categories.CommandCreateCategoryItem;
	import com.Application.robotlegs.controller.service.categories.CommandRemoveCategoryItem;
	import com.Application.robotlegs.controller.service.categories.CommandSelectCategoryItem;
	import com.Application.robotlegs.controller.service.categories.CommandUpdateCategoryItem;
	import com.Application.robotlegs.controller.service.categories.CommandUpdateOrderIndexes;
	import com.Application.robotlegs.controller.service.copyList.CommandCopyListFromExisting;
	import com.Application.robotlegs.controller.service.removeList.CommandRemoveDBList;
	import com.Application.robotlegs.controller.service.settings.CommandUpdateSettings;
	import com.Application.robotlegs.controller.service.sql.init.CommandConfigureModel;
	import com.Application.robotlegs.controller.service.sql.init.CommandConfigureSql;
	import com.Application.robotlegs.controller.service.sql.init.CommandCreateDB;
	import com.Application.robotlegs.controller.service.sql.init.CommandNamesTableConfigured;
	import com.Application.robotlegs.controller.service.sql.init.CommandSettingConfigured;
	import com.Application.robotlegs.controller.service.tableNames.CommandInsertTableNames;
	import com.Application.robotlegs.model.EventModel;
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.Model;
	import com.Application.robotlegs.model.managerPopup.EventManagerPopup;
	import com.Application.robotlegs.model.managerPopup.IManagerPopup;
	import com.Application.robotlegs.model.managerPopup.ManagerPopup;
	import com.Application.robotlegs.services.categories.IServiceCategories;
	import com.Application.robotlegs.services.categories.ServiceCategories;
	import com.Application.robotlegs.services.categoriesDefault.IServiceCategoriesDefault;
	import com.Application.robotlegs.services.categoriesDefault.ServiceCategoriesDefault;
	import com.Application.robotlegs.services.copyList.IServiceCopyList;
	import com.Application.robotlegs.services.copyList.ServiceCopyList;
	import com.Application.robotlegs.services.dbCreator.IServiceDBCreator;
	import com.Application.robotlegs.services.dbCreator.ServiceDBCreator;
	import com.Application.robotlegs.services.removeList.IServiceRemoveList;
	import com.Application.robotlegs.services.removeList.ServiceRemoveList;
	import com.Application.robotlegs.services.settings.EventServiceSettings;
	import com.Application.robotlegs.services.settings.IServiceSettings;
	import com.Application.robotlegs.services.settings.ServiceSettings;
	import com.Application.robotlegs.services.tableNames.EventServiceTableNames;
	import com.Application.robotlegs.services.tableNames.IServiceTableNames;
	import com.Application.robotlegs.services.tableNames.ServiceTableNames;
	import com.Application.robotlegs.services.test.IServiceTest;
	import com.Application.robotlegs.services.test.ServiceTest;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.addCategory.MediatorViewAddCategory;
	import com.Application.robotlegs.views.addCategory.ViewAddCategory;
	import com.Application.robotlegs.views.addItem.MediatorViewAddItem;
	import com.Application.robotlegs.views.addItem.ViewAddItem;
	import com.Application.robotlegs.views.main.MediatorViewMain;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.open.EventViewOpen;
	import com.Application.robotlegs.views.open.MediatorViewOpen;
	import com.Application.robotlegs.views.open.ViewOpen;
	import com.Application.robotlegs.views.packedList.MediatorViewPackedList;
	import com.Application.robotlegs.views.packedList.ViewPackedList;
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
			mediatorMap.mapView(ViewPackedList, MediatorViewPackedList);
			mediatorMap.mapView(ViewOpen, MediatorViewOpen);
			mediatorMap.mapView(ViewAddItem, MediatorViewAddItem);
			mediatorMap.mapView(ViewAddCategory, MediatorViewAddCategory);
		
			
			injector.mapSingletonOf(IModel, Model);
			injector.mapSingletonOf(IManagerPopup, ManagerPopup);
					
			//Services
			injector.mapSingletonOf(IServiceTest, ServiceTest);
			injector.mapSingletonOf(IServiceDBCreator, ServiceDBCreator);
			injector.mapSingletonOf(IServiceSettings, ServiceSettings);
			injector.mapSingletonOf(IServiceCategoriesDefault, ServiceCategoriesDefault);
			injector.mapSingletonOf(IServiceCategories, ServiceCategories);
			injector.mapSingletonOf(IServiceTableNames, ServiceTableNames);
			injector.mapSingletonOf(IServiceCopyList, ServiceCopyList);
			injector.mapSingletonOf(IServiceRemoveList, ServiceRemoveList);
						
			//Command MAP									
			commandMap.mapEvent(EventServiceAbstract.ERROR, CommandServiceError, EventServiceAbstract);			
			commandMap.mapEvent(EventViewAbstract.GET_APP_SETTINGS, CommandMainFunctionCallback, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.UPDATE_SETTINGS, CommandUpdateSettings, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.CREATE_NEW_LIST, CommandCreateNewList, EventViewAbstract);
			commandMap.mapEvent(EventManagerPopup.SET_NEW_LIST_NAME, CommandSetNewListName, EventManagerPopup);
			
			commandMap.mapEvent(EventMain.INITIALIZE_DATABASE, CommandConfigureSql, EventMain);
			commandMap.mapEvent(EventMain.CONFIGURE_DATABASE, CommandCreateDB, EventMain);
			commandMap.mapEvent(EventMain.CONFIGURE_MODEL, CommandConfigureModel, EventMain);
			commandMap.mapEvent(EventServiceSettings.FIRST_SETTINGS_LOADED, CommandSettingConfigured, EventServiceSettings);
			commandMap.mapEvent(EventServiceTableNames.FIRST_TABLE_NAMES_LOADED, CommandNamesTableConfigured, EventServiceTableNames);
			
			commandMap.mapEvent(EventServiceTableNames.INSERTED, CommandCreateCategoryItem, EventServiceTableNames);
			commandMap.mapEvent(EventViewAbstract.GET_CATEGORY_DATA, CommandSelectCategoryItem, EventViewAbstract);
			
			commandMap.mapEvent(EventViewAbstract.GET_PACKED_ITEMS, CommandGetPackedItemsFunctionCallback, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.UPDATE_DB_PACKED_ITEM, CommandUpdateCategoryItem, EventViewAbstract);
			
			commandMap.mapEvent(EventViewAbstract.REMOVE_PACKED_ITEM, CommandPopupRemove, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.REMOVE_DB_PACKED_ITEM, CommandRemoveCategoryItem, EventViewAbstract);
			
			commandMap.mapEvent(EventViewAbstract.OPEN_LIST, CommandUpdateVOOpenList, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.GET_CREATED_LISTS, CommandGetCreatedLists, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.ADD_NEW_LIST, CommandAddNewList, EventViewAbstract);
			
			commandMap.mapEvent(EventViewOpen.GET_VOOPEN_LIST_DATA, CommandGetVOOpenList, EventViewOpen);
			commandMap.mapEvent(EventViewOpen.CREATE_NEW_LIST_FROM_EXISTING, CommandCreateNewListFromExisting, EventViewOpen);
			commandMap.mapEvent(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, CommandUpdateOrderIndexes, EventViewAbstract);
	
			commandMap.mapEvent(EventViewAbstract.REMOVE_LIST, CommandRemoveDBList, EventViewAbstract);
			
			//EentModel
			commandMap.mapEvent(EventModel.INSERT_TABLE_NAMES, CommandInsertTableNames, EventModel);
			commandMap.mapEvent(EventModel.COPY_LIST_FORM_EXISTING, CommandCopyListFromExisting, EventModel);
			
			commandMap.mapEvent(EventViewAbstract.ADD_NEW_ITEM_CATEGORY, CommandAddItemToCategory, EventViewAbstract);
			commandMap.mapEvent(EventViewAbstract.ADD_NEW_CATEGORY, CommandAddCategory, EventViewAbstract);
			
			commandMap.mapEvent(EventViewAbstract.GET_DEFAULT_CATEGORIES, CommandGetDefaultCategoriesFunctionCallback, EventViewAbstract);
			
			
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