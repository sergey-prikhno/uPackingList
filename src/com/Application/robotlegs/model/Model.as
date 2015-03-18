package com.Application.robotlegs.model {
	import com.Application.Main;
	import com.Application.robotlegs.model.vo.VOAppStorageData;
	import com.Application.robotlegs.model.vo.VOListCreate;
	import com.Application.robotlegs.model.vo.VOScreenID;
	import com.common.Constants;
	import com.common.FileSerializer;
	
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
		private var _test:String = "";
		
		private var _VOAppStorage:VOAppStorageData;
		
		private var _appLists:Array = [];
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function Model()	{
			super();
			
			_VOAppStorage = new VOAppStorageData();
			
			var pObject:Object = FileSerializer.readObjectFromFile(Constants.FILE_PATH);			
			if(pObject){
				_VOAppStorage.parser(pObject);				
			}		
			
			//FileSerializer.writeObjectToFile(_VOUserStorage,Constants.FILE_PATH);
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

		public function get test():String { return _test;}
		public function set test(value:String):void{
			_test = value;	
		}	
		
		public function get VOAppStorage():VOAppStorageData { return _VOAppStorage;}
		public function set VOAppStorage(value:VOAppStorageData):void{
			_VOAppStorage = value;	
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