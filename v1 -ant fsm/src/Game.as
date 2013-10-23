package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.text.TextField;

	public class Game extends MovieClip
	{
		public static var mouse 		:Vector3D 	= new Vector3D(100, 100);
		public static var width 		:Number 	= 0;
		public static var height 		:Number 	= 0;
		public static var instance 		:Game;
		
		public var ant					:Ant;
		public var home					:Spot;
		public var leaf					:Spot;
		public var caption				:Caption;
		
		public function Game() {
			Game.instance = this;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e :Event = null) :void {
			Game.width = stage.stageWidth;
			Game.height = stage.stageHeight;
			
			this.ant  = new Ant(Game.width * 0.3, Game.height / 2);
			this.home = new Spot(80, Game.height * 0.6, "home", "HOME");
			this.leaf = new Spot(Game.width - 100, Game.height * 0.2, "leaf", "LEAF");
			
			addChild(home);
			addChild(leaf);
			addChild(ant);
			
			caption = new Caption();
			addChild(caption);
		}
		
		public function update():void {
			this.ant.update();
			
			// Make the caption follow the ant
			caption.x = ant.x - 25;
			caption.y = ant.y - 40;
			caption.label.text = this.ant.getFunctionName(this.ant.brain.activeState);
		}
	}
}