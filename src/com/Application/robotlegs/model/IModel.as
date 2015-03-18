package com.Application.robotlegs.model {
	import com.Application.robotlegs.model.vo.VOAppStorageData;
	import com.Application.robotlegs.model.vo.VOListCreate;
	
	public interface IModel {
		
		function get test():String
		function set test(value:String):void
		
		function get VOAppStorage():VOAppStorageData
		function set VOAppStorage(value:VOAppStorageData):void
		
		function set newList(value:VOListCreate):void
		function get appLists():Array
	}
	
}