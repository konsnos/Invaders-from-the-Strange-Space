package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author ...
	 */
	public class Win_Obj extends Menu_Obj 
	{
		
		public function Win_Obj() 
		{
			selection = new Array();
			title = new Text(String("You Won!!!"));
			title.size = 50;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0x0000ff; // blue
			
			selection.push(new Text(String("Press Space to return to the Main Menu")));
			Text(selection[0]).size = 30;
			Text(selection[0]).x = FP.width / 2 - Text(selection[0]).width / 2;
			Text(selection[0]).y = FP.height / 2;
			Text(selection[0]).color = 0x00bfff; // white-blue
			
			menu = new Graphiclist(title, selection[0]);
			graphic = menu;
		}
		
	}

}