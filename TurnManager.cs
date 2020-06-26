using Godot;

namespace HolyRoyal
{
  class TurnManager: Node
	{
		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
		}

		private int turn_number = 0;

		[Signal]
		public delegate void EndTurnSignal();

		public void OnEndTurn()
		{
			turn_number++;
			EmitSignal(nameof(EndTurnSignal), this);
		}
	}
}
