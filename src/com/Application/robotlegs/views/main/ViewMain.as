package com.Application.robotlegs.views.main {
	import com.Application.robotlegs.model.vo.VOMainMenu;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.renderers.ItemrendererMainMenu;
	import com.common.Constants;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	public class ViewMain extends ViewAbstract {									
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------		
		public var savedVerticalScrollPosition:Number = 0;
		public var savedSelectedIndex:int = -1;
		
		private var _layoutVertical:VerticalLayout;
		
		public static var globalStyleProvider:IStyleProvider;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _list:List;
		private var _buttonSettings:Button;	
		private var _collectionList:ListCollection;	
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewMain() {
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
			return ViewMain.globalStyleProvider;
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
						
			_collectionList = new ListCollection();
			
			var pVO:VOMainMenu = new VOMainMenu();
			pVO.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.newList");
			pVO.titleDesc = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.newListDesc");
			_collectionList.push(pVO);
			
			var pVO2:VOMainMenu = new VOMainMenu();
			pVO2.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.openList");
			pVO2.titleDesc = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.openListDesc");
			_collectionList.push(pVO2);
			
			var pVO3:VOMainMenu = new VOMainMenu();
			pVO3.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.packList");
			pVO3.titleDesc = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.packListDesc");
			_collectionList.push(pVO3);
			
			if(!_list){
				_list = new List();
				_list.hasElasticEdges = false;
				_list.itemRendererType = ItemrendererMainMenu;
				addChild(_list);
			}
			
			_buttonSettings = new Button();
			_buttonSettings.label = "Settings";
			_buttonSettings.addEventListener(Event.TRIGGERED, _handlerSettingsButton);
			this._header.rightItems = new <DisplayObject>
				[
					this._buttonSettings
				];
			
			
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.uPackingList");
				_header.width = _nativeStage.stageWidth;
			}
			if(_list){
				_layoutVertical.gap = int(88*_scaleHeight);
				_list.layout = _layoutVertical;	
				_list.dataProvider = _collectionList;
				_list.width = _nativeStage.stageWidth - int(32*_scaleWidth);
				_list.height = _nativeStage.stageHeight - _header.height;
				_list.validate();
				_list.x = _nativeStage.stageWidth/2 - _list.width/2;
				_list.y = _header.height + int(44*_scaleHeight);
			}
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------				
		private function _handlerSettingsButton(event:Event):void{
			dispatchEvent(new EventViewMain(EventViewMain.SHOW_SETTINGS_SCREEN));							
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