package objects.bullets
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import worlds.objs.Stats_Obj;
	import worlds.Level;
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Bullet extends Entity 
	{
		public static var list:uint;
		public static var listEnem:uint; // Enemy bullets
		public static var listEnemS:uint;
		public static var listEnemM:uint;
		public static var listEnemB:uint;
		public static var listEnemBon:uint;
		public static var listP:uint; // Player bullets
		protected var sprite:Spritemap = new Spritemap(GlobalVariables.IMG_BULLET, 2, 6);
		protected var speed:int;
		protected var damage:uint;
		
		// Player accuracy
		public static var bulletsShot:uint; // For accuracy.
		public static var bulletsHitT:uint; // Bullets that hit the target.
		
		// Gets-Sets
		public function get damageG():uint 
		{
			return damage;
		}
		
		public function Bullet()
		{
			sprite.add("yellow", [0], 0, false);
			sprite.add("red", [1], 0, false);
			graphic = sprite;
			
			type = "bullet";
			layer = 1;
			
			speed = 0;
			setHitbox(2, 6);
		}
		
		override public function update():void
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING || 
			GlobalVariables.gameState == GlobalVariables.WIN ||
			GlobalVariables.gameState == GlobalVariables.LOST)
			{
				this.y += speed * FP.elapsed;
				
				if (this.y + height < 0)
				{
					destroy();
				}
				else if (this.y > FP.height)
				{
					destroy();
				}
			}
		}
		
		public function destroy():void 
		{
			if (this.type == "bullet_P")
			{
				Stats_Obj.updateAcc();
				Stats_Obj.updateStatsText();
			}
			FP.world.recycle(this);
		}
		
		/**
		 * Resets the position, damage, image and type of the bullet.
		 * @param	x Position in the x axis.
		 * @param	y Position in the y axis.
		 * @param	speed Speed of the bullet.
		 * @param	damage Damage dealt by the bullet.
		 * @param	img Image of the bullet.
		 * @param	type Type of the bullet.
		 */
		public function reset(x:Number, y:Number, speed:int = 0, damage:uint = 1, type:String = null):void 
		{
			this.x = x;
			this.y = y;
			
			this.speed = speed;
			this.damage = damage;
			this.type = type;
			
			Bullet.list++;
			
			switch (this.type) 
			{
				case "Bullet_P":
					listP++;
					bulletsShot++;
					sprite.play("yellow");
					break;
				case "Bullet_Enem_Small":
					listEnemS++;
				case "Bullet_Enem_Medium":
					listEnemM++;
				case "Bullet_Enem_Big":
					listEnemB++;
				case "Bullet_Enem_Bonus":
					listEnemBon++;
				default:
					listEnem++;
					sprite.play("red");
			}
		}
		
		override public function removed():void 
		{
			if (this.type == "Bullet_Enem_Small" || this.type == "Bullet_Enem_Medium" ||
			this.type == "Bullet_Enem_Big" || this.type == "Bullet_Enem_Bonus")
			{
				listEnem--;
			}else if (this.type == "Bullet_P")
			{
				listP--;
			}
			Bullet.list--;
		}
		
		public static function resetLists():void 
		{
			list = 0;
			listEnem = 0;
			listEnemS = 0;
			listEnemM = 0;
			listEnemB = 0;
			listEnemBon = 0;
			listP = 0;
		}
		
		public static function resetBulletsAcc():void 
		{
			bulletsShot = 0;
			bulletsHitT = 0;
		}
		
		public static function findAcc():Number 
		{
			if (bulletsShot == 0)
			{
				return 0;
			}
			return bulletsHitT / bulletsShot;
		}
		
		
	}

}