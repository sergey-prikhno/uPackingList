package com.Application {
	import com.Application.components.screenLoader.ScreenLoader;
	import com.Application.robotlegs.model.vo.VOAppStorageData;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.alert.AlertScreen;
	import com.Application.robotlegs.views.main.EventViewMain;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.settings.EventViewSettings;
	import com.Application.robotlegs.views.settings.ViewSettings;
	import com.Application.robotlegs.views.welcome.ViewWelcome;
	import com.Application.themes.ApplicationTheme;
	import com.common.Constants;
	
	import flash.system.System;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Drawers;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	import feathers.motion.Fade;
	import feathers.motion.Slide;
	
	import org.robotlegs.starling.mvcs.Context;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class Main extends Drawers {
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private var _theme:ApplicationTheme;		
		private var _locales:LocaleManager;		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private static const VIEW_MAIN_MENU:String = "VIEW_MAIN_MENU";
		private static const VIEW_ALERT:String = "VIEW_ALERT";
		private static const VIEW_WELCOME:String = "VIEW_WELCOME";		
		private static const VIEW_SETTINGS:String = "VIEW_SETTINGS";		
		
		private var _navigator:StackScreenNavigator;				
		private var _screenCurrent:ViewAbstract;
		
		private static const MAIN_MENU_EVENTS:Object = 	{
			//SHOW_ALERT: VIEW_ALERT			
		};
		
		// Garbage collector calls handling
		private var _garbageCollectorCallCount:int;
		private var _garbageCollectorCallTimeout:int;
		
		private var _starlingContext:Context;
		
		private var _screenLoader:ScreenLoader;
		private var _settings:VOAppStorageData;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function Main() 	{
			super();			
			
			_starlingContext = new StarlingAppContext(this);
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
			
			this._navigator = new StackScreenNavigator();
			this.content = this._navigator;
						
			
			_locales = new LocaleManager();
			_locales.localeChain = ["en_US"];			
			_locales.addRequiredBundles([{locale:"en_US", bundleName:Constants.RESOURCES_BUNDLE, useLinebreak:true}], _handlerLocaleLoaded);
		}		
		
		
		public function addLoader():void {
			if(!_screenLoader.visible){																								
				_screenLoader.visible = true;		
				_navigator.touchable = false;
			}
		}
		
		public function removeLoader():void {
			if(_screenLoader.visible){				
				_screenLoader.visible = false;
				_navigator.touchable = true;
			}			
		}			
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set settings(value:VOAppStorageData):void{
			_settings = value;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerLocaleLoaded(event:* = null):void{
			
			_theme = new ApplicationTheme("/assets/textures/");
			
			_theme.addEventListener(Event.COMPLETE, _handlerThemeCreated);
			_theme.addEventListener(Event.CHANGE, _handlerChange);						
		}
		
		
		private function _handlerThemeCreated(event:Event):void{									
			Starling.current.dispatchEvent(new Event(Event.ADDED_TO_STAGE,true));							
			
			_theme.removeEventListener(Event.COMPLETE, _handlerThemeCreated);		
			_theme.removeEventListener(Event.CHANGE, _handlerChange);			
			
			
			var alertItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(AlertScreen);
				alertItem.setScreenIDForPushEvent(Event.COMPLETE, VIEW_WELCOME);
				//alertItem.addPopToRootEvent(Event.COMPLETE);
			//	alertItem.addPopEvent(Event.COMPLETE);			
			this._navigator.addScreen(VIEW_ALERT, alertItem);								
			
			
			var mainMenuItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewMain);
				mainMenuItem.setScreenIDForPushEvent(EventViewMain.SHOW_SETTINGS_SCREEN, VIEW_SETTINGS);
			
			var settingsItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewSettings);
				settingsItem.pushTransition = Slide.createSlideRightTransition();
				settingsItem.setScreenIDForPushEvent(EventViewSettings.SHOW_VIEW_MAIN_SCREEN, VIEW_MAIN_MENU);
			this._navigator.addScreen(VIEW_SETTINGS, settingsItem);
			
			
			
			this._navigator.addScreen(VIEW_MAIN_MENU, mainMenuItem);
			
			
							
			
			_navigator.addEventListener(FeathersEventType.TRANSITION_START, _handlerTransition);
			_navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, _handlerTransition);
			
			
			if(_settings.isStarScreenShow == "1"){
				var viewStart:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewWelcome);		
					viewStart.setScreenIDForPushEvent(EventMain.SHOW_VIEW_MAIN, VIEW_MAIN_MENU);
					viewStart.pushTransition = Fade.createFadeInTransition();					
					
				this._navigator.addScreen(VIEW_WELCOME, viewStart);				
				this._navigator.pushScreen(VIEW_WELCOME);
				this._navigator.rootScreenID = VIEW_WELCOME;		
			} else {
				this._navigator.rootScreenID = VIEW_MAIN_MENU;	
			}
			
			this._navigator.pushTransition = Slide.createSlideLeftTransition();
			this._navigator.popTransition = Slide.createSlideRightTransition();	
			
			_screenLoader = new ScreenLoader();
			addChild(_screenLoader);	
			_screenLoader.touchable = false;
			_screenLoader.isEnabled = false;
			_screenLoader.visible = false;
		}
		
		private function _handlerChange(event:Event):void{
			trace("downloading "+event.data.progress+ " % ");			
		}	
		
		private function _handlerTransition(event:Event):void{
			
			switch (event.type){
				case FeathersEventType.TRANSITION_START:
					//	addLoader();
					
					trace("> FeathersEventType.TRANSITION_START");
					/*if(_screenCurrent){
					// Stopping current view animations and removing controls listeners 
						_screenCurrent.destroy();
					}*/
					break;
				case FeathersEventType.TRANSITION_COMPLETE:
					trace("> FeathersEventType.TRANSITION_COMPLETE");						
					
					if(_screenCurrent){
						// Stopping current view animations and removing controls listeners 
						_screenCurrent.destroy();												
					}
				
					// Assigining new page as a current view
					_screenCurrent = ViewAbstract(_navigator.activeScreen);
					_screenCurrent.activate();										
					// Trigger cleaning up old oview belongings
					_startGarbageCollectorCycle();										
																		
					break;
			}					
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		/**
		 * GarbageCollector trigger
		 * http://www.craftymind.com/2008/04/09/kick-starting-the-garbage-collector-in-actionscript-3-with-air/
		 * 
		 */
		private function _startGarbageCollectorCycle():void{
			_garbageCollectorCallCount = 0;
			addEventListener(Event.ENTER_FRAME, _doGarbageCollect);
		}
		private function _doGarbageCollect(evt:Event):void{
			flash.system.System.gc();			
			if(++_garbageCollectorCallCount > 1){
				removeEventListener(Event.ENTER_FRAME, _doGarbageCollect);
				_garbageCollectorCallTimeout = setTimeout(_lastGC, 40);
			}
		}
		private function _lastGC():void{
			clearTimeout(_garbageCollectorCallTimeout);
			flash.system.System.gc();			
		}
				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}