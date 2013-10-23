package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class Spot extends MovieClip
	{
		[Embed(source = '../assets/leaf.png')] public var ASSET_LEAF :Class; // Icons made by Lorc. Available on http://game-icons.net
		[Embed(source = '../assets/home.png')] public var ASSET_HOME :Class; // Icons made by Lorc. Available on http://game-icons.net
		
		private var label :TextField;
		
		public function Spot(posX :Number, posY :Number, type :String, caption :String) {
			x = posX;
			y = posY;
			
			var icon :Bitmap = type == "home" ? new ASSET_HOME : new ASSET_LEAF;
			icon.x = -icon.width / 2;
			icon.y = -icon.height / 2;
			addChild(icon);
			
			label = new TextField();
			label.text = caption;
			label.textColor = 0x000000;
			label.selectable = false;
			label.x = -20;
			label.y = 20;
			addChild(label);
		}
	}
}