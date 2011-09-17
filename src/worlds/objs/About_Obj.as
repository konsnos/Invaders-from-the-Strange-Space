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
		private var graphiclist:Graphiclist;
		
		public function About_Obj() 
		{
			selection = new Array();
			title = new Text(String("About"));
			title.size = 50;
			title.y = 10;
			title.x = FP.halfWidth - title.width/2;
			title.color = 0x006400; // Dark Green
			graphiclist = new Graphiclist(title);
			
			selection.push(new Text(String("Programming: Konstantinos Egarhos")));
			selection.push(new Text(String("Artwork: Tonia Hoimpa")));
			selection.push(new Text(String("Tester: Theodore Barlas")));
			selection.push(new Text(String("Music: Genghis Attenborough from freesound project")));
			selection.push(new Text(String("Sound effects: from sfxr by Tomas Pettersson")));
			selection.push(new Text(String("Press Backspace to return")));
			
			for (var i:Number = 0; i < selection.length - 1; i++)
			{
				Text(selection[i]).size = 20;
				Text(selection[i]).x = FP.width / 2 - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / 8 * (i + 1);
				Text(selection[i]).color = 0xFFFFFF; // White
				Text(selection[i]).alpha = 1;
				graphiclist.add(selection[i]);
			}
			
			// The press backspace text.
			Text(selection[selection.length - 1]).size = 15;
			Text(selection[selection.length - 1]).x = 10;
			Text(selection[selection.length - 1]).y = FP.height - (Text(selection[selection.length - 1]).height +10);
			Text(selection[selection.length - 1]).color = 0x006400;
			Text(selection[selection.length - 1]).alpha = 1;
			graphiclist.add(selection[selection.length - 1]);
			
			layer = 2;
			
			graphic = graphiclist;
		}
		
	}

}