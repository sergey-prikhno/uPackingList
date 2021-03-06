package com.Application.robotlegs.controller.service.categories {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOTableName;
	import com.Application.robotlegs.services.categories.IServiceCategories;
	import com.Application.robotlegs.services.tableNames.EventServiceTableNames;
	
	import org.robotlegs.starling.mvcs.Command;
	
	public class CommandCreateCategoryItem extends Command {
				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		[Inject]
		public var event:EventServiceTableNames;
		
		[Inject]
		public var service:IServiceCategories;
		
		[Inject]
		public var model:IModel;
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
		public function CommandCreateCategoryItem() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function execute():void{
			var pData:VOTableName = VOTableName(event.data);
			
			trace("create table");
			
			model.currentTableName = pData;			
			service.createTable(model.currentTableName.table_name, model.defaultCategories);			
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