package worlds.objs 
{
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
		private var fade:Image = Image.createRect(FP.width, FP.height, 0);
		private var fader:NumTween = new NumTween(faderEnd);
		public var completed:Boolean;
		
		/**
		 * 
		 */
		public function BlackScreen() 
		{
			layer = -10;
			completed = true;
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
		 * @param time	The time the transition will need.
		 */
		public function fadeIn(time:Number=1):void
		{
			fader.tween(1, 0, time, Ease.cubeOut);
			completed = false;
		}
		
		/**
		 * Fades the splash screen out.
		 * @param time	The time the transition will need.
		 */
		public function fadeOut(time:Number=1):void
		{
			fader.tween(0, 1, time, Ease.cubeIn);
			completed = false;
		}
		
		/**
		 * Executes when the fade in/out has finished.
		 */
		private function faderEnd():void 
		{
			completed = true;
		}
		
	}

}