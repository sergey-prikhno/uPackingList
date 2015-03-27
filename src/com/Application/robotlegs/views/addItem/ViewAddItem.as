package com.Application.robotlegs.views.addItem {
	import com.Application.robotlegs.model.vo.VOAddNewItem;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOTableName;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.PickerList;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class ViewAddItem extends ViewAbstract {
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public static var globalStyleProvider:IStyleProvider;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _items:Vector.<VOPackedItem>;
		private var _tableName:VOTableName;
		
		
		private var _buttonCancel:Button;
		private var _buttonSave:Button;
		
		private var _input:TextInput;
		private var _buttonSaveAndMore:Button;
		
		private var _pickerList:PickerList;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewAddItem() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function destroy():void{
			
			if(_buttonCancel){
				_buttonCancel.removeEventListener(Event.TRIGGERED, _handlerCancel);
				_buttonCancel = null;
			}
			
			if(_buttonSave){				 				
				_buttonSave.removeEventListener(Event.TRIGGERED, _handlerSave);
				_buttonSave = null;
			}
			
			if(_input){				 			
				removeChild(_input);
				_input = null
			}
			
			if(_buttonSaveAndMore){				
				_buttonSaveAndMore.removeEventListener(Event.TRIGGERED, _handlerSaveAndMore);				
				removeChild(_buttonSaveAndMore);
				_buttonSaveAndMore = null;	
			}
			
			
			if(_pickerList){												
				removeChild(_pickerList);					
				_pickerList = null;
			}
		
			super.destroy();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewAddItem.globalStyleProvider;
		}
		
		public function set items(value:Vector.<VOPackedItem>):void{
			_items = value;		
					
			if(_items && _items.length > 0 && _pickerList){
				_pickerList.dataProvider = new ListCollection(_items);
			}
		}
		
		
		public function set tableName(value:VOTableName):void{
			_tableName = value;					
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function _initialize():void{			
			super._initialize();

			
			_buttonCancel = new Button();
			_buttonCancel.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.cancel");
			_buttonCancel.addEventListener(Event.TRIGGERED, _handlerCancel);
			
			
			_buttonSave = new Button();
			_buttonSave.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.save");
			_buttonSave.addEventListener(Event.TRIGGERED, _handlerSave);
			
			
			var pLeftButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			pLeftButtons.push(_buttonCancel);
			
			var pRightButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			pRightButtons.push(_buttonSave);
			
			
			_header.leftItems = pLeftButtons;
			_header.rightItems = pRightButtons;
			_header.validate();						
			
			_input = new TextInput();
			_input.width = int(_nativeStage.fullScreenWidth*0.9);
			_input.height = int(_input.width/8);
			addChild(_input);
			_input.validate();
			_input.x = int(_nativeStage.fullScreenWidth/2 - _input.width/2);
			_input.y = int(_header.height*1.5);
			
		
			_pickerList = new PickerList();
			_pickerList.width = int(_nativeStage.fullScreenWidth*0.9);
			_pickerList.height = _input.height;
			addChild(_pickerList);	
			_pickerList.validate();
			_pickerList.x = int(_nativeStage.fullScreenWidth/2 - _pickerList.width/2);
			_pickerList.y = int(_input.y + _input.height*0.9);
			
			
			
			_buttonSaveAndMore = new Button();
			_buttonSaveAndMore.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.saveAndMore");
			_buttonSaveAndMore.addEventListener(Event.TRIGGERED, _handlerSaveAndMore);
			_buttonSaveAndMore.width = _input.width;
			_buttonSaveAndMore.height = _pickerList.height;			
			addChild(_buttonSaveAndMore);
			_buttonSaveAndMore.validate();
			_buttonSaveAndMore.x = int(_nativeStage.fullScreenWidth/2 - _buttonSaveAndMore.width/2);
			_buttonSaveAndMore.y = int(_pickerList.y + _pickerList.height*0.9);				
		}
		
		override protected function draw():void{
			super.draw();
			
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerCancel(event:Event):void{
			dispatchEvent(new EventViewAbstract(EventViewAbstract.BACK));
		}
		
		
		private function _handlerSaveAndMore(event:Event):void{
			_generateSaveItem(true);													
		}
		
		
		private function _handlerSave(event:Event):void{
			_generateSaveItem();		
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		private function _generateSaveItem(pIsMore:Boolean = false):void{
			if(_input.text.split(" ").join("").length > 0){
				var pCategory:VOPackedItem = VOPackedItem(_pickerList.selectedItem);
				
				var pNewItem:VOPackedItem = new VOPackedItem();
				pNewItem.label = _input.text;
				pNewItem.icon_id = pCategory.icon_id;
				pNewItem.parentId = pCategory.item_id;
				
				if(pCategory.childrens && pCategory.childrens.length > 0){
					pNewItem.orderIndex = VOPackedItem(pCategory.childrens[pCategory.childrens.length -1]).orderIndex + 1;
				} else {
					pNewItem.orderIndex = 1;
				}
				
				pNewItem.isChild = true;
				
				var pNewAddItem:VOAddNewItem = new VOAddNewItem();
					pNewAddItem.item = pNewItem;
					pNewAddItem.isMore = pIsMore;
				
				dispatchEvent(new EventViewAbstract(EventViewAbstract.ADD_NEW_ITEM_CATEGORY, false, pNewAddItem));
			}
			
			_input.text = "";
		}		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}