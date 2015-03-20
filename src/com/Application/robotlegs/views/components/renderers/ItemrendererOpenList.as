package com.Application.robotlegs.views.components.renderers{
	import com.Application.robotlegs.model.vo.VOTableName;
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class ItemrendererOpenList extends FeathersControl implements IListItemRenderer{
		
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
		
		private var _isTouch:Boolean = false;
		protected var touchPointID:int = -1;
		private var _index:int = -1;
		protected var _owner:List;
		private var _isSelected:Boolean;
		private var _data:VOTableName;
		private var _scale:Number;
		
		private var _labelTitle:Label;
		
		private var _quadBg:Quad;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ItemrendererOpenList(){
			this.addEventListener(TouchEvent.TOUCH, _touchHandler);
			this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function dispose():void{
			_data = null;
			this.removeEventListener(TouchEvent.TOUCH, _touchHandler);
			this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			if(_labelTitle){
				removeChild(_labelTitle, true);
				_labelTitle = null;
			}
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ItemrendererOpenList.globalStyleProvider;
		}
		
		public function set scale(value:Number):void{_scale = value;}
		public function get index():int	{return this._index;}
		public function set index(value:int):void{
			if(this._index == value){
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get owner():List{return List(this._owner);}
		public function set owner(value:List):void{
			if(this._owner == value){
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get data():Object{return this._data;}
		public function set data(value:Object):void{			
			if(value){
				this._data = null;
				
				this.touchPointID = -1;
				this._data = VOTableName(value);				
				this.invalidate(INVALIDATION_FLAG_DATA);
			}
		}
		public function get isSelected():Boolean{return this._isSelected;}
		public function set isSelected(value:Boolean):void{
			if(this._isSelected == value){
				return;
			}
			this._isSelected = value;
			this.dispatchEventWith(Event.CHANGE);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function initialize():void{
			if(!_quadBg){
				_quadBg = new Quad(10,10,0x666666);
				addChild(_quadBg);
			}
			if(!_labelTitle){
				_labelTitle = new Label();
				addChild(_labelTitle);
			}
			
		}
		
		override protected function draw():void{
			if(_data){
				width = _owner.width;
				
				if(_quadBg){
					_quadBg.width = actualWidth;
				}
				
				if(_labelTitle){	
					_labelTitle.width = _owner.width - int(8*_scale);
					_labelTitle.text = _data.title;
					_labelTitle.x = int(8*_scale);
					_labelTitle.y = int(24*_scale);
					_labelTitle.validate();
				}
				
				if(_quadBg){
					_quadBg.height = _labelTitle.y + _labelTitle.height+ int(24*_scale);
				}
				
				height = _quadBg.height;
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		protected function removedFromStageHandler(event:starling.events.Event):void{
			this.touchPointID = -1;
		}
		
		protected function _touchHandler(event:TouchEvent):void{
			var touch:Touch = event.getTouch(stage);
			if(touch){
				
				/*if(touch.phase == TouchPhase.BEGAN) {
				_isTouch = true;
				}else if(touch.phase == TouchPhase.ENDED) {
				if(_isTouch){
				dispatchEvent(new EventRenderer(EventRenderer.CLICK, _data, true));
				}
				}else if(touch.phase == TouchPhase.MOVED) {
				_isTouch = false;
				}*/
				if(touch.phase == TouchPhase.ENDED) {
					dispatchEvent(new EventRenderer(EventRenderer.CLICK, _data, true));
				}
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