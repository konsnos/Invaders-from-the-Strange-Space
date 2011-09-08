package worlds 
{
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import worlds.objs.MainMenu_Obj;
	import worlds.objs.Starfield;
	
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class MainMenu extends World 
	{
		// create the starfield
		private var field:Starfield = new Starfield();
		
		public function MainMenu() 
		{
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			addGraphic(field);
			
			add(new MainMenu_Obj);
		}
	}

}