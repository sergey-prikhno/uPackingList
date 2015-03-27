package com.Application.robotlegs.views.packedList.listPacked {	
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.packedList.EventViewPackedList;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Scroller;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.IFocusDisplayObject;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.IDragSource;
	import feathers.events.FeathersEventType;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	import starling.utils.deg2rad;
	
	public class ItemRendererPackedList extends FeathersControl implements IListItemRenderer, IFocusDisplayObject,IDragSource {						
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
		protected var _data:VOPackedItem;
		protected var _owner:ListPacked;
		protected var _index:int = -1;
		protected var _backIndex:int = -1;
		protected var _isSelected:Boolean = false;	
		
		
		protected var _isLongPressEnabled:Boolean = true;
		protected var touchPointID:int = -1;
		protected var _hasLongPressed:Boolean = false;
		protected var _touchBeginTime:int;
		protected var _longPressDuration:Number = 0.5;
		
		private static const HELPER_POINT:Point = new Point();
		private static const SELECTED_COLOR:uint = 0xFFFFFF;
		
		private var _padding:int = 0;													
		
		private var _containerMain:Sprite;
		
				
		private var _iconArrowTexture:Texture;
		private var _iconEditTexture:Texture;
		private var _iconBagTexture:Texture;
		private var _iconMarkTexture:Texture;
		private var _iconRemoveTexture:Texture;
		
		
		
		private var _iconArrow:Image;
		private var _iconEdit:Image;
		private var _iconBag:Image;
		private var _iconMark:Image;
		private var _iconRemove:Image;
		
		
		private var _background:Quad;
		private var _backgroundChild:Quad;
		
		private var _label:Label;
		private var _scaleWidth:Number;
		private var _labelCount:Label;
		
		private static const _COLOR_BACKGROUND:uint = 0x3b4559;
		private static const _COLOR_BACKGROUND_CHILD:uint = 0x6085b6;
		
		private var _isEditTouch:Boolean = false;
		
		
		private var _atlas:TextureAtlas;
		
		private var _mainIcon:Image;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ItemRendererPackedList() {
			super();			
			this.isFocusEnabled = true;
			this.isQuickHitAreaEnabled = false;
			this.addEventListener(TouchEvent.TOUCH, button_touchHandler);	
			this.addEventListener(Event.REMOVED_FROM_STAGE, button_removedFromStageHandler);
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
			return ItemRendererPackedList.globalStyleProvider;
		}
		
		public function set scaleWidth(value:Number):void{
			_scaleWidth = value;
		}
		
		public function set iconArrow(value:Texture):void{
			_iconArrowTexture = value;
		}
		
		public function set iconEdit(value:Texture):void{
			_iconEditTexture = value;
		}
		
		public function set iconBag(value:Texture):void{
			_iconBagTexture = value;
		}
		
		public function set iconMark(value:Texture):void{
			_iconMarkTexture = value;
		}
		
		public function set iconRemove(value:Texture):void{
			_iconRemoveTexture = value;
		}
		
		public function set atlas(value:TextureAtlas):void{
			_atlas = value;
		}
		
		
		public function get data():Object {
			return this._data;
		}
		
		public function set data(value:Object):void	{
			
			if(!value)	{
				return;
			}
						
			_data = VOPackedItem(value);			
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get index():int {
			return this._index;
		}
		
		public function set index(value:int):void {
			this._index = value;
		}
				
		public function get backIndex():int{ return _backIndex;}
		public function set backIndex(value:int):void{
			_backIndex = value;
		}
		
		public function get owner():List {
			return List(this._owner);
		}
		
		public function set owner(value:List):void {
			if(_owner == value)	{
				return;
			}
			
			_owner = ListPacked(value);	
			if(_owner){
				_owner.addEventListener(EventViewPackedList.UPDATE_PACKED_ITEM, _handlerUpdatePacked);
				_owner.addEventListener(EventViewPackedList.UPDATE_STATE, _handlerUpdateState);
				_updateState();
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get isSelected():Boolean {
			return this._isSelected;
		}
		
		
		public function set isSelected(value:Boolean):void {
			if(this._isSelected == value) {
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}		
		
		
		override public function dispose():void	{
			if(_owner){
				this._owner.removeEventListener(EventViewPackedList.UPDATE_PACKED_ITEM, _handlerUpdatePacked);
				this._owner.removeEventListener(EventViewPackedList.UPDATE_STATE, _handlerUpdateState);
			}
			this._owner = null;
			
			
			if(_background){
				_containerMain.removeChild(_background);
				_background = null;
			}
			
			if(_backgroundChild){
				_containerMain.removeChild(_backgroundChild);
				_backgroundChild = null;
			}								
			
			if(_iconArrow){
				_containerMain.removeChild(_iconArrow);
				_iconArrow = null;
			}
					
			
			if(_iconEdit){
				_iconEdit.removeEventListener(TouchEvent.TOUCH, _handlerTouch);
				_containerMain.removeChild(_iconEdit);
				_iconEdit = null;
			}
			
			if(_iconBag){
				_containerMain.removeChild(_iconBag);
				_iconBag = null;
			}
			
			if(_iconMark){
				_containerMain.removeChild(_iconMark);
				_iconMark = null;
			}
			
			
			if(_label){
				_containerMain.removeChild(_label);
				_label = null;
			}
			
			if(_labelCount){
				_containerMain.removeChild(_labelCount);
				_labelCount = null;
			}
			
			
			if(_iconRemove){
				_iconRemove.removeEventListener(TouchEvent.TOUCH, _handlerRemove); 
				_containerMain.removeChild(_iconRemove);
				_iconRemove = null;
			}			
			
			if(_mainIcon){				
				_containerMain.removeChild(_mainIcon);
				_mainIcon = null;
			}		
			
						
			if(_containerMain){
				removeChild(_containerMain);
				_containerMain = null;
			}			
			
			
			trace(" dispose");
			
			_iconRemoveTexture = null;
			_iconBagTexture = null;
			_iconMarkTexture = null;
			_iconArrowTexture = null;
			_iconEditTexture = null;
			
			super.dispose();
		}		
		
		override public function invalidate(flag:String = INVALIDATION_FLAG_ALL):void{
			super.invalidate(flag);			
			
			if(flag == INVALIDATION_FLAG_DATA){
				
				if(_data){
					if(!_containerMain){
						_createImage();
					} else {
						_refreshImage();
					}
					
				}				
			}				
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function draw():void {					
			
			if(_owner){
				_padding = int(_owner.width *0.05);
				width = _owner.width;
				height = width/8;					
			}
			
			if(_background){
				_background.width = width;
				_background.height = height;							
			}
			
			if(_backgroundChild){
				_backgroundChild.width = width;
				_backgroundChild.height = height;							
			}
											
			
			if(_iconRemove){
				_iconRemove.scaleX = _iconRemove.scaleY = _scaleWidth;																
				_iconRemove.y = int(height/2);
				
				if(_data.isChild) {
					_iconRemove.x = int(70*_scaleWidth);					
				} else {					
					_iconRemove.x = int(40*_scaleWidth);
				}
				
			}
			
			
			if(_mainIcon){
				_mainIcon.scaleX = _mainIcon.scaleY = _scaleWidth;	
				
				if(_data.isChild){
					_mainIcon.x = int(30*_scaleWidth);
				} else {
					_mainIcon.x = int(10*_scaleWidth);
				}
				
				_mainIcon.y = int(height/2 - _mainIcon.height/2);
				
				if(_iconRemove.visible){
					_mainIcon.x =  int(_iconRemove.x + _iconRemove.width*1.2);		
				}
			}
			
			if(_label && _data){
					
				_label.x = int(_mainIcon.x + _mainIcon.width * 1.2);					
					
				if(_data.isChild) {					
					_label.y = int(height/2 - _label.height/2);
				} else {
					_label.y = int(height/2 - _label.height);					
				}																	
			}
			
			
			
			if(_labelCount){				
				_labelCount.x = _label.x;				
				_labelCount.y = int(height/1.6);				
			}
			
			if(_iconArrow){
				_iconArrow.scaleX = _iconArrow.scaleY = _scaleWidth;								
				_iconArrow.x = int(width - _iconArrow.width - 40*_scaleWidth);
				_iconArrow.y = int(height/2);				
			}			
			

			if(_iconBag){
				_iconBag.scaleX = _iconBag.scaleY = _scaleWidth;
				_iconBag.x = int(width - _iconBag.width - 10*_scaleWidth);
				_iconBag.y = int(height/2);
			}
			
			if(_iconMark){
				_iconMark.scaleX = _iconMark.scaleY = _scaleWidth;
				_iconMark.x = _iconBag.x + _iconMark.width/4;
				_iconMark.y = _iconBag.y-_iconMark.height/6;
			}
			
			
			if(_iconEdit){
				_iconEdit.scaleX = _iconEdit.scaleY = _scaleWidth;
				_iconEdit.x = int(_iconBag.x - _iconEdit.width*2.5);
				_iconEdit.y = int(height/2);
			}
														
		}
		
		override protected function initialize():void{			
			_createImage();					
		}
		
		
		private function _createImage():void{
			if(_data){
				
				if(!_containerMain){
																
					_containerMain = new Sprite();										
					addChild(_containerMain);	
					
					
					_background = new Quad(10,10,_COLOR_BACKGROUND);
					_containerMain.addChild(_background);
					
					_backgroundChild = new Quad(10,10,_COLOR_BACKGROUND_CHILD);
					_containerMain.addChild(_backgroundChild);								
					
					_iconArrow = new Image(_iconArrowTexture);
					_iconArrow.smoothing = TextureSmoothing.TRILINEAR;
					_iconArrow.pivotX = _iconArrow.pivotY = _iconArrow.width/2; 
					_containerMain.addChild(_iconArrow);
					
					
					_iconEdit = new Image(_iconEditTexture);					
					_iconEdit.smoothing = TextureSmoothing.TRILINEAR;
					_iconEdit.pivotX = _iconEdit.pivotY = _iconEdit.width/2; 
					_containerMain.addChild(_iconEdit); 	
					_iconEdit.addEventListener(TouchEvent.TOUCH, _handlerTouch);
					_iconEdit.visible = false;
					
					_iconBag = new Image(_iconBagTexture);
					_iconBag.smoothing = TextureSmoothing.TRILINEAR;
					_iconBag.pivotX = _iconBag.pivotY = _iconBag.width/2; 
					_containerMain.addChild(_iconBag);										
					
					
					_iconMark = new Image(_iconMarkTexture);
					_iconMark.smoothing = TextureSmoothing.TRILINEAR;
					_iconMark.pivotX = _iconMark.pivotY = _iconMark.width/2; 
					_containerMain.addChild(_iconMark);
									
					
					_iconRemove = new Image(_iconRemoveTexture);																				
					_iconRemove.visible = false;	
					
					_iconRemove.smoothing = TextureSmoothing.TRILINEAR;
					_iconRemove.pivotX = _iconRemove.pivotY = _iconRemove.width/2; 
					_containerMain.addChild(_iconRemove);
					_iconRemove.addEventListener(TouchEvent.TOUCH, _handlerRemove); 
										 
										
					_label = new Label();
					_containerMain.addChild(_label);					
					
					_labelCount = new Label();
					_containerMain.addChild(_labelCount);
					
					_refreshImage();
																						
					trace("created");								
				}
			}
		}

		
		private function _refreshImage():void{
			
			if(_data && _containerMain){	
				trace("refresh");
				
				if(_data.isChild){
					_backgroundChild.visible = true;
				//	_iconEdit.visible = true;
					_iconBag.visible = true;
					
					if(_data.isPacked){
						_iconMark.visible = true;
					} else {
						_iconMark.visible = false;
					}
					
					
					_background.visible = false;					
					_iconArrow.visible = false;
					_labelCount.visible = false;
					
				} else {
					_backgroundChild.visible = false;
				//	_iconEdit.visible = false;
					_iconMark.visible = false;
					_iconBag.visible = false;
					_background.visible = true;
					_iconArrow.visible = true;
					_labelCount.visible = true;
				}
				
																	
				if(!_mainIcon){
					_mainIcon = new Image(_atlas.getTexture("icon_"+_data.icon_id));
					_containerMain.addChild(_mainIcon);
				} else {
					_mainIcon.texture = _atlas.getTexture("icon_"+_data.icon_id);
				}														
				
				
				_label.text = _data.label;
				_label.validate();
				
				
				if(_data.childrens){
					_labelCount.text = _data.packedCount+" / "+_data.childrens.length;	
				} else {
					_labelCount.text = "0 / 0";
				}				
				
				_labelCount.validate();
				//_image.label = _data.label;
			}			
		}
		
		
		
		
		
		protected function resetTouchState(touch:Touch = null):void {
			this.touchPointID = -1;
			this.removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);		
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------			
		private function completeAnimation():void{
		//	Starling.juggler.removeTweens(this);
		//	_owner.dataProvider.removeItem(_data);
		}														
		
		protected function button_touchHandler(event:TouchEvent):void
		{
			if(!this._isEnabled)
			{
				this.touchPointID = -1;
				return;
			}
			
			if(this.touchPointID >= 0)
			{
				var touch:Touch = event.getTouch(this, null, this.touchPointID);
				if(!touch)
				{
					//this should never happen
					return;
				}
				
				touch.getLocation(this.stage, HELPER_POINT);
				
				const isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
				
				if(touch.phase == TouchPhase.ENDED)
				{
					this.resetTouchState(touch);
					//we we dispatched a long press, then triggered and change
					//won't be able to happen until the next touch begins
					if(!this._hasLongPressed && isInBounds) {
						//this.dispatchEventWith(Event.TRIGGERED,true,_data);													
						
						if(_data.isChild){
							if(!_iconRemove.visible){
								if(_isEditTouch){
									_isEditTouch = false;
								} else {
									_data.isPacked = !_data.isPacked;
									
									if(_data.isChild){								
										if(_data.isPacked){
											_iconMark.visible = true;
										} else {
											_iconMark.visible = false;
										}
									}
										
									dispatchEvent(new EventViewAbstract(EventViewAbstract.UPDATE_DB_PACKED_ITEM, true, _data));
									
								//	_owner.dispatchEvent(new EventViewPackedList(EventViewPackedList.UPDATE_PACKED_ITEM, false, _data)); 								
								}
							}
							
						} else if(_data.childrens && _data.childrens.length > 0){
							
							if(!_isEditTouch){
								
								
								_data.index = _index;
															
								this.dispatchEventWith(EventViewPackedList.CLICK_ITEM,true,_data);
								
															
								if(!_data.isOpen){					
									_data.isOpen = true;								
									_iconArrow.rotation = deg2rad(90);							
								} else {					
									_data.isOpen = false;								
									_iconArrow.rotation = deg2rad(0);															
								}	
								
								
							} else {
								_isEditTouch = false;
							}
						}
												
																								
					/*	var pTween:Tween = new Tween(this,.4,Transitions.EASE_OUT);
							pTween.moveTo(-width,this.y);
							pTween.onComplete = completeAnimation;
						
						Starling.juggler.add(pTween);	
						*/	
						
						isSelected = true;
					}
				}
				return;
			}
			else //if we get here, we don't have a saved touch ID yet
			{
				touch = event.getTouch(this, TouchPhase.BEGAN);
				if(touch) {
					_dragTouch = touch;
					this.touchPointID = touch.id;
					
					if(this._isLongPressEnabled) {
						this._touchBeginTime = getTimer();
						this._hasLongPressed = false;
						this.addEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
					}
					
					return;
				}				
				
			}
		} 
		
		private var _dragTouch:Touch;
		
		protected function longPress_enterFrameHandler(event:Event):void {
			var accumulatedTime:Number = (getTimer() - this._touchBeginTime) / 1000;
			if(accumulatedTime >= this._longPressDuration)
			{
				this.removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
				this._hasLongPressed = true;
				this.dispatchEventWith(FeathersEventType.LONG_PRESS);
				
				// logic for start drag
				_dragTouch.getLocation(this.stage, HELPER_POINT);
				
				const isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
				if(isInBounds){
					
					if(!DragDropListPackedManager.isDragging && _owner.isDragable){
						
						if(_data.isOpen && !_data.isChild){
							this.dispatchEventWith(EventViewPackedList.CLICK_ITEM,true,_data);
							_data.isOpen = false;								
							_iconArrow.rotation = deg2rad(0);	
						}										
														
						_owner.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
						
						var pItemRend:ItemRendererPackedList = new ItemRendererPackedList();
						pItemRend.scaleWidth = _scaleWidth;
						pItemRend.iconArrow = _iconArrowTexture;
						pItemRend.iconEdit = _iconEditTexture;
						pItemRend.iconBag = _iconBagTexture;
						pItemRend.iconMark = _iconMarkTexture;
						pItemRend.iconRemove = _iconRemoveTexture;
						pItemRend.atlas = _atlas;			
						pItemRend.width = width;
						pItemRend.height = height;
						pItemRend.x = x;
						pItemRend.y = y;						
						pItemRend.data = _data;
						pItemRend.backIndex = index;
						
						var dragData:DragData = new DragData();
						dragData.setDataForFormat(ListPacked.DRAG_FORMAT,pItemRend);															
						DragDropListPackedManager.startDrag(pItemRend , _dragTouch, dragData, pItemRend, -pItemRend.width/ 2, -pItemRend.height/2);
						
						pItemRend.validate();						
						_owner.dataProvider.removeItem(_data);						
					}
				}
			}
		}
		
		
		protected function button_removedFromStageHandler(event:Event):void	{
			this.resetTouchState();
		}
		
		private function _handlerTouch(event:TouchEvent):void{
			
			if(!this._isEnabled) {			
				return;
			}
						
			var touch:Touch = event.getTouch(_iconEdit);				
				
			if(touch){
				if(touch.phase == TouchPhase.ENDED) {
					_isEditTouch = true;
					trace("Edit");
				}
			}
			
		}
		
		
		private function _handlerUpdatePacked(event:EventViewPackedList):void{
			
			var pData:VOPackedItem = VOPackedItem(event.data);
			
			if(pData.parentId == _data.id){
				if(_data.childrens){
					_labelCount.text = _data.packedCount+" / "+_data.childrens.length;	
				} else {
					_labelCount.text = "0 / 0";
				}	
			}			
		}
		
		private function _handlerRemove(event:TouchEvent):void{
			if(!this._isEnabled) {			
				return;
			}
			
			var touch:Touch = event.getTouch(_iconRemove);				
			
			if(touch){
				if(touch.phase == TouchPhase.ENDED) {
					_isEditTouch = true;
					dispatchEvent(new EventViewAbstract(EventViewAbstract.REMOVE_PACKED_ITEM, true, _data));
					trace("Delete");
				}
			}
		}
		
		
		private function _handlerUpdateState(event:EventViewPackedList):void{
			_updateState();					
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 										
		private function  _updateState():void{
			if(_iconRemove){
				_iconRemove.visible = _owner.isEditing;
				draw();
			}
			
			if(_iconArrow){
				if(_data.isOpen){																	
					_iconArrow.rotation = deg2rad(90);							
				} else {														
					_iconArrow.rotation = deg2rad(0);															
				}	
			}
		}
							
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}


