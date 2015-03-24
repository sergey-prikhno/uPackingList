package com.Application.robotlegs.views.packedList.listPacked {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.packedList.EventViewPackedList;
	
	import feathers.controls.List;
	import feathers.controls.Scroller;
	import feathers.controls.supportClasses.ListDataViewPort;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.IDropTarget;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	public class ListPacked extends List implements IDropTarget{		
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
		private var _isEditing:Boolean = false;		
		private var _isDragable:Boolean = true;
		public static const DRAG_FORMAT:String = "itemDrag";
				
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ListPacked() {
			super();			
			this.addEventListener(DragDropPackedListEvent.DRAG_ENTER, dragEnterHandler);
			this.addEventListener(DragDropPackedListEvent.DRAG_EXIT, dragExitHandler);
			this.addEventListener(DragDropPackedListEvent.DRAG_DROP, dragDropHandler);				
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function dispose():void{
			this.removeEventListener(DragDropPackedListEvent.DRAG_ENTER, dragEnterHandler);
			this.removeEventListener(DragDropPackedListEvent.DRAG_EXIT, dragExitHandler);
			this.removeEventListener(DragDropPackedListEvent.DRAG_DROP, dragDropHandler);			
			
			super.dispose();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get viewPordData():ListDataViewPort{
			return dataViewPort;			
		}
		
		public function get isEditing():Boolean { return _isEditing;}
		public function set isEditing(value:Boolean):void{
			_isEditing = value;
			
			dispatchEvent(new EventViewPackedList(EventViewPackedList.UPDATE_STATE));
		}		
		
		public function get isDragable():Boolean { return _isDragable;}
		public function set isDragable(value:Boolean):void{
			_isDragable = value;
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
		private function dragEnterHandler(event:DragDropPackedListEvent, dragData:DragData):void {
													
			if(!dragData.hasDataForFormat(DRAG_FORMAT)) {
				return;
			}
								
			DragDropListPackedManager.limitYTopPos = y-((width/8)/2);
			DragDropListPackedManager.limitYBottomPos = y+height-((width/8)/2);
			
			if(this.alpha != .5){				
				completeAnimation();
				
				var pTween:Tween = new Tween(this,.2,Transitions.EASE_OUT);
				pTween.animate("alpha",.5);
				pTween.onComplete = completeAnimation;
				
				Starling.juggler.add(pTween);							
			}
			
			DragDropListPackedManager.acceptDrag(this);						
		}
		
		
		private function dragExitHandler(event:DragDropPackedListEvent, dragData:DragData):void {								
			
			if(this.alpha != 1){
				completeAnimation();
				
				var pTween:Tween = new Tween(this,.2,Transitions.EASE_OUT);
				pTween.animate("alpha",1);
				pTween.onComplete = completeAnimation;								
				Starling.juggler.add(pTween);							
			}
		//	this.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
		}
		
		private function dragDropHandler(event:DragDropPackedListEvent, dragData:DragData):void {
		
			
				var droppedObject:ItemRendererPackedList = ItemRendererPackedList(dragData.getDataForFormat(DRAG_FORMAT))
				droppedObject.x = Math.min(Math.max(event.localX - droppedObject.width / 2,
					0), this.actualWidth - droppedObject.width); //keep within the bounds of the target
				droppedObject.y = Math.min(Math.max(event.localY - droppedObject.height / 2,
					0), this.actualHeight - droppedObject.height); //keep within the bounds of the target
				
				
				var pIndex:int = 0;
								
				if(droppedObject.y < droppedObject.height) {
					pIndex = 0;
				} else {
					pIndex = Math.floor(droppedObject.y/droppedObject.height + verticalScrollPosition/droppedObject.height);
				}
							
				var pItemDroppedData:VOPackedItem = VOPackedItem(droppedObject.data);
					
			
				
				//UPDATE_ORDER_INDEXES
											
				var pUnderItemData:VOPackedItem;
				var pVectorItems:Vector.<VOPackedItem> = new Vector.<VOPackedItem>();				
				
				
				if(!pItemDroppedData.isChild){
					
					//for Parent
					try{								
						pUnderItemData = VOPackedItem(dataProvider.getItemAt(pIndex));							
						
						if(!pUnderItemData.isChild){
							pItemDroppedData.orderIndex = pUnderItemData.orderIndex;				
							pVectorItems.push(pItemDroppedData);
						}
						
					} catch(error:Error) { }
										
					
					if(pUnderItemData && !pUnderItemData.isChild) {													
						var pL:Number = pIndex;					
														
						for(var i:int=pL;i<dataProvider.length;i++){				
							var pGetItem:VOPackedItem = VOPackedItem(dataProvider.getItemAt(i));	
								pGetItem.orderIndex++;
							
							pVectorItems.push(pGetItem);							
						}						
					} else if(pUnderItemData && pUnderItemData.isChild) {
						pIndex = droppedObject.backIndex;
					}
					
				} else {
					//for Children
					
					try{						
						pUnderItemData = VOPackedItem(dataProvider.getItemAt(pIndex));													
					}catch(error:Error){}
					
					
					if(pUnderItemData && pUnderItemData.isChild && pItemDroppedData.parentId == pUnderItemData.parentId){
						pItemDroppedData.orderIndex = pUnderItemData.orderIndex;				
						pVectorItems.push(pItemDroppedData);						
						
						trace("------------------------");
						trace("title "+pItemDroppedData.label);
						trace("orderIndex "+pItemDroppedData.orderIndex);
						
						var pLChild:Number = pIndex;					
						
						for(var l:int=pLChild;l<dataProvider.length;l++){				
							var pGetItemChild:VOPackedItem = VOPackedItem(dataProvider.getItemAt(l));	
						
							if(pGetItemChild.isChild && pGetItemChild.parentId == pItemDroppedData.parentId){
								pGetItemChild.orderIndex++;							
								pVectorItems.push(pGetItemChild);
								
						/*		trace("------------------------");
								trace("title "+pGetItemChild.label);
								trace("orderIndex "+pGetItemChild.orderIndex);
							*/	
							} else {
								break;
							}													
						}		
					} else {
											
						pIndex = droppedObject.backIndex;
					}									
				}
							
				
				
				
				dataProvider.addItemAt(pItemDroppedData,pIndex);						
						
				droppedObject.dispose();
				droppedObject = null;			
			
				if(pVectorItems && pVectorItems.length){
					dispatchEvent(new EventViewAbstract(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, true, pVectorItems));
				}
							
				
			//anim List	
			if(this.alpha != 1){
				completeAnimation();
				var pTween:Tween = new Tween(this,.2,Transitions.EASE_OUT);
				pTween.animate("alpha",1);
				pTween.onComplete = completeAnimation;
				
				Starling.juggler.add(pTween);							
			}
			
			this.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
		}						
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		private function completeAnimation():void{
			Starling.juggler.removeTweens(this);
			
		}		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}