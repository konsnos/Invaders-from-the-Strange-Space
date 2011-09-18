package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author konsnos
	 */
	public class HowToPlay_obj extends Menu_Obj
	{
		private var graphiclist:Graphiclist;
		
		public function HowToPlay_obj() 
		{
			selection = new Array();
			
			title = new Text(String("How to play"));
			title.size = 50;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0x006400; // Dark Green
			graphiclist = new Graphiclist(title);
			
			selection.push(new Text(String("Turn right : right arrow, D")));
			selection.push(new Text(String("Turn left : left arrow, A")));
			selection.push(new Text(String("Shoot : Space, Z, X, C")));
			selection.push(new Text(String("Pause : P")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).size = 20;
				Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / 6 * i + 150;
				Text(selection[i]).color = 0xffffff;
				Text(selection[i]).alpha = 1;
				graphiclist.add(selection[i]);
			}
			
			selection.push(new Text(String("Press Backspace to return")));
			graphiclist.add(selection[selection.length -1 ]);
			// The press backspace text.
			Text(selection[selection.length - 1]).size = 15;
			Text(selection[selection.length - 1]).x = 10;
			Text(selection[selection.length - 1]).y = FP.height - (Text(selection[selection.length - 1]).height +10);
			Text(selection[selection.length - 1]).color = 0x006400;
			Text(selection[selection.length - 1]).alpha = 1;
			
			menu = graphiclist;
			graphic = menu;
		}
		
	}

}