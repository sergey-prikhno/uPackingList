package com.Application.robotlegs.views.main {
	import com.Application.EventMain;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	import feathers.skins.StandardIcons;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;

	[Event(name="complete",type="starling.events.Event")]
	[Event(name="showAlert",type="starling.events.Event")]
	
	public class ViewMain extends ViewAbstract {									
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------		
		public var savedVerticalScrollPosition:Number = 0;
		public var savedSelectedIndex:int = -1;
		
		private var _layout:VerticalLayout;
		
		public static const SHOW_ALERT:String = "SHOW_ALERT";
		public static const TEST_SERVICE:String = "TEST_SERVICE";
		
		public static var globalStyleProvider:IStyleProvider;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _list:List;
		private var _buttonSettings:Button;	
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewMain.globalStyleProvider;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function accessorySourceFunction(item:Object):Texture {
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		override protected function _initialize():void{
			super._initialize();
			
			_layout = new VerticalLayout();

			this._list = new List();
			this._list.hasElasticEdges = false;
			this._list.dataProvider = new ListCollection(
				[	{ label: _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.newList"), event: SHOW_ALERT },
					{ label: _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.openList"), event: SHOW_ALERT },
					{ label: _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.packList"), event: SHOW_ALERT }
				]);

			this._list.clipContent = true;
			this._list.autoHideBackground = true;
			this._list.verticalScrollPosition = this.savedVerticalScrollPosition;
			
			var isTablet:Boolean = DeviceCapabilities.isTablet(Starling.current.nativeStage);
			var itemRendererAccessorySourceFunction:Function = null;
			if(!isTablet){
				itemRendererAccessorySourceFunction = this.accessorySourceFunction;
			}
			this._list.itemRendererFactory = function():IListItemRenderer{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				
				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;
				
				renderer.labelField = "label";
				renderer.accessorySourceFunction = itemRendererAccessorySourceFunction;
				return renderer;
			};
			
			if(isTablet){
				this._list.addEventListener(Event.CHANGE, list_changeHandler);
				this._list.selectedIndex = -1;
				this._list.revealScrollBars();
			}else{
				this._list.selectedIndex = this.savedSelectedIndex;
				this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInCompleteHandler);
			}
			this.addChild(this._list);
			
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
			
			_layout.gap = int(88*_scaleHeight);
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.uPackingList");
				_header.width = _nativeStage.stageWidth;
			}
			if(_list){
				_list.width = _nativeStage.stageWidth;
				_list.y = _header.height + int(66*_scaleHeight);
				_list.layout = _layout;
				_list.validate();
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function list_changeHandler(event:Event):void {
			var eventType:String = this._list.selectedItem.event as String;
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this.dispatchEventWith(eventType);
				return;
			}
			
			//save the list's scroll position and selected index so that we
			//can restore some context when this screen when we return to it
			//again later.
			this.dispatchEventWith(eventType, false,
				{
					savedVerticalScrollPosition: this._list.verticalScrollPosition,
					savedSelectedIndex: this._list.selectedIndex
				});
								
			
			trace("this._list.selectedIndex "+this._list.selectedIndex);
		}
		
		private function transitionInCompleteHandler(event:Event):void 	{
			if(!DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this._list.selectedIndex = -1;
				this._list.addEventListener(Event.CHANGE, list_changeHandler);
			}
			this._list.revealScrollBars();
		}
		
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