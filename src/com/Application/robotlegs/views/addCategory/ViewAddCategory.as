package com.Application.robotlegs.views.addCategory {
	import com.Application.robotlegs.model.vo.VOAddNewItem;
	import com.Application.robotlegs.model.vo.VODefaultIcons;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.packedList.listPacked.ItemRendererPackedList;
	import com.common.Constants;
	
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	
	public class ViewAddCategory extends ViewAbstract {		
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
		private var _items:Vector.<VODefaultIcons>;
		private var _defaultCategories:Vector.<VOPackedItem>;
		private var _atlas:TextureAtlas;
		
		private var _buttonCancel:Button;
		private var _buttonSave:Button;
		
		private var _input:TextInput;
		private var _choosedImage:Image;
		
		private var _selectedId:int = 1;
		private var _labelTapToChange:Label;
		private var _baseTextFormat:ElementFormat;
		
		private var _list:List;
		private var _layoutTiled:TiledRowsLayout
		
		private static const INVALIDATE_INNER:String = "INVALIDATE_INNER";
		
		private var _currentItem:VODefaultIcons;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewAddCategory() {
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
			
			if(_choosedImage){				
				removeChild(_choosedImage);
				_choosedImage = null;				
			}
			
		
			if(_list){
				_list.removeEventListener(Event.CHANGE, _handlerListSelected);
				removeChild(_list);
				_list = null;
			}
		
			
			_layoutTiled = null;			
			
			_currentItem = null;
			
			super.destroy();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewAddCategory.globalStyleProvider;
		}
		
		public function set defaultCategories(pData:Vector.<VOPackedItem>):void{
			_defaultCategories = pData;
			_generateItems();
		}
		
		public function set atlas(value:TextureAtlas):void {
			_atlas = value;	
			_generateItems();
		}				
		
		public function set baseTextFormat(value:ElementFormat):void{
			_baseTextFormat = value;
			
			invalidate(INVALIDATE_INNER);			
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function _initialize():void{			
			super._initialize();
			
			_currentItem = new VODefaultIcons();
			_currentItem.id = 1;
			
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
			
			
			_labelTapToChange = new Label();
			_labelTapToChange.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.tap");
			addChild(_labelTapToChange);
			_labelTapToChange.validate();
			
		
			
		}
		
		
		override protected function draw():void{
			super.draw();
															
		}
		
		
		override public function invalidate(flag:String=INVALIDATION_FLAG_ALL):void{
			super.invalidate(flag);
			
			if(flag == INVALIDATE_INNER){
				
				if(!_choosedImage && _items && _items.length > 0){
					_choosedImage = new Image(_items[_selectedId-1].texture);
					_choosedImage.scaleX = _choosedImage.scaleY = _scaleWidth+.5;
					_choosedImage.smoothing = TextureSmoothing.TRILINEAR;
					addChild(_choosedImage);
					_choosedImage.x = _input.x;
					_choosedImage.y = int(_input.y + _input.height * 1.3);
					
					_labelTapToChange.x = int(_choosedImage.x + _choosedImage.width*1.2);
					_labelTapToChange.y = _choosedImage.y+_choosedImage.height -_labelTapToChange.height ;
				}
				
				
				if(_labelTapToChange){
					_labelTapToChange.textRendererProperties.elementFormat = _baseTextFormat;				
					_labelTapToChange.validate();
				}
				
				
				if(_items && _items.length > 0 && !_list){
					
					_layoutTiled = new TiledRowsLayout();
					_layoutTiled.typicalItemWidth = _layoutTiled.typicalItemHeight = _choosedImage.width;
					_layoutTiled.horizontalGap = 10*_scaleWidth;
					_layoutTiled.verticalGap = 10*_scaleWidth;					
					
					_list = new List();
					_list.layout = _layoutTiled;										
					_list.width = int(_nativeStage.fullScreenWidth);
					_list.height = _nativeStage.fullScreenHeight - (_labelTapToChange.y + _labelTapToChange.height);
					_list.y = int(_labelTapToChange.y + _labelTapToChange.height*4); 
					_list.x = 0;
					
					_list.itemRendererFactory = function():IListItemRenderer{
						var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
						//	renderer.width =  _choosedImage.width;
						//	renderer.height =  _choosedImage.height;		
							renderer.paddingBottom = renderer.paddingTop = renderer.paddingLeft = renderer.paddingRight = int(20*_scaleWidth); 
							renderer.iconSourceField = "texture";							
							renderer.hasLabelTextRenderer = false;
							
						return renderer;
					};
					
					_list.dataProvider = new ListCollection(_items);
					addChild(_list);
					_list.addEventListener(Event.CHANGE, _handlerListSelected);
				}
				
			}						
		}
		
		
		private function _generateItems():void{
			
			
			if(!_items && _atlas && _defaultCategories && _defaultCategories.length > 0){
			
				
				_items = new Vector.<VODefaultIcons>;
			
				for(var i:int = 0; i<_defaultCategories.length;i++){
					var pCurrentItem:VOPackedItem = VOPackedItem(_defaultCategories[i]);
					
					var pItem:VODefaultIcons = new VODefaultIcons();
						pItem.id = pCurrentItem.icon_id;
						pItem.texture = _atlas.getTexture("icon_"+pItem.id);
					_items.push(pItem);
				}
				
				_items = _items.reverse();
				
				invalidate(INVALIDATE_INNER);	
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerSave(event:Event):void{
			if(_input.text.split(" ").join("").length > 0){				
				
				var pNewItem:VOPackedItem = new VOPackedItem();
					pNewItem.label = _input.text;
					pNewItem.icon_id = _currentItem.id;										
				
				var pNewAddItem:VOAddNewItem = new VOAddNewItem();
					pNewAddItem.item = pNewItem;
				
				
				dispatchEvent(new EventViewAbstract(EventViewAbstract.ADD_NEW_CATEGORY, false, pNewAddItem));
			}
			
			_input.text = "";		
		}
		
		private function _handlerCancel(event:Event):void{
			dispatchEvent(new EventViewAbstract(EventViewAbstract.BACK));
		}
		
		private function _handlerListSelected(event:Event):void{
			_currentItem = VODefaultIcons(_list.selectedItem)
			_choosedImage.texture = _currentItem.texture;
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