package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Actor extends Entity 
	{
		protected var image:Image;
		private var hp:Number;
		public static var list:Number; // Total number of actors instantiated.
		
		// Gets-Sets
		public function get hpG():Number
		{
			if (hp < 0)
			{
				return 0;
			}
			return hp;
		}
		public function set hpS(setValue:Number):void 
		{
			hp += setValue;
			if (hp <= 0)
			{
				destroy();
			}
		}
		
		public function Actor() 
		{
			hp = 0;
		}
		
		public function takeDamage(damageTaken:uint):void 
		{
			hpS = -damageTaken;
		}
		
		public function destroy(points:uint = 0):void 
		{
			FP.world.recycle(this);
		}
		
		public static function resetList():void 
		{
			list = 0;
		}
		
	}

}