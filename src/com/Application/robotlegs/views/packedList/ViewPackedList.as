package com.Application.robotlegs.views.packedList {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOTableName;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.bottomMenu.BottomMenu;
	import com.Application.robotlegs.views.components.bottomMenu.EventBottomMenu;
	import com.Application.robotlegs.views.components.searchInput.EventSearchInput;
	import com.Application.robotlegs.views.components.searchInput.SearchInput;
	import com.Application.robotlegs.views.packedList.listPacked.CustomLayout;
	import com.Application.robotlegs.views.packedList.listPacked.ItemRendererPackedList;
	import com.Application.robotlegs.views.packedList.listPacked.ListPacked;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.skins.IStyleProvider;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
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
		private var _verticalLayout:CustomLayout;
		
		private var _backButton:Button;
		private var _editButton:Button;
		
		private var _items:Vector.<VOPackedItem>;
		
		private var _bottomMenu:BottomMenu;
		private var _tableName:VOTableName;
		
		private var _search:SearchInput;
		
		
		private var _containerAddButtons:Sprite;
		
		private var _buttonAddCategory:Button;
		private var _buttonAddItem:Button;
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
				removeChild(_list,true);
				_list = null;
			}
			
			if(_editButton){
				_editButton.removeEventListener(Event.TRIGGERED, _handlerEditListItems);
			}			
			
			if(_bottomMenu){
				_bottomMenu.removeEventListener(EventBottomMenu.COLLAPSE, _handlerCollapse);
				_bottomMenu.removeEventListener(EventBottomMenu.SEARCH, _handlerSearch);
				_bottomMenu.destroy();
				removeChild(_bottomMenu);
				_bottomMenu = null;
			}			
			
			
			if(_search){
				_search.removeEventListener(EventSearchInput.CANCEL, _handlerCancelSearch);
				_search.removeEventListener(EventSearchInput.CHANGE, _handlerChange);
				_search.destroy();
				removeChild(_search);
				_search = null;
			}
			
			
			if(_buttonAddCategory){
				_buttonAddCategory.removeEventListener(Event.TRIGGERED, _handlerAddNewCategory);
				_containerAddButtons.removeChild(_buttonAddCategory);	
			}
			 
			if(_buttonAddItem){
				_buttonAddItem.removeEventListener(Event.TRIGGERED, _handlerAddNewItem);
				_containerAddButtons.removeChild(_buttonAddItem);
				_buttonAddItem = null;
			}
			
			if(_containerAddButtons){
				removeChild(_containerAddButtons);
				_containerAddButtons = null;			
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
		
		
		public function set tableName(value:VOTableName):void{
			_tableName = value;
			
			if(_header){
				_header.title = _tableName.title;
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
		
		//private var _aaa:Vector.<VOPackedItem>;
		override protected function _initialize():void{			
			super._initialize();

			_search = new SearchInput();		
			_search.addEventListener(EventSearchInput.CANCEL, _handlerCancelSearch);
			_search.addEventListener(EventSearchInput.CHANGE, _handlerChange);
			addChild(_search);			
			swapChildren(_search,_header);
			
			_verticalLayout = new CustomLayout();
			_verticalLayout.useVirtualLayout = true;			
			
			_list = new ListPacked();			
			_list.layout = _verticalLayout;	
			_list.width = _nativeStage.stageWidth;
			_list.itemRendererFactory = function():IListItemRenderer{
				var renderer:ItemRendererPackedList = new ItemRendererPackedList();
				
				return renderer;
			};
			
			addChild(_list);	
			
			
		/*	var pChild1:VOPackedItem = new VOPackedItem();
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
			
			_aaa = new Vector.<VOPackedItem>();
			_aaa.push(p1);
			_aaa.push(p2);
			_aaa.push(p3);
			_aaa.push(p4);
			_aaa.push(p5);
			_aaa.push(p6);
			_aaa.push(p7);
			_aaa.push(p8);*/
			
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
			
			
			_bottomMenu = new BottomMenu();
			_bottomMenu.isHome = true;
			_bottomMenu.isSearch = true;
			_bottomMenu.isCollapse = true;
			_bottomMenu.isPack = true;
			addChild(_bottomMenu);
			_bottomMenu.addEventListener(EventBottomMenu.COLLAPSE, _handlerCollapse);
			_bottomMenu.addEventListener(EventBottomMenu.SEARCH, _handlerSearch);
						
			
			
			_containerAddButtons = new Sprite();
			addChild(_containerAddButtons);
			_containerAddButtons.visible = false;
			
			
			_buttonAddCategory = new Button();
			_buttonAddCategory.width = int(_nativeStage.fullScreenWidth*0.9);
			_buttonAddCategory.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.addnewCategory");
			_buttonAddCategory.addEventListener(Event.TRIGGERED, _handlerAddNewCategory);
			_containerAddButtons.addChild(_buttonAddCategory);
			_buttonAddCategory.validate();
			
			_buttonAddItem = new Button();
			_buttonAddItem.width = int(_nativeStage.fullScreenWidth*0.9);
			_buttonAddItem.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.addnewItem");
			_buttonAddItem.addEventListener(Event.TRIGGERED, _handlerAddNewItem);
			_containerAddButtons.addChild(_buttonAddItem);
			_buttonAddItem.validate();
			_buttonAddItem.y = int(_buttonAddCategory.height*1.1);
			
			_containerAddButtons.x = int(_nativeStage.fullScreenWidth/2 - _containerAddButtons.width/2);
			
		}
		
		
		override protected function draw():void{
			super.draw();
												
			if(_bottomMenu){
				_bottomMenu.width = _nativeStage.fullScreenWidth;
				_bottomMenu.height = int(88*_scaleHeight);
				_bottomMenu.y = _nativeStage.stageHeight - _bottomMenu.height; 				
			}
						
			if(_search && _search.width == 0){
				_search.width = int(_nativeStage.fullScreenWidth);
				_search.height = _header.height;
				_search.validate();
				_search.x = int(_nativeStage.fullScreenWidth/2 - _search.width/2);
				_search.y = 0;
			}
			
			if(_list && !_list.dataProvider){															
				//_list.y = _header.height;
				_list.y = int(_search.y + _search.height);
				_list.height = int(_nativeStage.fullScreenHeight- _header.height-_bottomMenu.height);
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
			
			_containerAddButtons.visible = _list.isEditing;
			
						
			if(_list.isEditing){				
				_containerAddButtons.y = int(_header.y + _header.height);
				
				_list.height = int(_nativeStage.fullScreenHeight- (_containerAddButtons.y+ _containerAddButtons.height) -_bottomMenu.height);
				_list.y = int(_containerAddButtons.y + _containerAddButtons.height);
				_editButton.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.done");				
			} else {
				_list.y = int(_search.y + _search.height);
				_list.height = int(_nativeStage.fullScreenHeight- _header.height-_bottomMenu.height);
				_editButton.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.edit");
			}
			
			 
			
		}
		
		private function _handlerBackbutton(event:Event):void{
			dispatchEvent(new EventViewPackedList(EventViewPackedList.BACK_TO_PREVIOUS_SCREEN));
		}
		
		
		private function _handlerCollapse(event:EventBottomMenu):void{
			_collapseItems();
					
		}
		
		
		/**
		 * 
		 * show Search
		 * 
		 */
		private function _handlerSearch(event:EventBottomMenu):void{
			
			if(_search.y == 0){
								
				var pTween:Tween = new Tween(_search,.3,Transitions.EASE_OUT);
					pTween.moveTo(_search.x,_header.height);
					pTween.onUpdate = onUpdate;
					pTween.onComplete = onComplete;
				
					Starling.juggler.add(pTween);
					
					
					
			}
			
		}
		
		
		
		private function _handlerCancelSearch(event:EventSearchInput):void{
			_collapseItems();
			
			var pTween:Tween = new Tween(_search,.3,Transitions.EASE_OUT);
				pTween.moveTo(_search.x,0);
				pTween.onUpdate = onUpdate;
				pTween.onComplete = onComplete;
			
			Starling.juggler.add(pTween);		
			
			_list.isDragable = true;
			
			if(!_list.isEditing){
				_list.height = int(_nativeStage.fullScreenHeight- (_header.height+_bottomMenu.height + _header.y));
			} else {
				_list.height = int(_nativeStage.fullScreenHeight- (_header.height+_bottomMenu.height + _header.y)-_containerAddButtons.height);
			}
		}
		
		private function _handlerChange(event:EventSearchInput):void{
			trace(_search.text);
			
			
			var pFilteredVector:Vector.<VOPackedItem> = new Vector.<VOPackedItem>();
			
			if(_search.text.length > 0){
				for(var i:int=0;i<_items.length;i++){
					var pItem:VOPackedItem = VOPackedItem(_items[i]);
					
					if(!pItem.isChild){					
						var pFilTemp:Vector.<VOPackedItem> = Vector.<VOPackedItem>(pItem.childrens).filter(_searchFilter);					
						pFilteredVector = pFilteredVector.concat(pFilTemp);					
					}			
				}
			}
			
			_list.dataProvider = new ListCollection(pFilteredVector);
		}				
		
		
		/**
		 * 
		 * Add new Category Handler
		 * 
		 */
		private function _handlerAddNewCategory(event:Event):void{
			_collapseItems();
			dispatchEvent(new EventViewPackedList(EventViewPackedList.ADD_NEW_CATEGORY));
		}
		
		/**
		 * 
		 * Add new Item Handler
		 * 
		 */
		private function _handlerAddNewItem(event:Event):void{
			_collapseItems();
			dispatchEvent(new EventViewPackedList(EventViewPackedList.ADD_NEW_ITEM));
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		private function onUpdate():void{
			if(_list){
				if(!_list.isEditing){
					_list.y = int(_search.y + _search.height);																	
				} else {
					_containerAddButtons.y = int(_search.y + _search.height);
					_list.y = int(_containerAddButtons.y + _containerAddButtons.height);
				}
			}
		}
		
		private function onComplete():void{
				
			if(!_list.isEditing){
				_list.y = int(_search.y + _search.height);																	
			} else {
				_containerAddButtons.y = int(_search.y + _search.height);
				_list.y = int(_containerAddButtons.y + _containerAddButtons.height);
			}				
								
			if(_search.y > 0){
				_list.isDragable = false;
				
				if(!_list.isEditing){
					_list.height = int(_nativeStage.fullScreenHeight- _search.y - _search.height-_bottomMenu.height);
				} else {
					_list.height = int(_nativeStage.fullScreenHeight- _search.y - _search.height-_bottomMenu.height- _containerAddButtons.height);
				}
				
			} else {
				_list.isDragable = true;
			}
			
			Starling.juggler.removeTweens(_search);
		}
		
		/**
		 * 
		 * Search Filter
		 * 
		 */
		private function _searchFilter(item:VOPackedItem, index:int, vector:Vector.<VOPackedItem>):Boolean {
			var pIsIsset:Boolean = false;
			// your code here
			
			var pLabel:String = item.label.toLowerCase();
			var pSearch:String = _search.text.toLowerCase();
			
			if(pLabel.indexOf(pSearch) >= 0){
				pIsIsset = true;
			}
			
			return pIsIsset;
		}
		
		
		/**
		 * 
		 * Collapse Items
		 * 
		 */
		private function _collapseItems():void{
			if(_list && _items && _items.length > 0){
				
				for(var i:int=0;i<_items.length;i++){				
					var pParentItem:VOPackedItem = VOPackedItem(_items[i]);					
					pParentItem.isOpen = false;		
					
					if(pParentItem.isChild){
						_items.splice(i,1);
						i--;
					}												
				}
				
				_list.dataProvider = new ListCollection(_items);
				_list.validate();															
			}			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}