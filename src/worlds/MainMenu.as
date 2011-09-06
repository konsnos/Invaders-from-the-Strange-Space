package worlds 
{
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import worlds.objs.MainMenu_Obj;
	
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class MainMenu extends World 
	{
		
		public function MainMenu() 
		{
			GlobalVariables.RESETBACKDROPS();
		}
		
		override public function begin():void 
		{
			super.begin();
			
			addGraphic(GlobalVariables.backdrop1);
			addGraphic(GlobalVariables.backdrop2);
			
			add(new MainMenu_Obj);
		}
	}

}