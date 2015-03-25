package com.Application.robotlegs.services.removeList {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOTableName;
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class ServiceRemoveList extends Actor implements IServiceRemoveList{		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		[Inject]
		public var model:IModel;
		
		[Inject]
		public var sqlRunner:SQLRunner;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _currentDeleteItem:VOTableName;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceRemoveList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function removeList(value:VOTableName):void {
			_currentDeleteItem = value;
			sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(DELETE_LIST_SQL, {id:_currentDeleteItem.id})]), remove_result, database_error);
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
		
		private function remove_result(results:Vector.<SQLResult>):void {
			trace("Delete list");
			model.updateRemovedLists(_currentDeleteItem);
			dispatch(new EventServiceRemoveList(EventServiceRemoveList.REMOVED_LIST_DB, false, _currentDeleteItem));	
		}
		
		private function database_error(error:SQLError):void {
			trace("Error in delete list DB");
		}
		
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
		
		// ------- SQL statements -------		
		[Embed(source="../sql/deleteList/DeleteList.sql", mimeType="application/octet-stream")]
		private static const DeleteListStatement:Class;
		private static const DELETE_LIST_SQL:String = new DeleteListStatement();
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}