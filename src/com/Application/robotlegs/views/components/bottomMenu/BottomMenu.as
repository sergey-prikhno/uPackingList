package com.Application.robotlegs.views.components.bottomMenu{
	import feathers.controls.Button;
	import feathers.core.FeathersControl;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class BottomMenu extends FeathersControl{
		
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
		
		private var _quadBG:Quad;
		
		private var _isHome:Boolean = false;
		private var _isCheckAll:Boolean = false;
		private var _isSearch:Boolean = false;
		private var _isMail:Boolean = false;
		private var _isUndo:Boolean = false;
		private var _isCollapse:Boolean = false;
		private var _isPack:Boolean = false;
	
		private var _buttonHome:Button;
		private var _buttonCheckAll:Button;
		private var _buttonSearch:Button;
		private var _buttonMail:Button;
		private var _buttonUndo:Button;
		private var _buttonCollapse:Button;
		private var _buttonPack:Button;
		
		private var _scaleWidth:Number = 1;
		private var _scaleHeight:Number = 1;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function BottomMenu(){
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function destroy():void{
			
			if(_buttonHome){				 
				_buttonHome.removeEventListener(Event.TRIGGERED, _handlerHome);
				removeChild(_buttonHome);
				_buttonHome = null;
			}
			
			if(_buttonSearch){
				_buttonSearch.removeEventListener(Event.TRIGGERED, _handlerSearch);				
				removeChild(_buttonSearch);
				_buttonSearch = null;
			}
			
			if(_buttonPack){				 
				_buttonPack.removeEventListener(Event.TRIGGERED, _handlerPack);
				removeChild(_buttonPack);
				_buttonPack = null;
			}
			
			
			if(_buttonCollapse){
				_buttonCollapse.removeEventListener(Event.TRIGGERED, _handlerCollapse);
				removeChild(_buttonCollapse);
				_buttonCollapse = null;
			}
			 
			if(_buttonUndo){				 
				_buttonUndo.removeEventListener(Event.TRIGGERED, _handlerUndo);
				removeChild(_buttonUndo);
				_buttonUndo = null;
			}
			
			if(_buttonMail){				 
				_buttonMail.removeEventListener(Event.TRIGGERED, _handlerMail);
				removeChild(_buttonMail);
				_buttonMail = null;
			}
			
			if(_buttonCheckAll){											
				_buttonCheckAll.removeEventListener(Event.TRIGGERED, _handlerCheckAll);
				removeChild(_buttonCheckAll);
				_buttonCheckAll = null;
			}
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function set scaleHeight(value:Number):void{_scaleHeight = value;}
		public function set scaleWidth(value:Number):void{_scaleWidth = value;}
		
		public function set isPack(value:Boolean):void{_isPack = value;}
		public function set isCollapse(value:Boolean):void{	_isCollapse = value;}
		public function set isUndo(value:Boolean):void{_isUndo = value;}
		public function set isMail(value:Boolean):void{	_isMail = value;}
		public function set isSearch(value:Boolean):void{_isSearch = value;}
		public function set isCheckAll(value:Boolean):void{_isCheckAll = value;}
		public function set isHome(value:Boolean):void{	_isHome = value;}

		override protected function get defaultStyleProvider():IStyleProvider {
			return BottomMenu.globalStyleProvider;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function initialize():void{
			_quadBG = new Quad(10, 10, 0x333333);
			addChild(_quadBG);

			if(_isHome && _isSearch && _isPack && !_isCollapse && !_isUndo && !_isMail && !_isCheckAll){
				_buttonHome = new Button();
				_buttonHome.addEventListener(Event.TRIGGERED, _handlerHome);
				addChild(_buttonHome);
			
				_buttonSearch = new Button();
				_buttonSearch.addEventListener(Event.TRIGGERED, _handlerSearch);				
				addChild(_buttonSearch);
	
				_buttonPack = new Button();
				_buttonPack.addEventListener(Event.TRIGGERED, _handlerPack);
				addChild(_buttonPack);
			}
			
			if(_isHome && _isSearch && _isPack && _isCollapse && !_isUndo && !_isMail && !_isCheckAll){
				_buttonHome = new Button();
				_buttonHome.addEventListener(Event.TRIGGERED, _handlerHome);
				addChild(_buttonHome);
				
				_buttonSearch = new Button();
				_buttonSearch.addEventListener(Event.TRIGGERED, _handlerSearch);
				addChild(_buttonSearch);
				
				_buttonCollapse = new Button();
				_buttonCollapse.addEventListener(Event.TRIGGERED, _handlerCollapse);
				addChild(_buttonCollapse);
				
				_buttonPack = new Button();
				_buttonPack.addEventListener(Event.TRIGGERED, _handlerPack);
				addChild(_buttonPack);
			}
			
			if(_isHome && _isSearch && !_isPack && !_isCollapse && _isUndo && _isMail && _isCheckAll){
				_buttonHome = new Button();
				_buttonHome.addEventListener(Event.TRIGGERED, _handlerHome);
				addChild(_buttonHome);
				
				_buttonSearch = new Button();
				_buttonSearch.addEventListener(Event.TRIGGERED, _handlerSearch);
				addChild(_buttonSearch);
				
				_buttonUndo = new Button();
				_buttonUndo.addEventListener(Event.TRIGGERED, _handlerUndo);
				addChild(_buttonUndo);
				
				_buttonMail = new Button();
				_buttonMail.addEventListener(Event.TRIGGERED, _handlerMail);
				addChild(_buttonMail);
	
				_buttonCheckAll = new Button();
				_buttonCheckAll.addEventListener(Event.TRIGGERED, _handlerCheckAll);
				addChild(_buttonCheckAll);
			}
			
			if(_isHome && !_isSearch && !_isPack && !_isCollapse && !_isUndo && !_isMail && !_isCheckAll){
				_buttonHome = new Button();
				_buttonHome.addEventListener(Event.TRIGGERED, _handlerHome);
				addChild(_buttonHome);
			}	
		}
		
		override protected function draw():void{
			if(_quadBG){
				_quadBG.width = actualWidth;
				_quadBG.height = actualHeight;
			}
			
			if(_isHome && !_isSearch && !_isPack && !_isCollapse && !_isUndo && !_isMail && !_isCheckAll){
				if(_buttonHome){
					_buttonHome.label = "Home";
					_buttonHome.validate();
					_buttonHome.x = int(16*_scaleWidth);
					_buttonHome.y = actualHeight/2 - _buttonHome.height/2; 
				}
			}
			
			if(_isHome && _isSearch && _isPack && !_isCollapse && !_isUndo && !_isMail && !_isCheckAll){
				if(_buttonHome){
					_buttonHome.label = "Home";
					_buttonHome.validate();
					_buttonHome.x = int(16*_scaleWidth);
					_buttonHome.y = actualHeight/2 - _buttonHome.height/2; 
				}
				if(_buttonSearch){
					_buttonSearch.label = "Search";
					_buttonSearch.validate();
					_buttonSearch.x = actualWidth/2 - _buttonSearch.width/2;
					_buttonSearch.y = _buttonHome.y;
				}
				if(_buttonPack){
					_buttonPack.label = "Pack";
					_buttonPack.validate();
					_buttonPack.x = actualWidth - _buttonPack.width - int(16*_scaleWidth);
					_buttonPack.y = _buttonHome.y;
				}
			}
			
			if(_isHome && _isSearch && _isPack && _isCollapse && !_isUndo && !_isMail && !_isCheckAll){
				if(_buttonHome){
					_buttonHome.label = "Home";
					_buttonHome.validate();
					_buttonHome.x = int(16*_scaleWidth);
					_buttonHome.y = actualHeight/2 - _buttonHome.height/2; 
				}
				if(_buttonCollapse){
					_buttonCollapse.label = "Collapse";
					_buttonCollapse.validate();
					_buttonCollapse.x = actualWidth/2 - _buttonCollapse.width - _buttonCollapse.width/2;
					_buttonCollapse.y = _buttonHome.y; 
				}
				if(_buttonSearch){
					_buttonSearch.label = "Search";
					_buttonSearch.validate();
					_buttonSearch.x = actualWidth/2 + _buttonSearch.width/2;
					_buttonSearch.y = _buttonHome.y;
				}
				if(_buttonPack){
					_buttonPack.label = "Pack";
					_buttonPack.validate();
					_buttonPack.x = actualWidth - _buttonPack.width - int(16*_scaleWidth);
					_buttonPack.y = _buttonHome.y;
				}
			}
			
			if(_isHome && _isSearch && !_isPack && !_isCollapse && _isUndo && _isMail && _isCheckAll){
				if(_buttonHome){
					_buttonHome.label = "Home";
					_buttonHome.validate();
					_buttonHome.x = int(16*_scaleWidth);
					_buttonHome.y = actualHeight/2 - _buttonHome.height/2; 
				}
				if(_buttonSearch){
					_buttonSearch.label = "Search";
					_buttonSearch.validate();
					_buttonSearch.x = _buttonHome.x + _buttonHome.width + int(32*_scaleWidth);
					_buttonSearch.y = _buttonHome.y;
				}
				if(_buttonUndo){
					_buttonUndo.label = "Undo";
					_buttonUndo.validate();
					_buttonUndo.x = actualWidth/2 - _buttonUndo.width/2;
					_buttonUndo.y = _buttonHome.y;
				}
				if(_buttonCheckAll){
					_buttonCheckAll.label = "Check all";
					_buttonCheckAll.validate();
					_buttonCheckAll.x = _buttonUndo.x + _buttonUndo.width + int(32*_scaleWidth);
					_buttonCheckAll.y = _buttonHome.y;
				}
				if(_buttonMail){
					_buttonMail.label = "Mail";
					_buttonMail.validate();
					_buttonMail.x = actualWidth - _buttonMail.width - int(16*_scaleWidth);
					_buttonMail.y = _buttonHome.y;
				}
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerHome(event:Event):void{
			dispatchEvent(new EventBottomMenu(EventBottomMenu.HOME));
		}
		
		private function _handlerSearch(event:Event):void{
			dispatchEvent(new EventBottomMenu(EventBottomMenu.SEARCH));
		}
		
		private function _handlerPack(event:Event):void{
			dispatchEvent(new EventBottomMenu(EventBottomMenu.PACK));
		}
		
		private function _handlerCollapse(event:Event):void{
			dispatchEvent(new EventBottomMenu(EventBottomMenu.COLLAPSE));
		}
		
		private function _handlerUndo(event:Event):void{
			dispatchEvent(new EventBottomMenu(EventBottomMenu.UNDO));
		}
		
		private function _handlerMail(event:Event):void{
			dispatchEvent(new EventBottomMenu(EventBottomMenu.MAIL));
		}
		
		private function _handlerCheckAll(event:Event):void{
			dispatchEvent(new EventBottomMenu(EventBottomMenu.CHECK_ALL));
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