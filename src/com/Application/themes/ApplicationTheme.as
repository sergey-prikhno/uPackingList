package com.Application.themes {
	import com.Application.components.loadingIndicator.LoadingIndicator;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.welcome.ViewWelcome;
	
	import flash.geom.Rectangle;
	
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import feathers.themes.MetalWorksMobileThemeWithAssetManager;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class ApplicationTheme extends MetalWorksMobileThemeWithAssetManager {
		
		
		
		protected var loadingIndicator:Texture;
		protected var baseViewBackground:Scale9Textures;
		
		public function ApplicationTheme(assetsBasePath:String = null, assetManager:AssetManager = null) {
			super(assetsBasePath, assetManager);
		}
		
		
		override protected function initializeTextures():void{
			super.initializeTextures();
			
			this.loadingIndicator = this.atlas.getTexture("loading-white-indicator");
			this.baseViewBackground = new Scale9Textures(this.atlas.getTexture("background-base"),new Rectangle(10,10,20,20));
		}
		
		override protected function initializeStyleProviders():void {
			super.initializeStyleProviders();
	
			this.getStyleProviderForClass(ViewMain).defaultStyleFunction = this.setViewMainStyles;
			this.getStyleProviderForClass(ViewWelcome).defaultStyleFunction = this.setViewWelcomeStyles;
			this.getStyleProviderForClass(LoadingIndicator).defaultStyleFunction = this.setLoadingIndicatorStyles;
		//	this.getStyleProviderForClass(LabelScreen).defaultStyleFunction = this.setLabelScreenStyles;		
			
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
			
		}
		
	}
}
