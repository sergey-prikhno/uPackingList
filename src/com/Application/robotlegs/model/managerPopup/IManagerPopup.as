package com.Application.robotlegs.model.managerPopup {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	
	public interface IManagerPopup {			
		function popupCreateListScratch():void	
		function popupCreateListExisting():void
		function popupRemoveItem(value:VOPackedItem):void
	}
}