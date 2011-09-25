package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import worlds.SoundSystem;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Settings_Obj extends Menu_Obj 
	{
		
		// Automatically send stats.
		
		public function Settings_Obj() 
		{
			selection = new Array();
			
			title = new Text(String("Settings"));
			title.font = 'FONT_TITLE';
			title.size = 23;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			
			if (SoundSystem.muteG)
			{
				selection.push(new Text(String("Unmute sound")));
			}else
			{
				selection.push(new Text(String("Mute sound")));
			}
			Text(selection[0]).font = 'FONT_CHOICE';
			Text(selection[0]).size = 20;
			Text(selection[0]).x = FP.halfWidth - Text(selection[0]).width / 2;
			Text(selection[0]).y = FP.height / 4 * 1 + 150;
			Text(selection[0]).color = 0xffffff;
			Text(selection[0]).alpha = 1;
			menu.add(selection[0]);
			
			selection.push(new Text(String("Press Backspace to return")));
			Text(selection[selection.length - 1]).font = 'FONT_CHOICE';
			Text(selection[selection.length - 1]).size = 13;
			Text(selection[selection.length - 1]).x = 10;
			Text(selection[selection.length - 1]).y = FP.height - (Text(selection[selection.length - 1]).height +10);
			Text(selection[selection.length - 1]).color = 0x006400;
			Text(selection[selection.length - 1]).alpha = 1;
			menu.add(selection[selection.length - 1]);
			
			graphic = menu;
			
			choiceS = 0;
		}
		
		override public function update():void 
		{
			checkInput();
		}
		
		/**
		 * Checks the input.
		 */
		public function checkInput():void 
		{
			if (Input.pressed("down"))
			{
				Text(selection[choiceG]).alpha = 0.5;
				choiceS = 1;
				Text(selection[choiceG]).alpha = 1;
			}
			else if (Input.pressed("up"))
			{
				Text(selection[choiceG]).alpha = 0.5;
				choiceS = -1;
				Text(selection[choiceG]).alpha = 1;
			}
			
			if (Input.pressed("enter"))
			{
				switch (choiceG) 
				{
					case 0:
						SoundSystem.reverseMute();
						if (SoundSystem.muteG)
						{
							Text(selection[choiceG]).text = "Unmute sound";
						}else
						{
							Text(selection[choiceG]).text = "Mute sound";
						}
						break;
					default:
						break;
				}
			}
		}
		
	}

}