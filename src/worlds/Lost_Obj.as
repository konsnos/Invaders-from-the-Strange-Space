package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Graphiclist;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Lost_Obj extends Menu_Obj 
	{
		
		public function Lost_Obj() 
		{
			selection = new Array();
			title = new Text(String("You lost"));
			title.size = 50;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0xb22222; // dark red
			
			selection.push(new Text(String("Press Enter to return to the Main Menu")));
			Text(selection[0]).size = 30;
			Text(selection[0]).x = FP.width / 2 - Text(selection[0]).width / 2;
			Text(selection[0]).y = FP.height / 2;
			Text(selection[0]).color = 0xcd5c5c; // White
			
			menu = new Graphiclist(title, selection[0]);
			graphic = menu;
		}
		
		override public function update():void 
		{
			if (Input.pressed("shoot"))
			{
				FP.world.removeAll();
				FP.world = new MainMenu;
			}
		}
	}

}