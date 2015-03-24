package com.Application.robotlegs.views.open{
	import com.Application.robotlegs.model.vo.VOOpenList;
	import com.Application.robotlegs.model.vo.VOTableName;
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
	
	
	public class ViewOpen extends ViewAbstract {									
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
		
		private var _buttonEdit:Button;	
		private var _buttonBack:Button;	
		private var _buttonAddNewList:Button;	
		
		private var _bottomMenu:BottomMenu;
		
		private var _voOpenList:VOOpenList;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewOpen() {
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
		public function set vectorLists(value:Vector.<VOTableName>):void{
			if(!_collectionList){
				_collectionList = new ListCollection();
			}
			
			for (var i:int = 0; i < value.length; i++){
				_collectionList.push(value[i]);
			}
		}
		
		public function get voOpenList():VOOpenList{return _voOpenList;}
		public function set voOpenList(value:VOOpenList):void{_voOpenList = value;}
		
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewOpen.globalStyleProvider;
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
			
			_buttonAddNewList = new Button();
			_buttonAddNewList.addEventListener(Event.TRIGGERED, _handlerAddNewlist);
			_buttonAddNewList.visible = false;
			_buttonAddNewList.label = "Add new list";
			addChild(_buttonAddNewList);
			
			if(!_list){
				_list = new List();
				_list.hasElasticEdges = true;
				_list.itemRendererType = ItemrendererOpenList;
				addChild(_list);
			}
			
			_buttonEdit = new Button();
			_buttonEdit.label = "Edit";
			_buttonEdit.addEventListener(Event.TRIGGERED, _handlerEditButton);
			
			_buttonBack = new Button();
			_buttonBack.label = "Back";
			_buttonBack.addEventListener(Event.TRIGGERED, _handlerBackButton);
			
			this._header.rightItems = new <DisplayObject>
				[
					this._buttonEdit
				];
			this._header.leftItems = new <DisplayObject>
				[
					this._buttonBack
				];
			
			_bottomMenu = new BottomMenu();
			_bottomMenu.isHome = true;
			_bottomMenu.isSearch = true;
			_bottomMenu.isPack = true;
			addChild(_bottomMenu);
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.uPackingList");				
			}
			
			if(_buttonAddNewList){
				_buttonAddNewList.width = _nativeStage.stageWidth;
				_buttonAddNewList.y = _header.height + int(44*_scaleHeight);
			}
			
			if(_list){
				_layoutVertical.gap = int(16*_scaleHeight);
				_list.layout = _layoutVertical;	
				_list.dataProvider = _collectionList;
				_list.width = _nativeStage.stageWidth - int(32*_scaleWidth);
				_list.height = _nativeStage.stageHeight - _header.height;
				_list.validate();
				_list.x = _nativeStage.stageWidth/2 - _list.width/2;
				if(!_buttonAddNewList.visible){
					_list.y = _header.height + int(44*_scaleHeight);
				}else{
					_list.y = _buttonAddNewList.y + _buttonAddNewList.height + int(16*_scaleHeight);
				}
			}
			if(_bottomMenu){
				_bottomMenu.width = _nativeStage.stageWidth;
				_bottomMenu.height = int(88*_scaleHeight);
				_bottomMenu.y = _nativeStage.stageHeight - _bottomMenu.height; 
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerAddNewlist(event:Event):void{
			dispatchEvent(new EventViewAbstract(EventViewAbstract.CREATE_NEW_LIST));
		}
		
		private function _handlerEditButton(event:Event):void{
			if(_buttonEdit.label == "Edit"){
				_buttonEdit.label = "Done";	
				_buttonAddNewList.visible = true;
				
			}else{
				_buttonEdit.label = "Edit";	
				_buttonAddNewList.visible = false;
			}
			
			invalidate(INVALIDATION_FLAG_STYLES);
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