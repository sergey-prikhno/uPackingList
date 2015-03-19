package com.Application.robotlegs.services.categories {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.common.DefaultData;
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class ServiceCategories extends Actor implements IServiceCategories{		
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
		private var _currentItem:VOPackedItem;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceCategories() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * 
		 * Create Table
		 * 
		 */
		public function createTable(pTableName:String, pDataToInsert:Vector.<VOPackedItem>):void {
			
			if(pTableName.length > 0){
				pTableName = _updateName(pTableName);
				
				var pSql:String = DefaultData.CREATE_CATEGORY_TABLE_1+pTableName+DefaultData.CREATE_CATEGORY_TABLE_2;									
				
				
				var stmts:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
					stmts[stmts.length] = new QueuedStatement(pSql);						
						
				var pSqlInsert:String = DefaultData.INSERT_CATEGORY_TABLE_1+pTableName+DefaultData.INSERT_CATEGORY_TABLE_2;
					
				//add Parent
				for(var i:int=0; i<pDataToInsert.length;i++){
					var pItem:VOPackedItem = VOPackedItem(pDataToInsert[i]);
																											
						var paramsItem:Object = new Object();
							paramsItem["parentId"] = pItem.parentId;
							paramsItem["isChild"] = pItem.isChild.toString();
							paramsItem["label"] = pItem.label;
							paramsItem["isPacked"] = pItem.isPacked.toString();
					
						stmts[stmts.length] = new QueuedStatement(pSqlInsert,paramsItem);
					
				}
				
				//add Childrens
				for(var j:int=0;j<pDataToInsert.length;j++){
					var pParentItem:VOPackedItem = VOPackedItem(pDataToInsert[j]);
					
					if(pParentItem.childrens){
							
						for(var k:int=0;k<pParentItem.childrens.length;k++){
							var pChild:VOPackedItem = VOPackedItem(pParentItem.childrens[k]);																												
							
							var paramsChild:Object = new Object();
								paramsChild["parentId"] = pChild.parentId;
								paramsChild["isChild"] = pChild.isChild.toString();
								paramsChild["label"] = pChild.label;
								paramsChild["isPacked"] = pChild.isPacked.toString();
							
							stmts[stmts.length] = new QueuedStatement(pSqlInsert,paramsChild);
						}
						
					}
					
											
				}	
				
				
				sqlRunner.executeModify(stmts, executeBatchCreate_complete, executeBatch_error, null);
			}
		}
		
		
		/**
		 * 
		 * SELECT ALL
		 * 
		 */						
		public function load(pTableName:String):void {
			
			if(pTableName.length > 0){
				pTableName = _updateName(pTableName);
				
				var pSql:String = DefaultData.SELECT_CATEGORY_TABLE_1+pTableName+DefaultData.SELECT_CATEGORY_TABLE_2;
			
				sqlRunner.execute(pSql, null, load_result, VOPackedItem);
			}
		}
		
		
		
		
		/**
		 * 
		 * update
		 * 
		 */
		public function update(value:VOPackedItem,pTableName:String):void {
			
			if(pTableName.length > 0){
				pTableName = _updateName(pTableName);
				
				var pSql:String = DefaultData.UPDATE_CATEGORY_TABLE_1+pTableName+DefaultData.UPDATE_CATEGORY_TABLE_2;
																					
				var paramsItem:Object = new Object();
					paramsItem["parentId"] = value.parentId;
					paramsItem["isChild"] = ""+value.isChild+"";
					paramsItem["label"] = value.label;
					paramsItem["isPacked"] = ""+value.isPacked+"";
					paramsItem["id"] = value.id;
					
					_currentItem = value;
					
				sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(pSql, paramsItem)]), update_result, database_error);
			}
		}
		
		
		/**
		 * 
		 * Insert 
		 * 
		 */
		public function insert(value:VOPackedItem,pTableName:String):void {
			
			if(pTableName.length > 0){
				pTableName = _updateName(pTableName);
				
				var pSql:String = DefaultData.INSERT_CATEGORY_TABLE_1+pTableName+DefaultData.INSERT_CATEGORY_TABLE_2;
				
				var paramsItem:Object = new Object();
					paramsItem["parentId"] = value.parentId;
					paramsItem["isChild"] = value.isChild.toString();
					paramsItem["label"] = value.label;				
					paramsItem["isPacked"] = value.isPacked.toString();
						
			
				sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(pSql, paramsItem)]), insert_result, database_error);
			}
		}
		
		/**
		 * 
		 * Remove
		 * 
		 */
		public function remove(value:VOPackedItem,pTableName:String):void {
		//	model.remove(contact);
			if(pTableName.length > 0){
				pTableName = _updateName(pTableName);
				
				var pSql:String = DefaultData.DELETE_CATEGORY_TABLE_1+pTableName+DefaultData.DELETE_CATEGORY_TABLE_2;
			
				sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(pSql, {id:value.id})]), remove_result, database_error);			
			}
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
		private function update_result(results:Vector.<SQLResult>):void {
			dispatch(new EventServiceCategories(EventServiceCategories.UPDATED,false,_currentItem));
			
			trace("table Updated");
		}
		
		private function database_error(error:SQLError):void {
			trace("Database Error");
			//dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
		}
		
		private function remove_result(results:Vector.<SQLResult>):void {
			trace("removed ");
		}
		
		
		private function insert_result(results:Vector.<SQLResult>):void	{
			var result:SQLResult = results[0];
			
			trace("added New Row dont'forget about id in DB after Insert")
			if (result.rowsAffected > 0) {
				var contactId:Number = result.lastInsertRowID;
				//loadNewContact(contactId);
			} else 	{
				//dispatch(new ContactServiceEvent(ContactServiceEvent.SAVED));
			}
		}
		
		
		private function load_result(result:SQLResult):void {
			
			var pParent:Vector.<VOPackedItem> = new Vector.<VOPackedItem>;
			
			//get Parents
			for(var i:int=0;i<result.data.length;i++){
				var pResItem:VOPackedItem = VOPackedItem(result.data[i]);								
				
				if(!pResItem.isChild){
					pParent.push(pResItem);
				}				
			}
			
			
			for(var j:int=0;j<pParent.length;j++){
				var pParentItem:VOPackedItem = VOPackedItem(pParent[j]);
				
				for(var k:int=0;k<result.data.length;k++){
					var pResChild:VOPackedItem = VOPackedItem(result.data[k]);															
					
					if(pResChild.isChild && pResChild.parentId == pParentItem.id){
						pParentItem.childrens.push(pResChild);																	
					}
					
				}								
			}
			
			
			model.currentCategories = pParent;							
			
		//	dispatch(new EventServiceCategories(EventServiceCategories.LOADED));
		}
	
		
		private function executeBatchCreate_complete(results:Vector.<SQLResult>):void	{
			trace("create table with default Complete");
			
			//dispatch(new EventMain(EventMain.CONFIGURE_MODEL));
		}
		
		
		private function executeBatch_error(error:SQLError):void {
			
			trace("create table with default Complete");
			//dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		private function _updateName(value:String):String{
			value = value.replace(" ","_");
			return value;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}