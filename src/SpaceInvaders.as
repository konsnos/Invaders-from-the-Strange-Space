package 
{
	import flash.ui.Mouse;
	import mochi.as3.MochiServices;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Playtomic.Log;
	//import com.newgrounds.API;
	
	import worlds.MainMenu;
	
	/**
	 * ...
	 * @author Konstantinos Egarhos
	 * @version 70
	 */
	public class SpaceInvaders extends Engine 
	{
		//private var _mochiads_game_id:String = "a5741d193f8a5bd9";
		
		public function SpaceInvaders() 
		{
			super(640, 480);
			
			Log.View(4391, "28a1f27e1ff34ceb", "14d426b6794c478f813040f8312975", root.loaderInfo.loaderURL);
			//Log.View(4427, "bef6d9b33abf4e4c", "5022c37998b0439d98bc31247e6941", root.loaderInfo.loaderURL); // dev
			
			//API.connect(root, "21203:tPywpP16", "XnCnyQDWahIt5sQhPOydL1D7P2i4Ao9T");
			//MochiServices.connect("a5741d193f8a5bd9", root, onConnectError);
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
			Input.define("shoot", Key.SPACE, Key.Z, Key.X, Key.C);
			Input.define("enter", Key.ENTER);
			Input.define("pause", Key.P);
			Input.define("back", Key.BACKSPACE);
			
			GlobalVariables.FILLMAPARRAY();
			GlobalVariables.FILLEXPLOSIONARRAY();
			GlobalVariables.RESETSCORE();
			//GlobalVariables.MOUSE = true;
			
			FP.world = new MainMenu;
			FP.screen.color = 0x111111;
		}
		
		public function onConnectError(status:String):void 
		{
			
		}
	}
	
}