package worlds.objs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Pause_Obj extends Menu_Obj
	{
		
		public function Pause_Obj()
		{
			selection = new Array();
			title = new Text(String("Paused"));
			title.size = 50;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0xffd700; // yellow 
			
			selection.push(new Text(String("Press 'P' to continue")));
			selection.push(new Text(String("Press 'BACKSPACE' to exit")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).size = 30;
				Text(selection[i]).x = FP.width / 2 - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / 4 * 2 + (i * 30);
				Text(selection[i]).color = 0xffd700; // yellow
			}
			
			menu = new Graphiclist(title, selection[0], selection[1]);
			graphic = menu;
		}
		
	}

}