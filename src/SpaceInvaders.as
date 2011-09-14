package 
{
	import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import worlds.MainMenu;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class SpaceInvaders extends Engine 
	{
		
		public function SpaceInvaders():void 
		{
			super(800, 600);
		}
		
		override public function init():void 
		{
			super.init();
			
			Mouse.hide();
			//FP.console.enable();
			
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
			Input.define("shoot", Key.SPACE);
			Input.define("enter", Key.ENTER);
			Input.define("pause", Key.P);
			Input.define("back", Key.BACKSPACE);
			
			GlobalVariables.FILLMAPARRAY();
			GlobalVariables.FILLEXPLOSIONARRAY();
			GlobalVariables.RESETSCORE();
			
			FP.world = new MainMenu;
			FP.screen.color = 0x111111;
		}
		
	}
	
}