package com.Application.robotlegs.services.copyList {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOCopyList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOTableName;
	import com.common.DefaultData;
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class ServiceCopyList extends Actor implements IServiceCopyList 	{		
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
		
		private var _listNew:VOTableName;
		private var _listCopy:VOTableName;
		
		private var _copiedList:Vector.<VOPackedItem>;
		private var _currentInsertedItem:VOTableName;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceCopyList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function copyList(value:VOCopyList):void {
			if(value){
				_listNew = value.listNew;
				_listCopy = value.listCopy;
			}
			
			_loadCopyListTable();
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
		
		
		private function _loadCopyListTable():void{
			var pTableName:String = _updateName(_listCopy.table_name);
			var pSql:String = DefaultData.SELECT_COPY_TABLE_1+pTableName+DefaultData.SELECT_COPY_TABLE_2;
			
			sqlRunner.execute(pSql, null, _resultLoadTable, VOPackedItem);

		}
			
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _resultLoadTable(result:SQLResult):void {
			
			_copiedList = new Vector.<VOPackedItem>;
			
			//get Parents
			for(var i:int=0;i<result.data.length;i++){
				var pResItem:VOPackedItem = VOPackedItem(result.data[i]);								
				
				if(!pResItem.isChild){
					_copiedList.push(pResItem);
				}				
			}
			
			
			for(var j:int=0;j<_copiedList.length;j++){
				var pParentItem:VOPackedItem = VOPackedItem(_copiedList[j]);
				
				for(var k:int=0;k<result.data.length;k++){
					var pResChild:VOPackedItem = VOPackedItem(result.data[k]);															
					
					if(pResChild.isChild && pResChild.parentId == pParentItem.item_id){
						pParentItem.childrens.push(pResChild);																	
					}
					
				}								
			}
			
			
			var params:Object = new Object();
			params["title"] = _listNew.title;
			params["table_name"] = _listNew.table_name;
			
			
			sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(INSERT_NAMES_SQL, params)]), _resultAddNewTable, database_error);
		}
		
		
		private function _resultAddNewTable(results:Vector.<SQLResult>):void {
			var result:SQLResult = results[0];
			
			if(!_currentInsertedItem){
				_currentInsertedItem = new VOTableName();
			}
			_currentInsertedItem.id = result.lastInsertRowID;									
			_currentInsertedItem.table_name = "category_"+result.lastInsertRowID;
			_currentInsertedItem.title = _listNew.title;
			
			var params:Object = new Object();
			params["id"] = _currentInsertedItem.id;
			params["title"] = _currentInsertedItem.title;
			params["table_name"] = _currentInsertedItem.table_name;
			
			
			sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(UPDATE_NAMES_SQL, params)]), updateAfterInsert_result, database_error);
			
		}
		
		private function updateAfterInsert_result(results:Vector.<SQLResult>):void	{
			model.appLists.push(_currentInsertedItem);
			
			model.currentTableName = _currentInsertedItem;	
			
			createTable(_currentInsertedItem.table_name, _copiedList);
		}
		
		private function createTable(pTableName:String, pDataToInsert:Vector.<VOPackedItem>):void {			
			
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
					paramsItem["isPacked"] = "false";
					paramsItem["orderIndex"] = pItem.orderIndex;
					paramsItem["item_id"] = pItem.item_id;
					
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
							paramsChild["isPacked"] = "false";
							paramsChild["orderIndex"] = pChild.orderIndex;
							paramsChild["item_id"] = pChild.item_id;
							
							stmts[stmts.length] = new QueuedStatement(pSqlInsert,paramsChild);
						}
						
					}					
					
				}	
				
				
				sqlRunner.executeModify(stmts, executeBatchCreate_complete, executeBatch_error, null);
			}
		}
		
		private function executeBatchCreate_complete(results:Vector.<SQLResult>):void	{
			trace("create table with default Complete");
			load(model.currentTableName.table_name);
			//dispatch(new EventMain(EventMain.CONFIGURE_MODEL));
			//dispatch(new EventServiceCategories(EventServiceCategories.NEW_TABLE_CREATED));
		}
		
		public function load(pTableName:String):void {
			
			if(pTableName.length > 0){
				pTableName = _updateName(pTableName);
				
				var pSql:String = DefaultData.SELECT_CATEGORY_TABLE_1+pTableName+DefaultData.SELECT_CATEGORY_TABLE_2;
				
				sqlRunner.execute(pSql, null, load_result, VOPackedItem);
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
					
					if(pResChild.isChild && pResChild.parentId == pParentItem.item_id){
						pParentItem.childrens.push(pResChild);																	
					}
					
				}								
			}
			
			
			model.currentCategories = pParent;							
			
			//	dispatch(new EventServiceCategories(EventServiceCategories.LOADED));
		}
		
		private function executeBatch_error(error:SQLError):void {
			
			trace("create Copy  table with default Complete");
			//dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
		}
		
		private function database_error(error:SQLError):void {
			trace("Error in TableNames DB Copy");
		}
		
		
		private function _updateName(value:String):String{
			value = value.replace(" ","_");
			return value;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		// ------- SQL statements -------		
		[Embed(source="../sql/tableNames/InsertNamesTable.sql", mimeType="application/octet-stream")]
		private static const InsertStatementText:Class;
		private static const INSERT_NAMES_SQL:String = new InsertStatementText();
		
		[Embed(source="../sql/tableNames/UpdateNamesTable.sql", mimeType="application/octet-stream")]
		private static const UpdateStatementText:Class;
		private static const UPDATE_NAMES_SQL:String = new UpdateStatementText();
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}