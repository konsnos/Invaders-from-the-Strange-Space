package worlds.objs 
{
	import flash.sampler.NewObjectSample;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import Playtomic.Log;
	import worlds.Level;
	/**
	 * ...
	 * @author konsnos
	 */
	public class SelectLevel_Obj extends Menu_Obj 
	{
		private var prevTween:NumTween;
		private var updating:Boolean;
		
		public function SelectLevel_Obj() 
		{
			selection = new Array();
			selected = null;
			title = new Text(String("Select Level"));
			title.font = 'FONT_TITLE';
			title.size = 20;
			title.x = FP.width / 2 - title.width / 2;
			title.y = 20;
			title.color = 0x32cd32; // Dark Green
			menu = new Graphiclist(title);
			updating = false;
			updates = true;
			
			for (var i:uint = 0; i < GlobalVariables.MAP.length; i++)
			{
				selection.push(new Text(String("Level " + (i+1))));
				Text(selection[i]).font = 'FONT_CHOICE';
				Text(selection[i]).size = 16;
				Text(selection[i]).x = FP.width / 2 - Text(selection[i]).width / 2;
				Text(selection[i]).y = FP.halfHeight - Text(selection[i]).height / 2 + (FP.height / 5 * i);
				Text(selection[i]).color = 0xFFFFFF; // White
				Text(selection[i]).alpha = 0.5;
				
				menu.add(selection[i]);
			}
			
			back = new Text(String("Press Backspace to return"));
			Text(back).font = 'FONT_CHOICE';
			Text(back).size = 10;
			Text(back).x = 5;
			Text(back).y = FP.height - (Text(selection[selection.length - 1]).height);
			Text(back).color = 0x006400;
			Text(back).alpha = 1;
			menu.add(back);
			
			prevTween = new NumTween(updated);
			addTween(prevTween);
			Text(selection[0]).alpha = 1;
			choiceS = 0;
			graphic = menu;
		}
		
		override public function update():void 
		{
			if (selected == null && updates == true)
			{
				CheckInput();
			}
			
			if (updating)
			{
				Text(selection[0]).y = prevTween.value;
				
				for (var i:uint = 1; i < GlobalVariables.MAP.length; i++)
				{
					Text(selection[i]).y = prevTween.value + 95 * i;
				}
			}
		}
		
		public function CheckInput():void 
		{
			if (Input.check("down") && !updating && choiceG != selection.length - 1)
			{
				prevTween.tween(Text(selection[0]).y, Text(selection[0]).y - FP.height / 5, 0.3, Ease.sineInOut);
				updating = true;
				Text(selection[choiceG]).alpha = 0.5;
				choiceS = 1;
				Text(selection[choiceG]).alpha = 1;
			}
			else if (Input.check("up") && !updating && choiceG != 0)
			{
				prevTween.tween(Text(selection[0]).y, Text(selection[0]).y + FP.height / 5, 0.3, Ease.sineInOut);
				updating = true;
				Text(selection[choiceG]).alpha = 0.5;
				choiceS = -1;
				Text(selection[choiceG]).alpha = 1;
			}
			
			if (Input.pressed("enter") && !updating)
			{
				fadeOut = true;
				updates = false;
				FP.alarm(1, startLevel);
			}
		}
		
		public function updated():void 
		{
			updating = false;
		}
		
		public function startLevel():void 
		{
			Log.LevelCounterMetric("LevelSelected", int(choiceG + 1));
			FP.world = new Level(choiceG + 1);
		}
	}
}