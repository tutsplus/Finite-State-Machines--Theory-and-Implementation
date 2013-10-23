package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;

	public class Game extends MovieClip
	{
		public static var mouse 		:Vector3D 	= new Vector3D(100, 100);
		public static var width 		:Number 	= 0;
		public static var height 		:Number 	= 0;
		public static var instance 		:Game;
		
		public var ant					:Ant;
		public var home					:Spot;
		public var leaf					:Spot;
		public var caption0				:Caption;
		public var caption1				:Caption;
		
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
			
			this.caption0 = new Caption();
			this.caption1 = new Caption();
			addChild(caption0);
			addChild(caption1);
		}
		
		public function update():void {
			this.ant.update();
			
			// The code from now on is a hell of an ugly hack :D
			caption0.visible = false;
			caption1.visible = false;
			
			// Make the caption follow the ant
			for (var i:int = 0; i < this.ant.brain.stack.length; i++) {
				this["caption" + i].setActive(i == this.ant.brain.stack.length - 1);
				
				this["caption" + i].visible = true;
				this["caption" + i].x = ant.x - 20;
				this["caption" + i].y = ant.y - 40 - 20 * i;
				this["caption" + i].label.text = this.ant.getFunctionName(this.ant.brain.stack[i]);
			}
		}
	}
}