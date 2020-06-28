using Godot;
using HolyRoyal;
using System;
using System.Collections;
using System.Collections.Generic;
using Resource = HolyRoyal.Resource;

public class Citizen : Node2D
{

	public bool IsPlaced { get; set; }
	public int ClaimSpeed { get; set; }
	public int Level { get; set; }
	public int Expierience { get; set; }
	public IEnumerable Modifiers { get; set; }
	public WorldMap WorldMap { get; set; }
	public City City { get; set; }

	public Citizen()
	{
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

	public Dictionary<Resource, double> GetYield()
	{
		Dictionary<Resource, double> result = new Dictionary<Resource, double>();
		if(Position != null)
		{
			
			var yields = GetNode<WorldMap>("../..").GetYield(Position);
			foreach (KeyValuePair<Resource, double> yield in yields)
			{
				//ToDo: Increase based on Job
			}
			

		}
		return result;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(float delta)
	{

	}
}
