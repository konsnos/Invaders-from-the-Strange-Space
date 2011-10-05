package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author konsnos
	 */
	public class About_Obj extends Menu_Obj 
	{
		
		public function About_Obj() 
		{
			selection = new Array();
			title = new Text(String("About"));
			title.font = 'FONT_TITLE';
			title.size = 20;
			title.y = 10;
			title.x = FP.halfWidth - title.width/2;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			
			selection.push(new Text(String("Programming: Konstantinos Egarhos")));
			selection.push(new Text(String("Artwork: Tonia Hoimpa, Theodore Barlas")));
			selection.push(new Text(String("Tester: Theodore Barlas")));
			selection.push(new Text(String("Music: Genghis Attenborough from freesound project")));
			selection.push(new Text(String("Sound effects: from sfxr by Tomas Pettersson")));
			selection.push(new Text(String("Fonts: LiberationSans, Coalition, Ethnocentric")));
			
			for (var i:Number = 0; i < selection.length - 1; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).size = 13;
				Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2 * 0.8;
				Text(selection[i]).y = FP.height / 8 * (i + 1) +50;
				Text(selection[i]).color = 0xFFFFFF; // White
				Text(selection[i]).alpha = 1;
				menu.add(selection[i]);
			}
			
			back = new Text(String("Press Backspace to return"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 10;
			Text(back).x = 5;
			Text(back).y = FP.height - (Text(back).height);
			Text(back).color = 0x006400;
			Text(back).alpha = 1;
			menu.add(back);
			
			layer = 2;
			
			graphic = menu;
		}
		
	}

}