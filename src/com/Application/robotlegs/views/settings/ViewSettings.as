package com.Application.robotlegs.views.settings {
	import com.Application.robotlegs.views.ViewAbstract;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	
	public class ViewSettings extends ViewAbstract {									
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
		
		private var _backButton:Button;
		
		private var _buttonListExport:Button;
		private var _buttonListImport:Button;
		private var _buttonCatalogExport:Button;
		private var _buttonCatalogImport:Button;
		private var _buttonBluetooth:Button;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewSettings() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewSettings.globalStyleProvider;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			_backButton = new Button();
			_backButton.label = "Back";
			_backButton.addEventListener(Event.TRIGGERED, _handlerBackButton);
			this._header.leftItems = new <DisplayObject>
				[
					this._backButton
				];
			
			_buttonListExport = new Button();
			addChild(_buttonListExport);
	
			_buttonListImport = new Button();
			addChild(_buttonListImport);

			_buttonCatalogExport = new Button();
			addChild(_buttonCatalogExport);
	
			_buttonCatalogImport = new Button();
			addChild(_buttonCatalogImport);
	
			_buttonBluetooth = new Button();
			_buttonBluetooth.addEventListener(Event.TRIGGERED, _handlerButtonbluetooth);
			addChild(_buttonBluetooth);
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.settings");				
			}
			
			if(_buttonListExport){
				_buttonListExport.label = "List export";
				_buttonListExport.width = _nativeStage.stageWidth - int(32*_scaleWidth); 
				_buttonListExport.validate();
				_buttonListExport.x = int(16*_scaleWidth);
				_buttonListExport.y = _header.height + int(64*_scaleWidth);
			}
			if(_buttonListImport){
				_buttonListImport.label = "List import";
				_buttonListImport.width = _buttonListExport.width; 
				_buttonListImport.validate();
				_buttonListImport.x = _buttonListExport.x;
				_buttonListImport.y = _buttonListExport.y + _buttonListExport.height + int(8*_scaleHeight);
			}
			if(_buttonCatalogExport){
				_buttonCatalogExport.label = "Catalog export";
				_buttonCatalogExport.width = _buttonListExport.width; 
				_buttonCatalogExport.validate();
				_buttonCatalogExport.x = _buttonListImport.x;
				_buttonCatalogExport.y = _buttonListImport.y + _buttonListImport.height + int(8*_scaleHeight);
			}
			if(_buttonCatalogImport){
				_buttonCatalogImport.label = "Catalog import";
				_buttonCatalogImport.width = _buttonListExport.width; 
				_buttonCatalogImport.validate();
				_buttonCatalogImport.x = _buttonCatalogExport.x;
				_buttonCatalogImport.y = _buttonCatalogExport.y + _buttonCatalogExport.height + int(8*_scaleHeight);
			}
			if(_buttonBluetooth){
				_buttonBluetooth.label = "Via Bluetooth";
				_buttonBluetooth.width = _buttonListExport.width; 
				_buttonBluetooth.validate();
				_buttonBluetooth.x = _buttonCatalogImport.x;
				_buttonBluetooth.y = _buttonCatalogImport.y + _buttonCatalogImport.height + int(8*_scaleHeight);
			}
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerButtonbluetooth(event:Event):void{
			dispatchEvent(new EventViewSettings(EventViewSettings.USE_BLUETOOTH));
		}
		
		private function _handlerBackButton(event:Event):void{
			dispatchEvent(new EventViewSettings(EventViewSettings.SHOW_VIEW_MAIN_SCREEN));
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