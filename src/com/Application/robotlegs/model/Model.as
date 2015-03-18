package com.Application.robotlegs.model {

	import com.Application.Main;
	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOListCreate;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOScreenID;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class Model extends Actor implements IModel {						
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
		private var _appLists:Array = [];
		private var _VOAppSettings:VOAppSettings;
		
		private var _defaultCategories:Vector.<VOPackedItem>;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function Model()	{
			super();
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get appLists():Array{return _appLists;}

		public function set newList(value:VOListCreate):void{
			if(value.isScratch){
				_appLists.push(value);
				var pVO:VOScreenID = new VOScreenID();
				pVO.screenID = Main.VIEW_PACKED_LIST;
				dispatch(new EventModel(EventModel.CHANGE_APP_SCREEN, false, pVO));
			}
		}
						
		public function get appSettings():VOAppSettings { return _VOAppSettings;}
		public function set appSettings(value:VOAppSettings):void{
			_VOAppSettings = value;	
		}	
		
		
		public function get defaultCategories():Vector.<VOPackedItem> { return _defaultCategories;}
		public function set defaultCategories(value:Vector.<VOPackedItem>):void{
			_defaultCategories = value;	
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