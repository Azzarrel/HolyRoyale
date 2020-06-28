using Godot;

namespace HolyRoyal
{
  public class Unit : Node2D
  {
	public override void _Ready()
	{
	}

	public void OnTurnEnd()
	{
	  Position = Position + new Vector2(1, 0);
	}
  }
}
