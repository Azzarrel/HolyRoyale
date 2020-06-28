using Godot;

namespace HolyRoyal
{
  class TurnManager: Node
	{
		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
		}

		private int turnNumber = 0;

		[Signal]
		public delegate void EndTurnSignal();

		public void OnEndTurn()
		{
			turnNumber++;
			EmitSignal(nameof(EndTurnSignal), this);
		}
	}
}
