package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import Playtomic.Log;
	import worlds.Level;
	/**
	 * ...
	 * @author konsnos
	 */
	public class DifSel_Obj extends Menu_Obj 
	{
		
		public function DifSel_Obj() 
		{
			selection = new Array();
			selected = null;
			title = new Text(String("Select Difficulty"));
			title.font = 'FONT_TITLE';
			title.align = "center";
			title.size = 20;
			title.x = FP.halfWidth - title.width / 2;
			title.y = 20;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			updates = true;
			
			selection.push(new Text(String("Normal")));
			selection.push(new Text(String("Brutal")));
			
			for (var i:uint = 0; i < selection.length; i++)
			{
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).size = 16;
				Text(selection[i]).align = "center";
				Text(selection[i]).x = FP.halfWidth - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.height / (selection.length + 1) * (i + 1);
				Text(selection[i]).color = 0xFFFFFF; // White
				Text(selection[i]).alpha = 0.5;
				menu.add(selection[i]);
			}
			
			back = new Text(String("back"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 10;
			Text(back).x = 5;
			Text(back).y = FP.height - (Text(back).height);
			Text(back).color = 0x006400;
			Text(back).alpha = 1;
			menu.add(back);
			
			Text(selection[0]).alpha = 0.5;
			
			fadeIn = fadeOut = false;
			
			choiceS = 0;
			graphic = menu;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function checkInput():void 
		{
			super.checkInput();
			
			if (Input.pressed("enter") || Input.mousePressed)
			{
				switch (choiceG)
				{
					case 0:
						fadeOut = true;
						FP.alarm(1, normalGame);
						Log.CustomMetric("Normal", "difficulty");
						updates = false;
						break;
					case 1:
						fadeOut = true;
						FP.alarm(1, brutalGame);
						Log.CustomMetric("Brutal", "difficulty");
						GlobalVariables.BRUTALSCORE = 0;
						updates = false;
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * Starts level 1 from normal difficulty.
		 */
		public function normalGame():void 
		{
			FP.world = new Level(1,false);
		}
		
		/**
		 * Starts level 1 from brutal difficulty.
		 */
		public function brutalGame():void 
		{
			FP.world = new Level(1, true);
		}
	}

}