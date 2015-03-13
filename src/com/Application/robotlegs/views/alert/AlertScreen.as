package com.Application.robotlegs.views.alert {
	import com.Application.robotlegs.views.ViewAbstract;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.events.Event;

	public class AlertScreen extends ViewAbstract {
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _showAlertButton:Button;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function AlertScreen() { 
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------				
		override protected function _initialize():void 	{			
			super._initialize();
			
			
			this.layout = new AnchorLayout();
			
			this._showAlertButton = new Button();
			this._showAlertButton.label = "Show Alert";
			this._showAlertButton.addEventListener(Event.TRIGGERED, showAlertButton_triggeredHandler);
			var buttonGroupLayoutData:AnchorLayoutData = new AnchorLayoutData();
			buttonGroupLayoutData.horizontalCenter = 0;
			buttonGroupLayoutData.verticalCenter = 0;
			this._showAlertButton.layoutData = buttonGroupLayoutData;
			this.addChild(this._showAlertButton);					
		}
		
		private function onBackButton():void {
			this.dispatchEventWith(Event.COMPLETE);
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------				
		private function alert_closeHandler(event:Event, data:Object):void 	{
			if(data) { 
				trace("alert closed with button:", data.label);				
				onBackButton();
			} else {
				trace("alert closed without button");
			}
		}
		
		private function showAlertButton_triggeredHandler(event:Event):void {
			var alert:Alert = Alert.show("I just wanted you to know that I have a very important message to share with you.", "Alert", new ListCollection(
				[
					{ label: "OK" },
					{ label: "Cancel" }
				]));
			alert.addEventListener(Event.CLOSE, alert_closeHandler);
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
