package com.Application.robotlegs.views.packedList {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.packedList.listPacked.ItemRendererPackedList;
	import com.Application.robotlegs.views.packedList.listPacked.ListPacked;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class ViewPackedList extends ViewAbstract {				
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
		private var _list:ListPacked;
		private var _verticalLayout:VerticalLayout;
		
		private var _backButton:Button;
		private var _editButton:Button;
		
		private var _items:Vector.<VOPackedItem>;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewPackedList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function destroy():void{
						
			if(_list){			
				_list.dataProvider= null;
				removeChild(_list);
				_list = null;
			}
			
			if(_editButton){
				_editButton.removeEventListener(Event.TRIGGERED, _handlerEditListItems);
			}
															
			
			_verticalLayout = null;
			
			super.destroy();			
		}
		
		public function update(pData:VOPackedItem):void{
			if(_list){
				_list.dispatchEvent(new EventViewPackedList(EventViewPackedList.UPDATE_PACKED_ITEM, false, pData));
			}
		}
		
		public function removed(pData:VOPackedItem):void{
			if(_list){		
				
				if(!pData.isChild && pData.isOpen && pData.childrens && pData.childrens.length > 0){
					
					var pLengthChildren:int = pData.childrens.length;
					
					for(var i:int=0; i < pLengthChildren;i++){						
						_list.dataProvider.removeItem(pData.childrens[i]);						
					}					
				}
				
								
				if(pData.isChild){
					
					var pLengthParent:int = _list.dataProvider.length;
					
					for(var j:int=0; j < pLengthParent;j++){	
						var pGetParentItem:VOPackedItem = VOPackedItem(_list.dataProvider.data[j]);
						
						if(pGetParentItem.id == pData.parentId){
							var pParentLen:int = pGetParentItem.childrens.length;
							
							for(var k:int=0;k<pParentLen; k++){
								var pFindChild:VOPackedItem = VOPackedItem(pGetParentItem.childrens[k]);
									
								if(pData.id == pFindChild.id){									
									pGetParentItem.childrens.splice(k,1);
									_list.dispatchEvent(new EventViewPackedList(EventViewPackedList.UPDATE_PACKED_ITEM, false, pData));	
									break;
								}
								
							}							
							
							break;
						}											
					}
																				
				}
				
				_list.dataProvider.removeItem(pData);
				
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set items(value:Vector.<VOPackedItem>):void{
			_items = value;
			
			if(_list && _items && _items.length > 0){
				_list.dataProvider = new ListCollection(_items);
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewPackedList.globalStyleProvider;
		}
		
		
		override protected function _initialize():void{
			super._initialize();
			
			_verticalLayout = new VerticalLayout();
			_verticalLayout.useVirtualLayout = true;			
			
			_list = new ListPacked();			
			_list.layout = _verticalLayout;	
			_list.width = _nativeStage.stageWidth;
			_list.itemRendererFactory = function():IListItemRenderer{
				var renderer:ItemRendererPackedList = new ItemRendererPackedList();
								
				return renderer;
			};
			
			addChild(_list);	
			
			
			var pChild1:VOPackedItem = new VOPackedItem();
				pChild1.isChild = true;
				pChild1.parentId = 2;
				pChild1.id = 1;
				pChild1.label = "1 Child Parent 2";
				
				var pChild2:VOPackedItem = new VOPackedItem();
				pChild2.isChild = true;
				pChild2.parentId = 2;
				pChild2.id = 2;
				pChild2.label = "2 Child Parent 2";
				
				var pChild3:VOPackedItem = new VOPackedItem();
				pChild3.isChild = true;
				pChild3.parentId = 2;
				pChild3.id = 3;
				pChild3.label = "3 Child Parent 2";
				///////////////////////////////
			
			var p1:VOPackedItem = new VOPackedItem();
				p1.id = 1;
				p1.label = "Preparations";
			
			var p2:VOPackedItem = new VOPackedItem();
				p2.id = 2;
				p2.label = "Accessories";
				
				var pChildren:Vector.<VOPackedItem> = new Vector.<VOPackedItem>();
					pChildren.push(pChild1);
					pChildren.push(pChild2);
					pChildren.push(pChild3);
					
				p2.childrens = pChildren;
			
				var p3:VOPackedItem = new VOPackedItem();
				p3.id = 3;
				p3.label = "Hygiene";
				
				var p4:VOPackedItem = new VOPackedItem();
				p4.id = 4;
				p4.label = "Health";
				
				var p5:VOPackedItem = new VOPackedItem();
				p5.id = 5;
				p5.label = "Hats";
				
				var p6:VOPackedItem = new VOPackedItem();
				p6.id = 6;
				p6.label = "Money";
				
				var p7:VOPackedItem = new VOPackedItem();
				p7.id = 7;
				p7.label = "Children's accessories";
				
				var p8:VOPackedItem = new VOPackedItem();
				p8.id = 8;
				p8.label = "Documents";
				
				var p9:VOPackedItem = new VOPackedItem();
				p9.id = 9;
				p9.label = "Shoes";
				
				var p10:VOPackedItem = new VOPackedItem();
				p10.id = 10;
				p10.label = "Clothes";
				
				var p11:VOPackedItem = new VOPackedItem();
				p11.id = 11;
				p11.label = "Tableware";
				
				var p12:VOPackedItem = new VOPackedItem();
				p12.id = 12;
				p12.label = "Food";
				
				var p13:VOPackedItem = new VOPackedItem();
				p13.id = 13;
				p13.label = "Sport";
				
				var p14:VOPackedItem = new VOPackedItem();
				p14.id = 14;
				p14.label = "Luggage";
				
				var p15:VOPackedItem = new VOPackedItem();
				p15.id = 15;
				p15.label = "Gadgets";
				
				var p16:VOPackedItem = new VOPackedItem();
				p16.id = 16;
				p16.label = "Before leaving";
				
			//_list.dataProvider = new ListCollection([p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16]);
			if(_items && _items.length > 0){
				_list.dataProvider = new ListCollection(_items);
			}
				
			_list.addEventListener(EventViewPackedList.CLICK_ITEM, _handlerItemClick);
			
			
			
			_backButton = new Button();
			_backButton.addEventListener(Event.TRIGGERED, _handlerBackbutton);
			_backButton.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.back");			
			
			_editButton = new Button();
			_editButton.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.edit");
			_editButton.addEventListener(Event.TRIGGERED, _handlerEditListItems);
			
			var pLeftButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
				pLeftButtons.push(_backButton);
			
			var pRightButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
				pRightButtons.push(_editButton);
			
			
			_header.leftItems = pLeftButtons;
			_header.rightItems = pRightButtons;
		}
		
		
		override protected function draw():void{
			super.draw();
						
			
			if(_header){				
				//create or Edit				
				_header.width = _nativeStage.stageWidth;
			}
			
			if(_list){															
				_list.y = _header.height;
				_list.height = int(_nativeStage.fullScreenHeight- _header.height);
				_list.validate();
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerItemClick(event:Event):void{
			event.stopPropagation();
			
			
			var pData:VOPackedItem = VOPackedItem(event.data);
			
			if(pData.childrens && pData.childrens.length > 0){
				
				var pLenght:Number = pData.childrens.length-1;
				
				if(!pData.isOpen){																		
					for(var i:int=pLenght; i>= 0 ;i--){
						_list.dataProvider.addItemAt(pData.childrens[i],pData.index+1);
					}					
				} else {										
					var pListLength:Number = _list.dataProvider.length-1;					
					for(var j:int=pLenght; j>= 0 ;j--){						
						_list.dataProvider.removeItem(pData.childrens[j]);						
					}														
				}
								
			}						
		}
		
		
		private function _handlerEditListItems(event:Event):void{
			_list.isEditing = !_list.isEditing; 
		}
		
		private function _handlerBackbutton(event:Event):void{
			dispatchEvent(new EventViewPackedList(EventViewPackedList.BACK_TO_PREVIOUS_SCREEN));
		}
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