package com.Application.themes {
	import com.Application.components.loadingIndicator.LoadingIndicator;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.mainmenu.ViewMain;
	
	import feathers.themes.MetalWorksMobileThemeWithAssetManager;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class ApplicationTheme extends MetalWorksMobileThemeWithAssetManager {
		
		
		
		protected var loadingIndicator:Texture;
		
		public function ApplicationTheme(assetsBasePath:String = null, assetManager:AssetManager = null) {
			super(assetsBasePath, assetManager);
		}
		
		
		override protected function initializeTextures():void{
			super.initializeTextures();
			
			this.loadingIndicator = this.atlas.getTexture("loading-white-indicator");			
		}
		
		override protected function initializeStyleProviders():void {
			super.initializeStyleProviders();
	
			this.getStyleProviderForClass(ViewMain).defaultStyleFunction = this.setViewMainStyles;	
			this.getStyleProviderForClass(LoadingIndicator).defaultStyleFunction = this.setLoadingIndicatorStyles;
		//	this.getStyleProviderForClass(LabelScreen).defaultStyleFunction = this.setLabelScreenStyles;		
			
		}	
	
		
		protected function setViewMainStyles(view:ViewMain):void{
			initializeViewAbstract(view);
							
		}
				
		
		
		protected function setLoadingIndicatorStyles(component:LoadingIndicator):void{
			component.circle = loadingIndicator;
			component.scaleWidth = scaleWidth;
		}
		
		
		protected function initializeViewAbstract(view:ViewAbstract):void{
			view.scaleHeight = scaleHeight;
			view.scaleWidth = scaleWidth;	
		}
		
	}
}
