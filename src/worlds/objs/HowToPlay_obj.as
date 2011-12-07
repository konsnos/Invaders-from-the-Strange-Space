package worlds.objs 
{
	import flash.events.TextEvent;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
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
			title.size = 20;
			title.align = "center";
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			
			selection.push(new Text(String("Turn right : right arrow, D, mouse cursor")));
			selection.push(new Text(String("Turn left : left arrow, A, mouse cursor")));
			selection.push(new Text(String("Shoot : Space, Z, X, C, mouse click")));
			selection.push(new Text(String("Pause : P")));
			selection.push(new Text(String("")));
			selection.push(new Text(String("Mouse can be enabled from the settings.")));
			selection.push(new Text(String("Accuracy bonus is calculated from the score multiplied by the accuracy ratio.")));
			selection.push(new Text(String("Life bonus is dependant to the difficulty of the level.")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).wordWrap = true;
				Text(selection[i]).size = 12;
				Text(selection[i]).align = "center";
				Text(selection[i]).width = 580
				Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
				Text(selection[i]).y = (FP.height - 100) / (selection.length + 1) * i + 80;
				Text(selection[i]).color = 0xffffff;
				Text(selection[i]).alpha = 1;
				menu.add(selection[i]);
			}
			
			back = new Text(String("back"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 10;
			Text(back).x = 5;
			Text(back).y = FP.height - (Text(back).height);
			Text(back).color = 0x006400;
			Text(back).alpha = 0.5;
			menu.add(back);
			
			graphic = menu;
		}
		
		override public function update():void 
		{
			if (back != null)
			{
				if (Input.mouseX >= Text(back).x && Input.mouseX <= Text(back).x + Text(back).width)
				{
					if (Input.mouseY >= Text(back).y && Input.mouseY <= Text(back).y + Text(back).height)
					{
						focus = true;
						if (Text(back).alpha != 1)
						{
							Text(back).alpha = 1;
							returnBack = true;
						}
					}else
					{
						if (Text(back).alpha != 0.5)
						{
							Text(back).alpha = 0.5;
							returnBack = false;
						}
					}
				}
			}
		}
		
	}

}