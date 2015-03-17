package com.Application.robotlegs.views.popups.listExisting{
	import com.Application.robotlegs.views.popups.PopupAbstract;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class PopupCreateListExisting extends PopupAbstract{
		
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
		
		private var _buttonCancel:Button;
		private var _buttonScratch:Button;
		private var _buttonExisting:Button;
		private var _label:Label;
		private var _quadBG:Quad;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopupCreateListExisting(){
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function destroy():void{
			if(_quadBG){
				removeChild(_quadBG, true);
				_quadBG = null;
			}
			if(_label){
				removeChild(_label, true);
				_label = null;
			}
			
			if(_buttonCancel){
				_buttonCancel.removeEventListener(Event.TRIGGERED, _handlerbuttonCancel);
				removeChild(_buttonCancel, true);
				_buttonCancel = null;
			}
			if(_buttonExisting){
				_buttonExisting.removeEventListener(Event.TRIGGERED, _handlerButtonExisting);
				removeChild(_buttonExisting, true);
				_buttonExisting = null;
			}
			if(_buttonScratch){
				_buttonScratch.removeEventListener(Event.TRIGGERED, _handlerButtonScratch);
				removeChild(_buttonScratch);
				_buttonScratch = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return PopupCreateListExisting.globalStyleProvider;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			_quadBG = new Quad(10,10,0x999999);
			addChild(_quadBG);
			
			_label = new Label();
			addChild(_label);
			
			_buttonScratch = new Button();
			_buttonScratch.addEventListener(Event.TRIGGERED, _handlerButtonScratch);
			addChild(_buttonScratch);
			
			_buttonExisting = new Button();
			_buttonExisting.addEventListener(Event.TRIGGERED, _handlerButtonExisting);
			addChild(_buttonExisting);
			
			_buttonCancel = new Button();
			_buttonCancel.addEventListener(Event.TRIGGERED, _handlerbuttonCancel);
			addChild(_buttonCancel);
	
		}
		
		override protected function _draw():void{
			super._draw();
			
			if(_quadBG){
				_quadBG.width = _nativeStage.stageWidth - int(80*_scaleWidth);
				_quadBG.height = int(360*_scaleHeight);
				_quadBG.x = _nativeStage.stageWidth/2 - _quadBG.width/2;
				_quadBG.y = _nativeStage.stageHeight/2 - _quadBG.height/2; 
			}
			
			if(_label){
				_label.text = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "title.create.list");
				_label.validate();
				_label.x = _quadBG.width/2 - _label.width/2;
				_label.y = _quadBG.y + int(32*_scaleHeight);
			}
			
			if(_buttonScratch){
				_buttonScratch.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.scratch");
				_buttonScratch.validate();
				_buttonScratch.x = _nativeStage.stageWidth/2 -_buttonScratch.width/2; 
				_buttonScratch.y = _label.y + _label.height + int(32*_scaleHeight);
			}
			
			if(_buttonExisting){
				_buttonExisting.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.existing");
				_buttonExisting.validate();
				_buttonExisting.x = _nativeStage.stageWidth/2 -_buttonExisting.width/2; 
				_buttonExisting.y = _buttonScratch.y + _buttonScratch.height + int(16*_scaleHeight);
			}
			
			if(_buttonCancel){
				_buttonCancel.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.cancel");
				_buttonCancel.validate();
				_buttonCancel.x = _nativeStage.stageWidth/2 - _buttonCancel.width/2; 
				_buttonCancel.y = _buttonExisting.y + _buttonExisting.height + int(16*_scaleHeight);
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerbuttonCancel(event:Event):void{
			dispatchEvent(new EventPopupCreateListExisting(EventPopupCreateListExisting.CLOSE_POPUP_CREATE));
		}
		
		private function _handlerButtonScratch(event:Event):void{
			dispatchEvent(new EventPopupCreateListExisting(EventPopupCreateListExisting.POPUP_CREATE_SET_NAME));
		}
		
		private function _handlerButtonExisting(event:Event):void{
			dispatchEvent(new EventPopupCreateListExisting(EventPopupCreateListExisting.POPUP_CREATE_USE_EXISTING));
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