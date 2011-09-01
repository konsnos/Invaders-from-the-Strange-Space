package player 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import objects.bullets.BulletPlayer;
	import objects.GlobalVariables;
	import enemies.Little;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Player extends Entity 
	{
		private var image:Image;
		
		private var hp:Number;
		public function set hpS(setValue:Number):void // Να θυμηθώ να το δοκιμάσω
		{
			hp += setValue;
		}
		private var speed:Number;
		
		private var BulletsMax:Number;
		private var BulletsShot:Number;
		
		private var little:Little;
		
		public function Player(x:Number, y:Number) 
		{
			graphic = image = new Image(GlobalVariables.IMG_PLAYER);
			image.scale = 0.8;
			
			hp = 3;
			speed = 270;
			
			this.x = x - image.width / 2;
			this.y = y;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "player";
			
			BulletsMax = 2;
			BulletPlayer.PlayerShotsS = 0;
			
			layer = 1;
			
		}
		
		override public function update():void 
		{
			/**************** MOVEMENT ****************/
			movement();
			
			/**************** SHOOT BULLET ****************/
			if (Input.pressed("shoot"))
			{
				shoot();
			}
			
			/**************** ALIENS COLLIDED WITH PLAYER ****************/
			little = collide("little", x, y) as Little;
			
			if (little) // Γιατί το έκανα αυτό;
			{
				hp -= little.hpG;
			}
			
			little = null;
		}
		
		public function movement():void 
		{
			if (Input.check("right"))
			{
				this.x += speed * FP.elapsed;
				if (this.x > FP.width - image.width)
				{
					this.x = FP.width - image.width;
				}
			}
			else if (Input.check("left"))
			{
				this.x -= speed * FP.elapsed;
				if (this.x < 0)
				{
					this.x = 0;
				}
			}
		}
		
		public function shoot():void 
		{
			if (BulletPlayer.PlayerShotsG < BulletsMax )
			{
				spawnBullet(this.x + width / 2, this.y);
			}
		}
		
		public function spawnBullet(x:Number, y:Number):void 
		{
			BulletPlayer(world.create(BulletPlayer)).reset(x, y);
		}
		
		public function destroy():void 
		{
			FP.world.recycle(this);
		}
		
	}

}