package com.Application.robotlegs.views.popups.removeItem {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.popups.PopupAbstract;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class PopupRemoveItem extends PopupAbstract {		
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
		private var _buttonNo:Button;
		private var _buttonYes:Button;		
		private var _label:Label;
		private var _quadBG:Quad;
		
		private var _data:VOPackedItem;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function PopupRemoveItem() {
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
			
			if(_buttonNo){
				_buttonNo.removeEventListener(Event.TRIGGERED, _handlerButtonNo);
				removeChild(_buttonNo, true);
				_buttonNo = null;
			}
			if(_buttonYes){
				_buttonYes.removeEventListener(Event.TRIGGERED, _handlerButtonYes);
				removeChild(_buttonYes, true);
				_buttonYes = null;
			}
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return PopupRemoveItem.globalStyleProvider;
		}
	
		public function get data():VOPackedItem { return _data;}
		public function set data(value:VOPackedItem):void{
			_data = value;
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
			
			if(_data.isChild){
				_label.text = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "title.removeItem");
			} else {
				_label.text = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "title.removeCategory");
			}
			
			addChild(_label);
			_label.validate();
	
			
			_buttonYes = new Button();
			_buttonYes.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.yes");
			_buttonYes.addEventListener(Event.TRIGGERED, _handlerButtonYes);
			addChild(_buttonYes);
			_buttonYes.validate();
			
			_buttonNo = new Button();
			_buttonNo.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.no");
			_buttonNo.addEventListener(Event.TRIGGERED, _handlerButtonNo);
			addChild(_buttonNo);
			_buttonNo.validate();
			
		}
		
		override protected function _draw():void{
			super._draw();
			
			if(_quadBG){
				_quadBG.width = _nativeStage.stageWidth - int(80*_scaleWidth);
				_quadBG.height = int(200*_scaleHeight);
				_quadBG.x = _nativeStage.stageWidth/2 - _quadBG.width/2;
				_quadBG.y = _nativeStage.stageHeight/2 - _quadBG.height/2; 
			}
			
			if(_label){								
				_label.x = _quadBG.width/2 - _label.width/2;
				_label.y = _quadBG.y + int(32*_scaleHeight);
			}
			
			
			if(_buttonYes){				
				_buttonYes.x = _nativeStage.stageWidth/2 - _buttonYes.width - (20*_scaleWidth); 
				_buttonYes.y = _quadBG.y + _quadBG.height - _buttonYes.height - int(16*_scaleHeight);
			}			
			if(_buttonNo){				
				_buttonNo.x = _nativeStage.stageWidth/2 + (20*_scaleWidth) ; 
				_buttonNo.y = _buttonYes.y;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerButtonNo(event:Event):void{
			dispatchEvent(new EventPopupRemoveItem(EventPopupRemoveItem.NO));
		}
				
		
		private function _handlerButtonYes(event:Event):void{
			dispatchEvent(new EventPopupRemoveItem(EventPopupRemoveItem.YES));
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