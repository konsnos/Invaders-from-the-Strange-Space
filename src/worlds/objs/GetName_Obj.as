package worlds.objs 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Playtomic.GeoIP;
	import Playtomic.Log;
	import worlds.SoundSystem;
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
			title.font = 'FONT_TITLE';
			title.size = 24;
			title.x = FP.width / 2 - title.width / 2;
			title.y = FP.height / 4;
			title.color = 0x32cd32; // Green
			
			selection.push(new Text(String("")));
			Text(selection[0]).font = 'FONT_CHOICE';
			Text(selection[0]).size = 22;
			Text(selection[0]).x = FP.width / 2 - Text(selection[0]).width / 2;
			Text(selection[0]).y = FP.height / 4 * 2;
			Text(selection[0]).color = 0xFFFFFF; // White
			Text(selection[0]).alpha = 1;
			
			prevkeys = Input.keyString;
			
			menu = new Graphiclist(title, selection[0]);
			choiceS = 0;
			graphic = menu;
			
			SoundSystem.reset();
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
				Log.CustomMetric("55", "version", true);
				GeoIP.Lookup(SetPlayerCountry);
				
				if (Text(selection[0]).text.length > 0)
				{
					GlobalVariables.USERNAME = Text(selection[0]).text.toLocaleUpperCase();
					Log.CustomMetric("DisabledMouse", "settings", true);
					Log.CustomMetric("DisabledMouse", "settings", true);
					selected = new MainMenu_Obj;
					for (var i:uint = 1; i < 11; i++)
					{
						new ListLeaderboards(i);
					}
				}else
				{
					Text(title).text = "Please provide a name";
				}
			}
		}
		
		public function SetPlayerCountry(country:Object, response:Object):void
		{
			if(response.Success)
			{
				// we have the country data
				Log.CustomMetric(country.Code, "country", true);
			}
			else
			{
				Log.CustomMetric("UnableToRetrieveCountry", "country", true);
				// request failed because of response.ErrorCode
			}
		}
	}

}