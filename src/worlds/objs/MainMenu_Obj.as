package worlds.objs
{
	import flash.display.ShaderParameter;
	import flash.events.TextEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import worlds.Level;
	
	import GlobalVariables;
	/**
	 * ...
	 * @author konsnos
	 */
	public class MainMenu_Obj extends Menu_Obj
	{
		public function MainMenu_Obj()
		{
			selection = new Array();
			title = new Text(String("Space Invaders"));
			title.size = 50;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0xadff2f; // Green
			
			selection.push(new Text(String("New Game")));
			selection.push(new Text(String("Select Level")));
			selection.push(new Text(String("About")));
			
			for (var i:Number = 0; i < selection.length; i++)
			{
				Text(selection[i]).size = 30;
				Text(selection[i]).x = FP.width / 2 - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / 4 * (i + 1);
				Text(selection[i]).color = 0xFFFFFF; // White
				Text(selection[i]).alpha = 0.5;
			}
			
			Text(selection[0]).alpha = 1;
			menu = new Graphiclist(title, selection[0], selection[1], selection[2]);
			choiceS = 0;
			graphic = menu;
		}
		
		override public function update():void 
		{
			if (selected == null)
			{
				CheckInput();
			}
		}
		
		public function CheckInput():void 
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
						GlobalVariables.RESETSCORE();
						FP.world.removeAll();
						FP.world = new Level(1); // Fade screen to be added.
						break;
					case 1:
						selected = new SelectLevel_Obj;
						break;
					case 2:
						selected = new About_Obj;
						break;
				}
			}
		}
		
	}

}