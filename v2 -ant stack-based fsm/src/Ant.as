package  
{
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	
	public class Ant extends MovieClip
	{
		public static const MAX_VELOCITY 		:Number = 3;
		public static const MOUSE_THREAT_RADIUS :Number = 120;
				
		public var position 	:Vector3D;
		public var velocity 	:Vector3D;
		public var brain		:StackFSM;
		
		public function Ant(posX :Number, posY :Number) {
			position 	= new Vector3D(posX, posY);
			velocity 	= new Vector3D( -1, -1);
			brain		= new StackFSM();
			
			// Tell the brain to start looking for the leaf.
			brain.pushState(findLeaf);
			
			// Init position, velocity and graphics...
			init();
		}
		
		/**
		 * The "findLeaf" state.
		 * It makes the ant move towards the leaf.
		 */
		public function findLeaf() :void {
			// Move the ant towards the leaf.
			velocity = new Vector3D(Game.instance.leaf.x - position.x, Game.instance.leaf.y - position.y);
			
			if (distance(Game.instance.leaf, this) <= 10) {
				// The ant is extremelly close to the leaf, it's time
				// to go home.
				brain.popState(); // removes "findLeaf" from the stack.
				brain.pushState(goHome); // push "goHome" state, making it the active state.
			}

			if (distance(Game.mouse, this) <= MOUSE_THREAT_RADIUS) {
				// Mouse cursor is threatening us. Let's run away!
				// The "runAway" state is pushed on top of "findLeaf", which means
				// the "findLeaf" state will be active again when "runAway" ends.
				brain.pushState(runAway);
			}
		}
		
		/**
		 * The "goHome" state.
		 * It makes the ant move towards its home.
		 */
		public function goHome() :void {
			// Move the ant towards home
			velocity = new Vector3D(Game.instance.home.x - position.x, Game.instance.home.y - position.y);
			
			if (distance(Game.instance.home, this) <= 10) {
				// The ant is home, let's find the leaf again.
				brain.popState(); // removes "goHome" from the stack.
				brain.pushState(findLeaf); // push "findLeaf" state, making it the active state
			}
			
			if (distance(Game.mouse, this) <= MOUSE_THREAT_RADIUS) {
				// Mouse cursor is threatening us. Let's run away!
				// The "runAway" state is pushed on top of "goHome", which means
				// the "goHome" state will be active again when "runAway" ends.
				brain.pushState(runAway);
			}
		}
		
		/**
		 * The "runAway" state.
		 * It makes the ant run away from the mouse cursor.
		 */
		public function runAway() :void {
			// Move the ant away from the mouse cursor
			velocity = new Vector3D(position.x - Game.mouse.x, position.y - Game.mouse.y);
			
			// Is the mouse cursor still close?
			if (distance(Game.mouse, this) > MOUSE_THREAT_RADIUS) {
				// No, the mouse cursor has gone away. Let's go back to the previously
				// active state.
				brain.popState();
			}
		}
		
		public function update():void {
			// Update the FSM controlling the "brain". It will invoke the currently
			// active state function: findLeaf(), goHome() or runAway().
			brain.update();
			
			// Apply the velocity vector to the position, making the ant move.
			moveBasedOnVelocity();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////
		// The methods below are not related to the FSM itself, they are utility methods to
		// create the demo.
		////////////////////////////////////////////////////////////////////////////////////////////
		
		private function moveBasedOnVelocity() :void {
			// Add velocity to the position vector, making the ant move.
			// Link: http://en.wikipedia.org/wiki/Euler_method
			truncate(velocity, MAX_VELOCITY);
			position = position.add(velocity);
			
			x = position.x;
			y = position.y;
			
			// Adjust rotation to match the velocity vector.
			rotation = 90 + (180 * getAngle(velocity)) / Math.PI;
		}
		
		private function makeGraphics() :void {
			graphics.lineStyle(2, 0xffaabb);
			graphics.beginFill(0xFF0000);
			graphics.moveTo(0, 0);
			graphics.lineTo(0, -20);
			graphics.lineTo(10, 20);
			graphics.lineTo(-10, 20);
			graphics.lineTo(0, -20);
			graphics.endFill();
			
			graphics.moveTo(0, 0);
		}
		
		private function truncate(vector :Vector3D, max :Number) :void {
			var i :Number;

			i = max / vector.length;
			i = i < 1.0 ? i : 1.0;
			
			vector.scaleBy(i);
		}
		
		private function getAngle(vector :Vector3D) :Number {
			return Math.atan2(vector.y, vector.x);
		}
		
		private function setAngle(vector :Vector3D, value:Number):void {
			var len :Number = vector.length;
			vector.x = Math.cos(value) * len;
			vector.y = Math.sin(value) * len;
		}
		
		private function init() :void {
			truncate(velocity, MAX_VELOCITY);
			x = position.x;
			y = position.y;
			
			makeGraphics();
		}
		
		private function distance(a :Object, b :Object) :Number {
			return Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
		}
		
		public function getFunctionName(f :Function) :String {
			if (f == findLeaf) return "findLeaf";
			else if (f == goHome) return "goHome";
			else if (f == runAway) return "runAway";
			
			return "???";
		}
	}
}