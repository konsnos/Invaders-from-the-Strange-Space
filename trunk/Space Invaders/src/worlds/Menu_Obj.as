package worlds
{
	import flash.display.ShaderParameter;
	import flash.events.TextEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import objects.GlobalVariables;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Menu_Obj extends Entity
	{
		private var title:Text;
		private var selection:Array;
		private var menu:Graphiclist;
		private var choice:int = 1;
		private function get choiceG():int
		{
			return choice;
		}
		private function set choiceS(setValue:int):void 
		{
			if (setValue == 0)
			{
				choice = 0;
			}else
			{
				choice += setValue;
				if (choice < 0)
				{
					choice = 2;
				}else if (choice > 2)
				{
					choice = 0;
				}
			}
		}
		
		public function Menu_Obj() 
		{
			selection = new Array();
			title = new Text(String("Space Invaders"));
			title.size = 50;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0xadff2f; // Green
			
			selection.push(new Text(String("New Game")));
			selection.push(new Text(String("Load Game")));
			selection.push(new Text(String("About")));
			
			for (var i:Number = 0; i < selection.length; i++)
			{
				Text(selection[i]).size = 30;
				Text(selection[i]).x = FP.width / 2 - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / 4 * (i + 1);
				Text(selection[i]).color = 0xFFFFFF; // White
			}
			
			menu = new Graphiclist(title, selection[0], selection[1], selection[2]);
			choiceS = 0;
			graphic = menu;
		}
		
		override public function update():void 
		{
			if (Input.pressed("down"))
			{
				choiceS = 1;
			}
			else if (Input.pressed("up"))
			{
				choiceS = -1;
			}
			
			if (choice == 0)
			{
				Text(selection[0]).alpha = 1;
				Text(selection[1]).alpha = 0.5;
				Text(selection[2]).alpha = 0.5;
			}
			else if (choice == 1)
			{
				Text(selection[0]).alpha = 0.5;
				Text(selection[1]).alpha = 1;
				Text(selection[2]).alpha = 0.5;
			}
			else if (choice == 2)
			{
				Text(selection[0]).alpha = 0.5;
				Text(selection[1]).alpha = 0.5;
				Text(selection[2]).alpha = 1;
			}
			
			if (Input.pressed(Key.ENTER))
			{
				switch (choice) 
				{
					case 0:
						GlobalVariables.RESETSCORE();
						FP.world.removeAll();
						FP.world = new Level;
						break;
					case 1:
						trace("Load Game");
						break;
					case 2:
						trace("About");
						break;
				}
			}
		}
		
	}

}