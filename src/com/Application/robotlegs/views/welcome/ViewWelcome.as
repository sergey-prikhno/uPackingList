package com.Application.robotlegs.views.welcome {
	import com.Application.EventMain;
	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.common.Constants;
	
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.ToggleSwitch;
	import feathers.skins.IStyleProvider;
	
	import starling.events.Event;
	
	public class ViewWelcome extends ViewAbstract {		
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
		private var _labelTitle:Label;
		private var _labelDescription:Label;
		
		private var _labelCreate:Label;
		private var _labelCreateDescription:Label;
		
		private var _labelEdit:Label;
		private var _labelEditDescription:Label;
		
		private var _labelPack:Label;
		private var _labelPackDescription:Label;
		
		private var _labelBottomDescription:Label;
		
		private var _labelNiceJourney:Label;
		private var _labelAlwaysShow:Label;	
		
		private var _scrollContainer:ScrollContainer;	
		
		private var _baseTextFormat:ElementFormat;
		private var _toggleButton:ToggleSwitch;
		
		private var _buttonContinue:Button;
		
		private var _settings:VOAppSettings;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewWelcome() {
			super();
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function destroy():void{
			
			if(_labelTitle){
				_scrollContainer.removeChild(_labelTitle);	
				_labelTitle = null;
			}
			
			
			if(_labelDescription){
				_scrollContainer.removeChild(_labelDescription);	
				_labelDescription = null;
			}
			
			if(_labelCreate){
				_scrollContainer.removeChild(_labelCreate);	
				_labelCreate = null;
			}
			
			if(_labelCreateDescription){
				_scrollContainer.removeChild(_labelCreateDescription);	
				_labelCreateDescription = null;
			}
			
			if(_labelEdit){
				_scrollContainer.removeChild(_labelEdit);	
				_labelEdit = null;
			}
			
			if(_labelEditDescription){
				_scrollContainer.removeChild(_labelEditDescription);	
				_labelEditDescription = null;
			}
			
			if(_labelPack){
				_scrollContainer.removeChild(_labelPack);	
				_labelPack = null;
			}
			
			if(_labelPackDescription){
				_scrollContainer.removeChild(_labelPackDescription);	
				_labelPackDescription = null;
			}
			
			if(_labelBottomDescription){
				_scrollContainer.removeChild(_labelBottomDescription);	
				_labelBottomDescription = null;
			}
			
			if(_labelNiceJourney){
				_scrollContainer.removeChild(_labelNiceJourney);	
				_labelNiceJourney = null;
			}
			
			if(_labelAlwaysShow){
				_scrollContainer.removeChild(_labelAlwaysShow);	
				_labelAlwaysShow = null;
			}					
			
			if(_toggleButton){						
				_scrollContainer.removeChild(_toggleButton);
				_toggleButton = null;
			}			
			
			if(_buttonContinue){
				_buttonContinue.removeEventListener(Event.TRIGGERED, _handlerContinue);
				_scrollContainer.removeChild(_buttonContinue);	
				_buttonContinue = null;
			}
			
			if(_scrollContainer){
				removeChild(_scrollContainer);
				_scrollContainer = null;
			}			
			
			
			
			super.destroy();			
		}
		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewWelcome.globalStyleProvider;
		}
		
		public function set baseTextFormat(value:ElementFormat):void{
			_baseTextFormat = value;
			_updateTextFormats();						
		}
		
		public function set settings(value:VOAppSettings):void{
			_settings = value;
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function _initialize():void 	{			
			super._initialize();			
			
			if(_header){
				removeChild(_header);
				_header = null;
			}
			
			_scrollContainer = new ScrollContainer();
			_scrollContainer.width = _nativeStage.fullScreenWidth;
			_scrollContainer.height = _nativeStage.fullScreenHeight;
			_scrollContainer.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			addChild(_scrollContainer);			
			
			_labelTitle = new Label();
			_labelTitle.maxWidth = _nativeStage.fullScreenWidth*0.9;
			_labelTitle.wordWrap = true;
			_labelTitle.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.title");
			_scrollContainer.addChild(_labelTitle);
			
			_labelDescription = new Label();
			_labelDescription.maxWidth =_labelTitle.maxWidth;
			_labelDescription.wordWrap = true;
			_labelDescription.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.description");
			_scrollContainer.addChild(_labelDescription);
			
			_labelCreate = new Label();
			_labelCreate.maxWidth =_labelTitle.maxWidth;
			_labelCreate.wordWrap = true;
			_labelCreate.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.titleCreate");
			_scrollContainer.addChild(_labelCreate);
			
			_labelCreateDescription = new Label();
			_labelCreateDescription.maxWidth =_labelTitle.maxWidth;
			_labelCreateDescription.wordWrap = true;
			_labelCreateDescription.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.descriptionCreate");
			_scrollContainer.addChild(_labelCreateDescription);
			
			_labelEdit = new Label();
			_labelEdit.maxWidth =_labelTitle.maxWidth;
			_labelEdit.wordWrap = true;
			_labelEdit.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.titleEdit");
			_scrollContainer.addChild(_labelEdit);
			
			_labelEditDescription = new Label();
			_labelEditDescription.maxWidth =_labelTitle.maxWidth;
			_labelEditDescription.wordWrap = true;
			_labelEditDescription.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.descriptionEdit");
			_scrollContainer.addChild(_labelEditDescription);
			
			_labelPack = new Label();
			_labelPack.maxWidth =_labelTitle.maxWidth;
			_labelPack.wordWrap = true;
			_labelPack.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.titlePack");
			_scrollContainer.addChild(_labelPack);
			
			_labelPackDescription = new Label();
			_labelPackDescription.maxWidth =_labelTitle.maxWidth;
			_labelPackDescription.wordWrap = true;
			_labelPackDescription.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.descriptionPack");
			_scrollContainer.addChild(_labelPackDescription);
			
			_labelBottomDescription = new Label();
			_labelBottomDescription.maxWidth =_labelTitle.maxWidth;
			_labelBottomDescription.wordWrap = true;
			_labelBottomDescription.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.descriptionBottom");			
			_scrollContainer.addChild(_labelBottomDescription);
			
			
			_labelNiceJourney = new Label();
			_labelNiceJourney.maxWidth =_labelTitle.maxWidth;
			_labelNiceJourney.wordWrap = true;
			_labelNiceJourney.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.niceJourney");
			_scrollContainer.addChild(_labelNiceJourney);			
			
			
			_labelAlwaysShow = new Label();
			_labelAlwaysShow.maxWidth =_labelTitle.maxWidth;
			_labelAlwaysShow.wordWrap = true;
			_labelAlwaysShow.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.labelShow");
			_scrollContainer.addChild(_labelAlwaysShow);		
			
			
			_toggleButton = new ToggleSwitch();			
			_toggleButton.isSelected = true;			
			_scrollContainer.addChild(_toggleButton);			
			
			_buttonContinue = new Button();
			_buttonContinue.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "welcomScreen.continue");
			_scrollContainer.addChild(_buttonContinue);
			_buttonContinue.addEventListener(Event.TRIGGERED, _handlerContinue);
			
		}		
		
		
		private function _updateTextFormats():void{
			
			if(_labelTitle){
				_labelTitle.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelTitle.validate();
				_labelTitle.x = int(_nativeStage.fullScreenWidth/2 - _labelTitle.width/2);
				_labelTitle.y = int(30*_scaleHeight);
			}
			
			if(_labelDescription){				
				_labelDescription.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelDescription.validate();
				_labelDescription.x = int((_nativeStage.fullScreenWidth - _labelDescription.width)/2);
				_labelDescription.y = int(_labelTitle.y + _labelTitle.height*2);
			}
			
			if(_labelCreate){				
				_labelCreate.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelCreate.validate();
				_labelCreate.x = _labelDescription.x;
				_labelCreate.y = int(_labelDescription.y + _labelDescription.height*2);
			}
			
			if(_labelCreateDescription){				
				_labelCreateDescription.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelCreateDescription.validate();
				_labelCreateDescription.x = _labelCreate.x;
				_labelCreateDescription.y = int(_labelCreate.y + _labelCreate.height*1.5);
			}
			
			if(_labelEdit){				
				_labelEdit.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelEdit.validate();
				_labelEdit.x = _labelCreateDescription.x;
				_labelEdit.y = int(_labelCreateDescription.y + _labelEdit.height*3);
			}
			
			if(_labelEditDescription){				
				_labelEditDescription.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelEditDescription.validate();
				_labelEditDescription.x = int(_nativeStage.fullScreenWidth/2 - _labelEditDescription.width/2);
				_labelEditDescription.y = int(_labelEdit.y + _labelEdit.height*1.5);
			}
			
			if(_labelPack){				
				_labelPack.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelPack.validate();
				_labelPack.x = _labelCreate.x;
				_labelPack.y = int(_labelEditDescription.y + _labelEditDescription.height + _labelPack.height*3);
			}
			
			if(_labelPackDescription){				
				_labelPackDescription.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelPackDescription.validate();
				_labelPackDescription.x = _labelCreate.x;
				_labelPackDescription.y = int(_labelPack.y + _labelPack.height*1.5);
			}
			
			
			if(_labelBottomDescription){												
				_labelBottomDescription.textRendererProperties.elementFormat = _baseTextFormat;					
				_labelBottomDescription.validate();				
				_labelBottomDescription.x = int(_nativeStage.fullScreenWidth/2 - _labelBottomDescription.width/2);
				_labelBottomDescription.y = int(_labelPackDescription.y + _labelPackDescription.height + 80*_scaleHeight);
			}
			
			
			if(_labelNiceJourney){				
				_labelNiceJourney.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelNiceJourney.validate();				
				_labelNiceJourney.x = int(_nativeStage.fullScreenWidth/2 - _labelNiceJourney.width/2);
				_labelNiceJourney.y = int(_labelBottomDescription.y + _labelBottomDescription.height + 40*_scaleHeight);
			}
			
			if(_labelAlwaysShow){				
				_labelAlwaysShow.textRendererProperties.elementFormat = _baseTextFormat;				
				_labelAlwaysShow.validate();				
				_labelAlwaysShow.x = _labelCreate.x;
				_labelAlwaysShow.y = int(_labelNiceJourney.y + _labelNiceJourney.height + 30*_scaleHeight);
			}			
			
			
			if(_toggleButton){
				_toggleButton.validate();
				_toggleButton.x = int(_nativeStage.fullScreenWidth - _labelAlwaysShow.x  - _toggleButton.width);
				_toggleButton.y = _labelAlwaysShow.y;
			}
			
			if(_buttonContinue){
				_buttonContinue.validate()
				_buttonContinue.x = int(_nativeStage.fullScreenWidth/2 - _buttonContinue.width/2);
				_buttonContinue.y = int(_toggleButton.y + _toggleButton.height + 40*_scaleHeight);
			}
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerContinue(event:Event):void{
			if(_toggleButton.isSelected){
				_settings.welcome = "1";
			} else {
				_settings.welcome = "0";
			}
			
			dispatchEvent(new EventViewAbstract(EventViewAbstract.UPDATE_SETTINGS, false, _settings));
			
			dispatchEvent(new EventMain(EventMain.SHOW_VIEW_MAIN));
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