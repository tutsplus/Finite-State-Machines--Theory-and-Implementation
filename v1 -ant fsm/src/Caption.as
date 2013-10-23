package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Caption extends Sprite
	{
		public var label		:TextField
		public var background	:MovieClip;
		
		public function Caption() {
			label = new TextField();
			background = new MovieClip();
			
			setActive(true);
			
			label.text = "ant caption";
			label.textColor = 0x000000;
			label.selectable = false;
			
			label.x = 5;
			
			addChild(background);
			addChild(label);
		}
		
		public function setActive(status :Boolean) :void {
			background.graphics.clear();
			
			background.graphics.lineStyle(2, 0x000000);
			background.graphics.beginFill(status ? 0xcfcfcf : 0xffffff);
			background.graphics.drawRect(0, 0, 60, 20);
			background.graphics.endFill();
		}
	}
}