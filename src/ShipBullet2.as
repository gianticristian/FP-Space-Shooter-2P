package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class ShipBullet2 extends Entity 
	{
		[Embed(source="../assets/laserBlue07.png")]
		private const SHIP_BULLET_IMG:Class;
		private var shipBulletImage:Image; 
		private var speed:int = 25;
	
		public function ShipBullet2(x:Number = 0, y:Number = 0) 
		{
			this.shipBulletImage = new Image(SHIP_BULLET_IMG); 
			super(x, y);
		}
		
		public override function added(): void
		{
			this.graphic = shipBulletImage;
			shipBulletImage.scale = 0.5;
			this.width = shipBulletImage.scaledWidth;
			this.height = shipBulletImage.scaledHeight;
			shipBulletImage.centerOrigin();
			centerOrigin();
			shipBulletImage.smooth = true;
			this.type = "ShipBullet";
		}
		
		override public function update():void 
		{
			Move();
			OutScreen();
			Hit();
			super.update();
		}
		
		private function Move():void 
		{
			y -= speed;
		}
		
		private function OutScreen():void 
		{
			if (y < 0 - height) world.remove(this);
		}
		
		private function Hit():void 
		{
			var enemy:Enemy = this.collide("Enemy", x, y) as Enemy;	
			if (enemy) 
			{
				enemy.TakeDamage();
				world.remove(this);
			}
		}
	}

}