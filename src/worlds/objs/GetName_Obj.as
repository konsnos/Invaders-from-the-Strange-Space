package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Playtomic.Log;
	/**
	 * ...
	 * @author konsnos
	 */
	public class GetName_Obj extends Menu_Obj 
	{
		private var prevkeys:String;
		
		public function GetName_Obj() 
		{
			selection = new Array();
			title = new Text(String("Please write your name"));
			title.size = 30;
			title.x = FP.width / 2 - title.width / 2;
			title.y = FP.height / 4;
			title.color = 0x006400; // Green
			
			selection.push(new Text(String("")));
			Text(selection[0]).size = 30;
			Text(selection[0]).x = FP.width / 2 - Text(selection[0]).width / 2;
			Text(selection[0]).y = FP.height / 4 * 2;
			Text(selection[0]).color = 0xFFFFFF; // White
			Text(selection[0]).alpha = 1;
			
			prevkeys = Input.keyString;
			
			menu = new Graphiclist(title, selection[0]);
			choiceS = 0;
			graphic = menu;
		}
		
		override public function update():void 
		{
			if (prevkeys != Input.keyString && Text(selection[0]).text.length < 20)
			{
				Text(selection[0]).text += String.fromCharCode(Input.lastKey);
				prevkeys = Input.keyString;
				
				Text(selection[0]).x = FP.width / 2 - Text(selection[0]).width / 2;
			}
			
			if (Input.pressed(Key.BACKSPACE))
			{
				Text(selection[0]).text = "";
			}
			
			if (Input.pressed("enter"))
			{
				Log.Play();
				
				if (Text(selection[0]).text.length > 0)
				{
					GlobalVariables.USERNAME = Text(selection[0]).text;
					selected = new MainMenu_Obj;
				}else
				{
					Text(title).text = "Please provide a name";
				}
			}
		}
	}

}