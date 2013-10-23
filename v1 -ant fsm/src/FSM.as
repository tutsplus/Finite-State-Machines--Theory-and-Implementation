package  
{
	/**
	 * Implements a generic finite-state machine.
	 */
	public class FSM 
	{
		public var activeState :Function; // points to the currently active state function
		
		public function FSM() {		
		}
		
		public function setState(state :Function) :void {
			activeState = state;
		}
		
		public function update() :void {
			if (activeState != null) {
				activeState();
			}
		}
	}
}