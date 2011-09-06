package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import objects.Actor;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Alien extends Actor 
	{
		protected static var fireChance:Number; // Shows the possibility of firing. 0 < value < 1. 1 means fire in every frame.
		public static var list:Number; // Total number of aliens in the game.
		
		protected var soundExplosion:Sfx;
		
		public function Alien(x:Number, y:Number) 
		{
			super();
			this.x = x;
			this.y = y;
			
			list++;
		}
		
		override public function update():void 
		{
			
		}
		
		public static function resetList():void 
		{
			list = 0;
		}
		
		override public function destroy():void 
		{
			soundExplosion.play();
			list--;
			super.destroy();
		}
		
	}

}