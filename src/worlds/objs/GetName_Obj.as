package worlds.objs 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import mochi.as3.MochiSocial;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Playtomic.GeoIP;
	import Playtomic.Leaderboards;
	import Playtomic.Log;
	import Playtomic.PlayerScore;
	import worlds.SoundSystem;
	/**
	 * ...
	 * @author konsnos
	 */
	public class GetName_Obj extends Menu_Obj 
	{
		private var prevkeys:String;
		private static const TEXT_BACKGROUND:Image = new Image(new BitmapData(250, 30, true, 0x44444444));
		
		public function GetName_Obj() 
		{
			selection = new Array();
			
			title = new Text(String("Please write your name"));
			title.font = 'FONT_TITLE';
			title.align = "center";
			title.size = 24;
			title.x = FP.width / 2 - title.width / 2;
			title.y = FP.height / 4;
			title.color = 0x32cd32; // Green
			
			TEXT_BACKGROUND.x = FP.halfWidth - TEXT_BACKGROUND.width / 2;
			TEXT_BACKGROUND.y = FP.height / 4 * 2;
			
			selection.push(new Text(String("")));
			Text(selection[0]).font = 'FONT_CHOICE';
			Text(selection[0]).align = "center";
			Text(selection[0]).size = 22;
			Text(selection[0]).x = FP.halfWidth - Text(selection[0]).width / 2;
			Text(selection[0]).y = FP.height / 4 * 2;
			Text(selection[0]).color = 0xFFFFFF; // White
			Text(selection[0]).alpha = 1;
			
			selection.push(new Text(String("Ok")));
			Text(selection[1]).font = 'FONT_CHOICE';
			Text(selection[1]).align = "center";
			Text(selection[1]).size = 22;
			Text(selection[1]).x = FP.width / 2 - Text(selection[1]).width / 2;
			Text(selection[1]).y = FP.height / 4 * 3;
			Text(selection[1]).color = 0x006400; // White
			Text(selection[1]).alpha = 0.5;
			
			prevkeys = Input.keyString;
			
			menu = new Graphiclist(title, selection[0], TEXT_BACKGROUND, selection[1]);
			choiceS = 0;
			graphic = menu;
			
			SoundSystem.reset();
			
			MochiSocial.addEventListener(MochiSocial.ERROR, handleError);
			MochiSocial.addEventListener(MochiSocial.LOGGED_IN, loggedIn);
			
			MochiSocial.showLoginWidget();
		}
		
		override public function update():void 
		{
			if (prevkeys != Input.keyString && Text(selection[0]).text.length < 10)
			{
				Text(selection[0]).text += cleanText(Input.lastKey);
				prevkeys = Input.keyString;
				
				Text(selection[0]).x = FP.halfWidth - Text(selection[0]).width / 2;
			}
			
			if (Input.pressed(Key.BACKSPACE))
			{
				Text(selection[0]).text = Text(selection[0]).text.slice(0, Text(selection[0]).text.length -1 );
			}
			
			if((Input.mouseX >= Text(selection[1]).x && Input.mouseX <= Text(selection[1]).x + Text(selection[1]).width) && 
			(Input.mouseY >= Text(selection[1]).y && Input.mouseY <= Text(selection[1]).y + Text(selection[1]).height))
			{
				if (Text(selection[1]).alpha != 1)
				{
					Text(selection[1]).alpha = 1;
				}
			}else
			{
				if (Text(selection[1]).alpha != 0.5)
				{
					Text(selection[1]).alpha = 0.5;
				}
			}
			
			if (Input.pressed("enter") || (Input.mousePressed && Text(selection[1]).alpha == 1))
			{
				Log.Play();
				Log.CustomMetric("v1.2", "version", true);
				GeoIP.Lookup(SetPlayerCountry);
				
				if (Text(selection[0]).text.length > 0)
				{
					GlobalVariables.USERNAME = Text(selection[0]).text;
					Log.CustomMetric("DisabledMouse", "settings", true);
					Log.CustomMetric("DisabledMouse", "settings", true);
					selected = new MainMenu_Obj;
					for (var i:uint = 1; i < 11; i++)
					{
						new ListLeaderboards(i);
					}
					Leaderboards.List("brutalhighscores", this.brutalListComplete);
					MochiSocial.hideLoginWidget();
				}else
				{
					Text(title).text = "Please provide a name";
				}
			}
			
			if (MochiSocial.loggedIn)
			{
				if (Text(selection[0]).text == "") 
				{
					Text(selection[0]).text = MochiSocial._user_info.name;
				}
			}
		}
		
		private function cleanText(value:int):String
		{
			var target:String = String.fromCharCode(value).toLocaleUpperCase();
			if ((target >= 'A' && target <= 'Z') || (target >= '0' && target <= '9'))
			{
				return target;
			}else 
			{
				return '';
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
		
		public function brutalListComplete(scores:Array, numscores:int, response:Object):void 
		{
			if (response.Success)
			{
				var score:PlayerScore = scores[0];
				if (score != null)
				{
					GlobalVariables.BRUTALHIGHSCORE = score.Points;
				}
			}else
			{
				
			}
		}
		
		private function loggedIn(event:Object):void 
		{
			Text(selection[0]).text = event.name;
			trace("Hello " + event.name + "!!!!!!!!!!!!!!");
		}
		
		private function handleError():void 
		{
			
		}
	}

}