package worlds.objs 
{
	import adobe.utils.ProductManager;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class BlackScreen extends Entity 
	{
		private var fade:Image;
		private var fader:NumTween = new NumTween(faderEnd);
		public var completed:Boolean;
		public var completedF:Function;
		
		/**
		 * 
		 */
		public function BlackScreen(color:uint = 0) 
		{
			layer = -10;
			completed = true;
			fade = Image.createRect(FP.width, FP.height, color);
			graphic = new Graphiclist(fade);
			
			// Set the fade cover properties.
			fade.x -= x;
			fade.y -= y;
			
			addTween(fader);
		}
		
		override public function update():void 
		{
			// Fade in/out alpha control.
			fade.alpha = fader.value;
		}
		
		/**
		 * Fades the splash screen in.
		 * @param fromValue Starting value.
		 * @param time	The time the transition will need.
		 * @param reverse If true, when completed it will fade out.
		 */
		public function fadeIn(fromValue:Number = 1, time:Number = 1, reverse:Boolean = false):void
		{
			fader.tween(fromValue, 0, time, Ease.cubeOut);
			completed = false;
			if (reverse)
			{
				completedF = fadeOut(fromValue, time) as Function;
			}
		}
		
		/**
		 * Fades the splash screen out.
		 * @param toValue End value.
		 * @param time	The time the transition will need.
		 * @param reverse If true, when completed it will fade in.
		 */
		public function fadeOut(toValue:Number = 1, time:Number = 1, reverse:Boolean = false ):void
		{
			fader.tween(0, toValue, time, Ease.cubeIn);
			completed = false;
			if (reverse)
			{
				completedF = fadeIn(toValue, time) as Function;
			}
		}
		
		/**
		 * Executes when the fade in/out has finished.
		 */
		private function faderEnd():void 
		{
			completed = true;
			if (completedF != null)
			{
				completedF();
			}
		}
		
	}

}