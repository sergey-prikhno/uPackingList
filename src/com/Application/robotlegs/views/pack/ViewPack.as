package com.Application.robotlegs.views.pack{
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.bottomMenu.BottomMenu;
	import com.Application.robotlegs.views.components.renderers.ItemrendererOpenList;
	import com.common.Constants;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	public class ViewPack extends ViewAbstract {									
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------		
		
		private var _layoutVertical:VerticalLayout;
		
		public static var globalStyleProvider:IStyleProvider;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _list:List;
		private var _collectionList:ListCollection;	
		
		private var _buttonAdd:Button;	
		private var _buttonBack:Button;	
		
		private var _menuBottom:BottomMenu;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewPack() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------

		override public function destroy():void{
			super.destroy();
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewPack.globalStyleProvider;
		}
		
		public function get resourceManager():LocaleManager{
			return _resourceManager;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			_layoutVertical = new VerticalLayout();
					
			if(!_collectionList){
				_collectionList = new ListCollection();
			}
			
			if(!_list){
				_list = new List();
				_list.hasElasticEdges = true;
				_list.itemRendererType = ItemrendererOpenList;
				addChild(_list);
			}
			
			_buttonAdd = new Button();
			_buttonAdd.label = "+";
			_buttonAdd.addEventListener(Event.TRIGGERED, _handlerAddButton);
			
			_buttonBack = new Button();
			_buttonBack.label = "Back";
			_buttonBack.addEventListener(Event.TRIGGERED, _handlerBackButton);
			
			this._header.rightItems = new <DisplayObject>
				[
					this._buttonAdd
				];
			this._header.leftItems = new <DisplayObject>
				[
					this._buttonBack
				];
			
			_menuBottom = new BottomMenu();
			_menuBottom.isHome = true;
			_menuBottom.isSearch = true;
			_menuBottom.isUndo = true;
			_menuBottom.isCheckAll = true;
			_menuBottom.isMail = true;
			addChild(_menuBottom);
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.pack");
				_header.width = _nativeStage.stageWidth;
			}
			
			if(_list){
				_layoutVertical.gap = int(16*_scaleHeight);
				_list.layout = _layoutVertical;	
				_list.dataProvider = _collectionList;
				_list.width = _nativeStage.stageWidth - int(32*_scaleWidth);
				_list.height = _nativeStage.stageHeight - _header.height;
				_list.validate();
				_list.x = _nativeStage.stageWidth/2 - _list.width/2;
			}
			if(_menuBottom){
				_menuBottom.width = _nativeStage.stageWidth;
				_menuBottom.height = int(88*_scaleHeight);
				_menuBottom.y = _nativeStage.stageHeight - _menuBottom.height; 
			}
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerAddButton(event:Event):void{
			
		}
		
		private function _handlerBackButton(event:Event):void{
			dispatchEvent(new EventViewAbstract(EventViewAbstract.BACK_TO_VIEW_MAIN_SCREEN));	
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