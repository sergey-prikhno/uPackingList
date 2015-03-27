package com.Application.themes {
	import com.Application.components.loadingIndicator.LoadingIndicator;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.addCategory.ViewAddCategory;
	import com.Application.robotlegs.views.addItem.ViewAddItem;
	import com.Application.robotlegs.views.components.bottomMenu.BottomMenu;
	import com.Application.robotlegs.views.components.renderers.ItemrendererMainMenu;
	import com.Application.robotlegs.views.components.renderers.ItemrendererOpenList;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.open.ViewOpen;
	import com.Application.robotlegs.views.packedList.ViewPackedList;
	import com.Application.robotlegs.views.packedList.listPacked.ItemRendererPackedList;
	import com.Application.robotlegs.views.popups.PopupAbstract;
	import com.Application.robotlegs.views.popups.listExisting.PopupCreateListExisting;
	import com.Application.robotlegs.views.popups.listScratch.PopupCreateListScratch;
	import com.Application.robotlegs.views.popups.removeItem.PopupRemoveItem;
	import com.Application.robotlegs.views.welcome.ViewWelcome;
	
	import flash.geom.Rectangle;
	
	import feathers.textures.Scale9Textures;
	import feathers.themes.MetalWorksMobileThemeWithAssetManager;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class ApplicationTheme extends MetalWorksMobileThemeWithAssetManager {
		
		
		
		protected var loadingIndicator:Texture;
		protected var baseViewBackground:Scale9Textures;
		protected var background1:Scale9Textures;
		protected var background2:Scale9Textures;
		protected var iconArrow:Texture;
		protected var iconEdit:Texture;
		protected var iconBag:Texture;
		protected var iconMark:Texture;
		protected var iconRemove:Texture;
				
		
		public function ApplicationTheme(assetsBasePath:String = null, assetManager:AssetManager = null) {
			super(assetsBasePath, assetManager);
		}
		
		
		override protected function initializeTextures():void{
			super.initializeTextures();
			
			this.loadingIndicator = this.atlas.getTexture("loading-white-indicator");
			this.baseViewBackground = new Scale9Textures(this.atlas.getTexture("background-base"),new Rectangle(10,10,20,20));			
			
			this.background1 = new Scale9Textures(this.atlas.getTexture("background1"),new Rectangle(10,10,20,20));	
			this.background2 = new Scale9Textures(this.atlas.getTexture("background2"),new Rectangle(10,10,20,20));	
			
			this.iconArrow = this.atlas.getTexture("arrow-right");
			this.iconEdit = this.atlas.getTexture("edit-icon");
			this.iconBag = this.atlas.getTexture("icon-bag");
			this.iconMark = this.atlas.getTexture("icon-mark");
			this.iconRemove = this.atlas.getTexture("icon-remove");
		}
		
		override protected function initializeStyleProviders():void {
			super.initializeStyleProviders();
	
			this.getStyleProviderForClass(ViewMain).defaultStyleFunction = this.setViewMainStyles;
			this.getStyleProviderForClass(ViewWelcome).defaultStyleFunction = this.setViewWelcomeStyles;
			this.getStyleProviderForClass(LoadingIndicator).defaultStyleFunction = this.setLoadingIndicatorStyles;
			this.getStyleProviderForClass(ViewPackedList).defaultStyleFunction = this.setViewPackedStyles;
			this.getStyleProviderForClass(ItemRendererPackedList).defaultStyleFunction = this.setItemRendererPackedStyles;
			this.getStyleProviderForClass(ItemrendererOpenList).defaultStyleFunction = this.setItemRendererOpenListStyles;
			
			this.getStyleProviderForClass(PopupAbstract).defaultStyleFunction = this.setPopupAbstractStyles;
			this.getStyleProviderForClass(PopupCreateListScratch).defaultStyleFunction = this.setPopupCreateListScratchStyles;
			this.getStyleProviderForClass(PopupCreateListExisting).defaultStyleFunction = this.setPopupCreateListExistingStyles;
			this.getStyleProviderForClass(ItemrendererMainMenu).defaultStyleFunction = this.setItemrendererMainMenuStyles;
			this.getStyleProviderForClass(BottomMenu).defaultStyleFunction = this.setBottomMenuStyles;
			this.getStyleProviderForClass(ViewOpen).defaultStyleFunction = this.setViewOpenStyles;		
			this.getStyleProviderForClass(PopupRemoveItem).defaultStyleFunction = this.setPopupRemoveItemStyles;
			this.getStyleProviderForClass(ViewAddCategory).defaultStyleFunction = this.setViewAddCategory;
			this.getStyleProviderForClass(ViewAddItem).defaultStyleFunction = this.setViewAddItem;
		}	
	
		protected function setLoadingIndicatorStyles(component:LoadingIndicator):void{
			component.circle = loadingIndicator;
			component.scaleWidth = scaleWidth;
		}
		
		
		protected function initializeViewAbstract(view:ViewAbstract):void{
			view.scaleHeight = scaleHeight;
			view.scaleWidth = scaleWidth;	
			view.baseBackground = baseViewBackground;
		}
		
		protected function setViewMainStyles(view:ViewMain):void{
			initializeViewAbstract(view);		
		}
		
		protected function setViewWelcomeStyles(view:ViewWelcome):void{
			initializeViewAbstract(view);		
			view.baseTextFormat = largeDarkElementFormat;
		}
		
		protected function setPopupAbstractStyles(view:PopupAbstract):void{
			view.scaleHeight = scaleHeight;
			view.scaleWidth = scaleWidth;	
		}
		
		protected function setPopupCreateListScratchStyles(view:PopupCreateListScratch):void{
			setPopupAbstractStyles(view);	
		}
		
		protected function setPopupCreateListExistingStyles(view:PopupCreateListExisting):void{
			setPopupAbstractStyles(view);	
		}
		
		protected function setItemrendererMainMenuStyles(view:ItemrendererMainMenu):void{
			view.scale = scaleHeight;
		}
		
		
		protected function setViewPackedStyles(view:ViewPackedList):void{
			initializeViewAbstract(view);
		}
				
		protected function setViewOpenStyles(view:ViewOpen):void{
			initializeViewAbstract(view);
		}
				
		protected function setItemRendererPackedStyles(renderer:ItemRendererPackedList):void{			
			renderer.scaleWidth = scaleWidth;
			renderer.iconArrow = iconArrow;
			renderer.iconEdit = iconEdit;
			renderer.iconBag = iconBag;
			renderer.iconMark = iconMark;
			renderer.iconRemove = iconRemove;
			renderer.atlas = atlas;									
		}
		
		protected function setItemRendererOpenListStyles(view:ItemrendererOpenList):void{
			view.scale = scaleWidth;
		}
		
		protected function setBottomMenuStyles(view:BottomMenu):void{
			view.scaleWidth = scaleWidth;
			view.scaleHeight = scaleHeight;
		}
		
		protected function setPopupRemoveItemStyles(view:PopupRemoveItem):void{
			setPopupAbstractStyles(view);	
		}
		
		protected function setViewAddCategory(view:ViewAddCategory):void{
			initializeViewAbstract(view);
			view.atlas = atlas;
			view.baseTextFormat = largeDarkElementFormat;
		}
		
		protected function setViewAddItem(view:ViewAddItem):void{
			initializeViewAbstract(view);			
		}
	}
}
