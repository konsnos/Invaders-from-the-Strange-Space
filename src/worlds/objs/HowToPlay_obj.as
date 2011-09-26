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
		
		public function HowToPlay_obj() 
		{
			selection = new Array();
			
			title = new Text(String("How to play"));
			title.font = 'FONT_TITLE';
			title.size = 23;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			
			selection.push(new Text(String("Turn right : right arrow, D")));
			selection.push(new Text(String("Turn left : left arrow, A")));
			selection.push(new Text(String("Shoot : Space, Z, X, C")));
			selection.push(new Text(String("Pause : P")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).size = 20;
				Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / 6 * i + 150;
				Text(selection[i]).color = 0xffffff;
				Text(selection[i]).alpha = 1;
				menu.add(selection[i]);
			}
			
			back = new Text(String("Press Backspace to return"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 13;
			Text(back).x = 10;
			Text(back).y = FP.height - (Text(selection[selection.length - 1]).height +10);
			Text(back).color = 0x006400;
			Text(back).alpha = 1;
			menu.add(back);
			
			graphic = menu;
		}
		
	}

}