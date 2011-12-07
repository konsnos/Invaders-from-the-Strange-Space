package worlds 
{
	import flash.ui.Mouse;
	import mochi.as3.MochiSocial;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.sound.Fader;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import objects.enemies.Big;
	import objects.enemies.Bonus;
	import worlds.objs.BlackScreen;
	import worlds.objs.ListLeaderboards;
	import worlds.objs.MainMenu_Obj;
	import worlds.objs.Menu_Obj;
	import worlds.objs.MuteBtn;
	import worlds.objs.Starfield;
	
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class MainMenu extends World 
	{
		// create the starfield
		private var field:Starfield = new Starfield();
		private var instance:Menu_Obj;
		private var nextInstance:Menu_Obj;
		private var prevTween:NumTween;
		private var updating:Boolean;
		private var objsArray:Array;
		private var forthOrBack:Boolean; // When this is true the scene changes from right to left.
		private var backgroundMusic:Sfx = new Sfx(GlobalVariables.MSC01);
		private var fade:BlackScreen;
		
		public function MainMenu() 
		{
			
		}
		
		override public function begin():void 
		{
			super.begin();
			add(new MuteBtn);
			
			MochiSocial.showLoginWidget({y:-4});
			
			Mouse.show();
			objsArray = new Array;
			SoundSystem.reset();
			
			if (GlobalVariables.USERNAME == null)
            {
                var s:Splash = new Splash();
                FP.world.add(s);
                s.start(splashComplete);
                var splash:Splash = new Splash();
                FP.world.add(splash);
                s.start(splashComplete);
            }else
            {
				if (MochiSocial.loggedIn)
				{
					GlobalVariables.USERNAME = MochiSocial._user_info.name;
				}else
				{
					GlobalVariables.USERNAME = "Guest";
					MochiSocial.addEventListener(MochiSocial.LOGGED_IN, loggedIn);
				}
				
                instance = new MainMenu_Obj;
                continueBegin();
            }
		}
		
		private function loggedIn(event:Object):void 
		{
			GlobalVariables.USERNAME = event.name;
		}
		
		private function continueBegin():void 
		{
			for (var i:uint = 1; i < 11; i++)
            {
                new ListLeaderboards(i);
            }
			
			addGraphic(field);
			GlobalVariables.gameState = GlobalVariables.PLAYING;
			fade = new BlackScreen();
			add(fade);
			
			add(instance);
			
			prevTween = new NumTween(changeInstances);
			addTween(prevTween);
			forthOrBack = true;
			
			SoundSystem.loop(backgroundMusic);
			SoundSystem.addFader();
			
			updating = false;
			
			fade.fadeIn();
			//add(new MuteBtn);
		}
		
		private function splashComplete():void 
		{
			//GlobalVariables.USERNAME = Kongregate.getUsername;
			if (MochiSocial.loggedIn)
			{
				GlobalVariables.USERNAME = MochiSocial._user_info.name;
			}else
			{
				GlobalVariables.USERNAME = "Guest";
				MochiSocial.addEventListener(MochiSocial.LOGGED_IN, loggedIn);
			}
			instance = new MainMenu_Obj;
			continueBegin();
		}
		
		override public function update():void 
		{
			if (instance != null)
			{
				background();
				
				selected();
				
				changingScreen();
				
				checkTransitioning();
			}
			
			super.update();
		}
		
		private function background():void 
		{
			if (FP.random < 0.005)
			{
				Bonus(FP.world.create(Bonus)).reset(0,FP.random*FP.height);
			}
		}
		
		private function checkTransitioning():void 
		{
			if (instance.fadeIn)
			{
				fade.fadeIn();
				instance.fadeIn = false;
			}else if (instance.fadeOut)
			{
				fade.fadeOut();
				SoundSystem.fadeOut(0,1);
				instance.fadeOut = false;
			}
		}
		
		private function changeInstances():void
		{
			if (forthOrBack)
			{
				objsArray.push(remove(instance));
			}
			else
			{
				objsArray.pop();
				remove(instance);
			}
			
			instance = nextInstance;
			add(instance);
			remove(nextInstance);
			updating = false;
			forthOrBack = true;
		}
		
		/**
		 * Initiating transition between objects.
		 */
		public function selected():void 
		{
			if (instance.selectedG != null && !updating)
			{
				nextInstance = instance.selectedG;
				if (forthOrBack)
				{
					add(nextInstance);
					nextInstance.x = FP.width;
					prevTween.tween(instance.x, instance.x - FP.width, 1, Ease.quartInOut);
					updating = true;
				}
			}else if ((Input.pressed("back") || (Input.mousePressed && instance.returnBackG)) && objsArray.length > 0 && !updating)
			{
				nextInstance = instance.selectedS = objsArray[objsArray.length -1];
				nextInstance.updates = true;
				updating = true;
				forthOrBack = false;
				
				add(nextInstance);
				nextInstance.x = FP.width;
				prevTween.tween(instance.x, instance.x + FP.width, 1, Ease.quartInOut);
				instance.selectedS = null;
				instance.updates = false;
				nextInstance.selectedS = null;
				updating = true;
			}
		}
		
		/**
		 * Updates the position of the objects changing places.
		 */
		public function changingScreen():void 
		{
			if (updating)
			{
				instance.x = prevTween.value;
				if (forthOrBack)
				{
					nextInstance.x = instance.x + FP.width;
				}
				else {
					nextInstance.x = instance.x - FP.width;
				}
			}
		}
		
		override public function end():void 
		{
			SoundSystem.pause(backgroundMusic);
			removeAll();
			FP.world.clearTweens();
			super.end();
		}
	}
}