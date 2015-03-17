package com.Application.robotlegs.model.managerPopup {
	import com.Application.robotlegs.views.popups.listExisting.EventPopupCreateListExisting;
	import com.Application.robotlegs.views.popups.listExisting.PopupCreateListExisting;
	import com.Application.robotlegs.views.popups.listScratch.EventPopupCreateListScratch;
	import com.Application.robotlegs.views.popups.listScratch.PopupCreateListScratch;
	
	import flash.display.Stage;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.core.PopUpManager;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	import starling.core.Starling;
	
	public class ManagerPopup extends Actor implements IManagerPopup {		
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
		
		private var _nativeStage:Stage;
		private var _resourceManager:LocaleManager;
		
		private var _popupCreateListScratch:PopupCreateListScratch;
		private var _popupCreateListExisting:PopupCreateListExisting;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ManagerPopup() {
			super();
			_nativeStage = Starling.current.nativeStage;
			
			_resourceManager = LocaleManager.getInstance();

		}				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function test():void {
			
		}
		
		public function popupCreateListScratch():void{
			if(!_popupCreateListScratch){
				_popupCreateListScratch = new PopupCreateListScratch();
				_popupCreateListScratch.addEventListener(EventPopupCreateListScratch.CLOSE_POPUP_CREATE, _handlerClosePopupCreateList);
				_popupCreateListScratch.addEventListener(EventPopupCreateListScratch.POPUP_CREATE_SET_NAME, _handlerPopupCreateSetName);
			}
			_popupCreateListScratch.width = _nativeStage.fullScreenWidth;
			_popupCreateListScratch.height = _nativeStage.fullScreenHeight;
			PopUpManager.addPopUp(_popupCreateListScratch,true);
		}
		
		public function popupCreateListExisting():void{
			if(!_popupCreateListExisting){
				_popupCreateListExisting = new PopupCreateListExisting();
				_popupCreateListExisting.addEventListener(EventPopupCreateListExisting.CLOSE_POPUP_CREATE, _handlerClosePopupCreateListExisting);
				_popupCreateListExisting.addEventListener(EventPopupCreateListExisting.POPUP_CREATE_SET_NAME, _handlerPopupCreateSetNameExisting);
				_popupCreateListExisting.addEventListener(EventPopupCreateListExisting.POPUP_CREATE_USE_EXISTING, _handlerPopupCreateUseExisting);
			}
			_popupCreateListExisting.width = _nativeStage.fullScreenWidth;
			_popupCreateListExisting.height = _nativeStage.fullScreenHeight;
			PopUpManager.addPopUp(_popupCreateListExisting,true);
		}
		
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
		
		private function _removePopupCreateListScratch():void{
			if(_popupCreateListScratch){
				_popupCreateListScratch.removeEventListener(EventPopupCreateListScratch.CLOSE_POPUP_CREATE, _handlerClosePopupCreateList);
				_popupCreateListScratch.removeEventListener(EventPopupCreateListScratch.POPUP_CREATE_SET_NAME, _handlerPopupCreateSetName);
				_popupCreateListScratch.destroy();
				PopUpManager.removePopUp(_popupCreateListScratch, true);
				_popupCreateListScratch = null;
			}
		}
		
		public function _removePopupCreateListExisting():void{
			if(_popupCreateListExisting){
				_popupCreateListExisting.removeEventListener(EventPopupCreateListExisting.CLOSE_POPUP_CREATE, _handlerClosePopupCreateListExisting);
				_popupCreateListExisting.removeEventListener(EventPopupCreateListExisting.POPUP_CREATE_SET_NAME, _handlerPopupCreateSetNameExisting);
				_popupCreateListExisting.removeEventListener(EventPopupCreateListExisting.POPUP_CREATE_USE_EXISTING, _handlerPopupCreateUseExisting);
				_popupCreateListExisting.destroy();
				PopUpManager.removePopUp(_popupCreateListExisting,true);
				_popupCreateListExisting = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerClosePopupCreateList(event:EventPopupCreateListScratch):void{
			_removePopupCreateListScratch();
		}
		
		private function _handlerPopupCreateSetName(event:EventPopupCreateListScratch):void{
			_removePopupCreateListScratch();
		}
		
		private function _handlerClosePopupCreateListExisting(event:EventPopupCreateListExisting):void{
			_removePopupCreateListExisting();
		}
		
		private function _handlerPopupCreateSetNameExisting(event:EventPopupCreateListExisting):void{
			_removePopupCreateListExisting();
			popupCreateListScratch();
		}
		
		private function _handlerPopupCreateUseExisting(event:EventPopupCreateListExisting):void{
			_removePopupCreateListExisting();
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