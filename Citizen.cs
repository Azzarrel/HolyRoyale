using Godot;
using HolyRoyal;
using System;
using System.Collections;

public class Citizen : Node2D
{

	public bool IsPlaced { get; set; }
	public int ClaimSpeed { get; set; }
	public int Level { get; set; }
	public int Expierience { get; set; }
	public IEnumerable Modifiers { get; set; }
	public WorldMap WorldMap { get; set; }
	public City City { get; set; }

	public Citizen(WorldMap map, City city)
	{
		City = city;
		WorldMap = map;
		IsPlaced = false;
		ClaimSpeed = 1;
	}
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Place(Position);
	}

	public void Place(Vector2 position)
	{
	  if(position != null)       
		 Position = position;        
	}

	public void GetYield()
	{
		if(Position != null)
		{
			return WorldMap.GetYied(Position);
		}
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
