package 
{
	import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Playtomic.Log;
	
	import worlds.MainMenu;
	
	/**
	 * ...
	 * @author Konstantinos Egarhos
	 * @version 70
	 */
	public class SpaceInvaders extends Engine 
	{
		
		public function SpaceInvaders() 
		{
			super(640, 480);
			
			//Log.View(4391, "28a1f27e1ff34ceb", "14d426b6794c478f813040f8312975", root.loaderInfo.loaderURL);
			Log.View(4427, "bef6d9b33abf4e4c", "5022c37998b0439d98bc31247e6941", root.loaderInfo.loaderURL); // dev
		}
		
		override public function init():void 
		{
			super.init();
			
			Mouse.hide();
			//GlobalVariables.MOUSE = false;
			//FP.console.enable();
			
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
			Input.define("shoot", Key.SPACE, Key.Z, Key.X, Key.C);
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