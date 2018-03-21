package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class EnemyBullet extends Entity 
	{
		[Embed(source="../assets/laserGreen05.png")]
		private const ENEMY_BULLET_IMG:Class;
		private var enemyBulletImage:Image; 
		private var speed:int = 10;
		
		public function EnemyBullet (x:Number = 0, y:Number = 0) 
		{
			this.enemyBulletImage = new Image(ENEMY_BULLET_IMG); 
			super(x, y);
		}
		
		public override function added(): void
		{
			this.graphic = enemyBulletImage;
			enemyBulletImage.scale = 0.5;
			this.width = enemyBulletImage.scaledWidth;
			this.height = enemyBulletImage.scaledHeight;
			enemyBulletImage.centerOrigin();
			centerOrigin();
			enemyBulletImage.smooth = true;
			this.type = "EnemyBullet";	
			
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
			y += speed;
		}
		
		private function OutScreen():void 
		{
			if (y > FP.screen.height + height) world.remove(this);
		}
		
		private function Hit():void 
		{
			var ship:Ship = this.collide("Ship", x, y) as Ship;	
			if (ship) 
			{
				ship.TakeDamage();
				world.remove(this);
			}
			var ship2:Ship2 = this.collide("Ship2", x, y) as Ship2;	
			if (ship2) 
			{
				ship2.TakeDamage();
				world.remove(this);
			}
		}
		
		
		
	}

}