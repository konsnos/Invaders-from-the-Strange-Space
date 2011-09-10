package worlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import worlds.objs.MainMenu_Obj;
	import worlds.objs.Menu_Obj;
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
		
		public function MainMenu() 
		{
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			objsArray = new Array;
			
			addGraphic(field);
			
			instance = new MainMenu_Obj;
			add(instance);
			
			prevTween = new NumTween(changeInstances);
			addTween(prevTween);
			forthOrBack = true;
			
			updating = false;
		}
		
		override public function update():void 
		{
			if (instance.selectedG != null && !updating)
			{
				nextInstance = instance.selectedG;
				if (forthOrBack)
				{
					add(nextInstance);
					nextInstance.x = FP.width;
					prevTween.tween(instance.x, instance.x - FP.width, 1, Ease.quartInOut);
					instance.selectedS = null;
					updating = true;
				}
			}else if (Input.pressed("back") && objsArray.length > 0 && !updating)
			{
				nextInstance = instance.selectedS = objsArray[objsArray.length -1];
				updating = true;
				forthOrBack = false;
				
				add(nextInstance);
				nextInstance.x = FP.width;
				prevTween.tween(instance.x, instance.x + FP.width, 1, Ease.quartInOut);
				instance.selectedS = null;
				updating = true;
			}
			
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
			
			super.update();
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
	}

}