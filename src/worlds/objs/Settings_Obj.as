package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import Playtomic.Log;
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
			title.size = 20;
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
			
			if (GlobalVariables.MOUSE)
			{
				selection.push(new Text(String("Disable mouse")));
			}else
			{
				selection.push(new Text(String("Enable mouse")));
			}
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).size = 16;
				Text(selection[i]).x = FP.halfWidth - Text(selection[0]).width / 2;
				Text(selection[i]).y = FP.height / (selection.length + 1) * (i + 1);
				Text(selection[i]).color = 0xffffff;
				Text(selection[i]).alpha = 0.5;
				menu.add(selection[i]);
			}
			Text(selection[0]).alpha = 1;
			
			back = new Text(String("Press Backspace to return"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 10;
			Text(back).x = 5;
			Text(back).y = FP.height - (Text(selection[selection.length - 1]).height);
			Text(back).color = 0x006400;
			Text(back).alpha = 1;
			menu.add(back);
			
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
							Log.CustomMetric("UnmutedSound", "settings", true);
						}else
						{
							Text(selection[choiceG]).text = "Mute sound";
							Log.CustomMetric("MutedSound", "settings", true);
						}
						break;
					case 1:
						GlobalVariables.REVERSEMOUSE();
						if (GlobalVariables.MOUSE)
						{
							Text(selection[choiceG]).text = "Disable mouse";
							Log.CustomMetric("DisabledMouse", "settings", true);
						}else
						{
							Text(selection[choiceG]).text = "Disable mouse";
							Log.CustomMetric("EnabledMouse", "settings", true);
						}
					default:
						break;
				}
			}
		}
		
	}

}