package com.Application.robotlegs.model {

	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOListCreate;
	import com.Application.robotlegs.model.vo.VOPackedItem;

	
	public interface IModel {				
		function get appSettings():VOAppSettings
		function set appSettings(value:VOAppSettings):void
				
		function set newList(value:VOListCreate):void
		function get appLists():Array

		function get defaultCategories():Vector.<VOPackedItem>
		function set defaultCategories(value:Vector.<VOPackedItem>):void			
	}
	
}