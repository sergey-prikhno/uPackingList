package com.Application {
	import com.Application.components.screenLoader.ScreenLoader;
	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOScreenID;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.addCategory.ViewAddCategory;
	import com.Application.robotlegs.views.addItem.ViewAddItem;
	import com.Application.robotlegs.views.main.EventViewMain;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.open.ViewOpen;
	import com.Application.robotlegs.views.pack.ViewPack;
	import com.Application.robotlegs.views.packedList.EventViewPackedList;
	import com.Application.robotlegs.views.packedList.ViewPackedList;
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
		public static const VIEW_MAIN_MENU:String = "VIEW_MAIN_MENU";		
		public static const VIEW_WELCOME:String = "VIEW_WELCOME";		
		public static const VIEW_SETTINGS:String = "VIEW_SETTINGS";
		public static const VIEW_PACKED_LIST:String = "VIEW_PACKED_LIST";		
		public static const VIEW_OPEN:String = "VIEW_OPEN";		
		public static const VIEW_ADD_ITEM:String = "VIEW_ADD_ITEM";
		public static const VIEW_ADD_CATEGORY:String = "VIEW_ADD_CATEGORY";
		public static const VIEW_PACK:String = "VIEW_PACK";
		
		private var _navigator:StackScreenNavigator;				
		private var _screenCurrent:ViewAbstract;		
		
		// Garbage collector calls handling
		private var _garbageCollectorCallCount:int;
		private var _garbageCollectorCallTimeout:int;
		
		private var _starlingContext:Context;
		
		private var _screenLoader:ScreenLoader;
		private var _settings:VOAppSettings;
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
		
		public function changeScreen(pVO:VOScreenID):void{
			_navigator.pushScreen(pVO.screenID);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set settings(value:VOAppSettings):void{
			_settings = value;
			_continueAppInit();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function _continueAppInit():void{
			
			Starling.current.dispatchEvent(new Event(Event.ADDED_TO_STAGE,true));							
			
			var mainMenuItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewMain);				
				mainMenuItem.setScreenIDForPushEvent(EventViewMain.SHOW_SETTINGS_SCREEN, VIEW_SETTINGS);
			this._navigator.addScreen(VIEW_MAIN_MENU, mainMenuItem);

			
			var settingsItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewSettings);			
				settingsItem.setScreenIDForPushEvent(EventViewSettings.SHOW_VIEW_MAIN_SCREEN, VIEW_MAIN_MENU);
			this._navigator.addScreen(VIEW_SETTINGS, settingsItem);									
			
			
			var packedListItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewPackedList);				
				packedListItem.setScreenIDForPushEvent(EventViewPackedList.BACK_TO_PREVIOUS_SCREEN, VIEW_MAIN_MENU);
			this._navigator.addScreen(VIEW_PACKED_LIST, packedListItem);
									
			var openItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewOpen);				
				openItem.setScreenIDForPushEvent(EventViewAbstract.BACK_TO_VIEW_MAIN_SCREEN, VIEW_MAIN_MENU);
			this._navigator.addScreen(VIEW_OPEN, openItem);
									
			
			
			var addItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewAddItem);				
				addItem.setScreenIDForPushEvent(EventViewAbstract.BACK, VIEW_PACKED_LIST);				
			this._navigator.addScreen(VIEW_ADD_ITEM, addItem);
			
			
			
			var addCategory:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewAddCategory);				
				addCategory.setScreenIDForPushEvent(EventViewAbstract.BACK, VIEW_PACKED_LIST);				
			this._navigator.addScreen(VIEW_ADD_CATEGORY, addCategory);
			
			var pack:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewPack);				
				pack.setScreenIDForPushEvent(EventViewAbstract.BACK, VIEW_MAIN_MENU);				
			this._navigator.addScreen(VIEW_PACK, pack);
			
			
			_navigator.addEventListener(FeathersEventType.TRANSITION_START, _handlerTransition);
			_navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, _handlerTransition);
			
			
			if(_settings.welcome == "1"){
				var viewStart:StackScreenNavigatorItem = new StackScreenNavigatorItem(ViewWelcome);																	
					viewStart.setScreenIDForPushEvent(EventMain.SHOW_VIEW_MAIN, VIEW_MAIN_MENU);						
			
				this._navigator.addScreen(VIEW_WELCOME, viewStart);				
				this._navigator.pushScreen(VIEW_WELCOME);
				this._navigator.rootScreenID = VIEW_WELCOME;		
			} else {
				this._navigator.rootScreenID = VIEW_MAIN_MENU;	
			}
						
			this._navigator.pushTransition = Fade.createFadeInTransition();
			this._navigator.popTransition = Fade.createFadeInTransition();	
			
			
			//	this._navigator.rootScreenID = VIEW_PACKED_LIST;
			
			_screenLoader = new ScreenLoader();
			addChild(_screenLoader);	
			_screenLoader.touchable = false;
			_screenLoader.isEnabled = false;
			_screenLoader.visible = false;						
		}
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
			_theme.removeEventListener(Event.COMPLETE, _handlerThemeCreated);		
			_theme.removeEventListener(Event.CHANGE, _handlerChange);			
			
			_starlingContext.dispatchEvent(new EventMain(EventMain.INITIALIZE_DATABASE));			
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