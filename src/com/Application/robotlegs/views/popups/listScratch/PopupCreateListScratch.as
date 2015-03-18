package com.Application.robotlegs.views.popups.listScratch{
	import com.Application.robotlegs.model.vo.VOListCreate;
	import com.Application.robotlegs.views.popups.PopupAbstract;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class PopupCreateListScratch extends PopupAbstract{
		
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
		private var _buttonOk:Button;
		private var _inputText:TextInput;
		private var _label:Label;
		private var _quadBG:Quad;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopupCreateListScratch(){
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
			if(_inputText){
				removeChild(_inputText, true);
				_inputText = null;
			}
			if(_buttonCancel){
				_buttonCancel.removeEventListener(Event.TRIGGERED, _handlerbuttonCancel);
				removeChild(_buttonCancel, true);
				_buttonCancel = null;
			}
			if(_buttonOk){
				_buttonOk.removeEventListener(Event.TRIGGERED, _handlerButtonOk);
				removeChild(_buttonOk, true);
				_buttonOk = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return PopupCreateListScratch.globalStyleProvider;
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
			
			_inputText = new TextInput();
			addChild(_inputText);
			
			_buttonCancel = new Button();
			_buttonCancel.addEventListener(Event.TRIGGERED, _handlerbuttonCancel);
			addChild(_buttonCancel);
	
			_buttonOk = new Button();
			_buttonOk.addEventListener(Event.TRIGGERED, _handlerButtonOk);
			addChild(_buttonOk);
		}
		
		override protected function _draw():void{
			super._draw();
			
			if(_quadBG){
				_quadBG.width = _nativeStage.stageWidth - int(80*_scaleWidth);
				_quadBG.height = _nativeStage.stageHeight/int(8*_scaleHeight);
				_quadBG.x = _nativeStage.stageWidth/2 - _quadBG.width/2;
				_quadBG.y = _nativeStage.stageHeight/2 - _quadBG.height/2; 
			}
			
			if(_label){
				_label.text = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "title.create.list");
				_label.validate();
				_label.x = _quadBG.width/2 - _label.width/2;
				_label.y = _quadBG.y + int(32*_scaleHeight);
			}
			if(_inputText){
				_inputText.width = _quadBG.width - int(32*_scaleHeight);
				_inputText.x = _quadBG.x + int(16*_scaleHeight);
				_inputText.y = _label.y + int(32*_scaleHeight);
			}
			
			if(_buttonCancel){
				_buttonCancel.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.cancel");
				_buttonCancel.validate();
				_buttonCancel.x = _nativeStage.stageWidth/2 - _buttonCancel.width - int(16*_scaleWidth); 
				_buttonCancel.y = _inputText.y + _inputText.height + int(32*_scaleHeight);
			}
			if(_buttonOk){
				_buttonOk.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.ok");
				_buttonOk.validate();
				_buttonOk.x = _nativeStage.stageWidth/2 + int(16*_scaleWidth); 
				_buttonOk.y = _inputText.y + _inputText.height + int(32*_scaleHeight);
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerbuttonCancel(event:Event):void{
			dispatchEvent(new EventPopupCreateListScratch(EventPopupCreateListScratch.CLOSE_POPUP_CREATE));
		}
		
		private function _handlerButtonOk(event:Event):void{
			if(_inputText.text.length > 0 && _inputText.text.split(" ").join("").length > 0){
				var pVO:VOListCreate = new VOListCreate();
				pVO.nameList = _inputText.text;
				pVO.isScratch = true;
				dispatchEvent(new EventPopupCreateListScratch(EventPopupCreateListScratch.POPUP_CREATE_SET_NAME, pVO));
			}
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