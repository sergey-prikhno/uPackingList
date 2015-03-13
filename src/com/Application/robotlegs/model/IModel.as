package com.Application.robotlegs.model {
	import com.Application.robotlegs.model.vo.VOAppStorageData;
	
	public interface IModel {
		
		function get test():String
		function set test(value:String):void
		
		function get VOAppStorage():VOAppStorageData
		function set VOAppStorage(value:VOAppStorageData):void
	}
	
}