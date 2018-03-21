package 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Text;
	
	public class GameWorld extends World 
	{
		protected var ship:Ship;
		protected var ship2:Ship2;
		private var amountEnemies:int = 2;
		private var enemyWaitCount:Number = 0;
		private var enemyWait:Number = 1.5;
		private var enemies:Array = [];
		// Score
		private var score:Number = 0;
		private var scoreText:Text;
		// Music
		[Embed(source = "../assets/Sound/8 Bit Universe - Star Wars Imperial March.mp3")]
		private const MUSIC_SFX:Class; 
		private var music:Sfx;
		
		public function GameWorld() 
		{
			this.add(new Background());
			this.ship = new Ship(FP.screen.width / 2 - FP.screen.width / 4, FP.screen.height / 1.2);
			this.add(ship);
			this.ship2 = new Ship2(FP.screen.width / 2 + FP.screen.width / 4, FP.screen.height / 1.2);
			this.add(ship2);
			music = new Sfx(MUSIC_SFX);
			music.play(0.3);
			scoreText = new Text("");
			SetTextUI();
			//super();
		}
		
		override public function update():void
		{
			score += FP.elapsed;
			scoreText.text = "Puntos: " + score.toFixed(0);
			SpawnEnemies();
			if (!getInstance("Ship") && !getInstance("Ship2"))
				FP.world = new EndGame(score);
			super.update();
		}
		
		private function SpawnEnemies() :void
		{
			enemyWaitCount += FP.elapsed;
			if (enemyWaitCount >= enemyWait) 
			{
				enemyWaitCount = 0;
				var _enemy:Enemy = new Enemy() as Enemy;
				enemies.push(_enemy);
				this.add(_enemy);
			}
		}
		
		private function SetTextUI() : void 
		{		
			// Score Text
			scoreText.text = "Puntos: ";
			scoreText.color = 0xFFFFFF;
			scoreText.size = 24;
			scoreText.y = FP.screen.height - 50;
			scoreText.x = FP.screen.width / 2 - scoreText.width / 2;
			addGraphic(scoreText);
		}
		
		
	}

}