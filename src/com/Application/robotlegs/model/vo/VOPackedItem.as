package com.Application.robotlegs.model.vo {
	

	public class VOPackedItem {		
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
		private var _id:Number = 0;
		private var _parentId:Number = 0;
		private var _isChild:Boolean = false;
		private var _label:String = "";
		private var _childrens:Vector.<VOPackedItem> = new Vector.<VOPackedItem>;
		private var _index:Number = 0;
		private var _isOpen:Boolean = false;
		private var _isPacked:Boolean = false;
		private var _packedCount:Number = 0;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function VOPackedItem(pLabel:String="",pId:Number = 0,pParentId:Number = 0,pIsChild:Boolean = false) {
			_id = pId;
			_parentId = pParentId;
			_isChild = pIsChild;
			_label = pLabel;
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
		public function get id():Number { return _id;}
		public function set id(value:Number):void{
			_id = value;
		}
		
		public function get parentId():Number { return _parentId;}
		public function set parentId(value:Number):void{
			_parentId = value;
		}
		
		public function get isChild():Boolean { return _isChild;}
		public function set isChild(value:*):void{
			
			if(value is String){
				if(value == "false"){					
					_isChild = false;
				} else {
					_isChild = true;
				}
			}else {
				_isChild = value;
			}
				
			
			
		}
		
		public function get label():String { return _label;}
		public function set label(value:String):void{
			_label = value;
		}
		
		public function get childrens():Vector.<VOPackedItem> { return _childrens;}
		public function set childrens(value:Vector.<VOPackedItem>):void{
			_childrens = value;
		}
		
		public function get index():Number { return _index;}
		public function set index(value:Number):void{
			_index = value;
		}
		
		public function get isOpen():Boolean { return _isOpen;}
		public function set isOpen(value:Boolean):void{
			_isOpen = value;
		}
						
		public function get isPacked():Boolean { return _isPacked;}
		public function set isPacked(value:*):void{
			
			if(value is String){
				if(value == "false"){					
					_isPacked = false;
				} else {
					_isPacked = true;
				}
			}else {
				_isPacked = value;
			}			
		}		
		
		public function get packedCount():Number{
			var pCountPacked:Number = 0;
			
			if(_childrens){
				for(var i:int=0;i<_childrens.length;i++){
					var pItem:VOPackedItem = VOPackedItem(_childrens[i]);
					
					if(pItem.isPacked){
						pCountPacked++;
					}
					
				}
				
			}
			
			return pCountPacked;
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