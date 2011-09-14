package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class FloatingText extends Entity 
	{
		public var title:Text;
		public var speed:Number;
		public var image:Image;
		public var duration:Number;
		public var timeElapsed:Number;
		public var alpha:NumTween;
		
		public function FloatingText() 
		{
			super();
		}
		
		override public function update():void 
		{
			title.alpha = alpha.value;
			this.y -= speed * FP.elapsed;
		}
		
		public function disappeared():void 
		{
			FP.world.recycle(this);
		}
		
		public function reset(x:Number,y:Number, text:String, duration:Number=0.6):void 
		{
			title = new Text(text);
			this.duration = duration;
			timeElapsed = 0;
			title.size = 18;
			title.color = 0x999999;
			speed = 50;
			alpha = new NumTween(disappeared);
			alpha.tween(1, 0, duration, Ease.cubeIn);
			addTween(alpha);
			graphic = new Graphiclist(title);
			this.x = x - title.width / 2;
			this.y = y - title.height / 2;
		}
		
	}

}