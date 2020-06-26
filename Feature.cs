using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolyRoyal
{
  public class Feature: Node2D
  {
    public string Title { get; set; }
    public Dictionary<Resource, double> Yields { get; set; }
    public int Index { get; set; }
    public int Slots { get; set; }
    public Texture Icon { get; set; }
    public List<FeatureTag> Tags { get; set; }
  }
  public enum FeatureTag
  {
    Buildable,
    Removable,
    Building,
    Animal
  }
  public static class Features
  {
    public static Feature Farm = new Feature()
    {
      Index = 2,
      Title = "Farm",
      Yields = new Dictionary<Resource, double>() { { Resources.Food, 2 } },
      Icon = ResourceLoader.Load("res://features/farm.png") as Texture,
      Tags = new List<FeatureTag>() { 
        FeatureTag.Buildable, 
        FeatureTag.Removable, 
        FeatureTag.Building
      }
    };
    public static Feature Pasture = new Feature()
    {
      Index = 1,
      Title = "Pasture",
      Yields = new Dictionary<Resource, double>() { { Resources.Food, 2 } },
      Icon = ResourceLoader.Load("res://features/pasture.png") as Texture,
      Tags = new List<FeatureTag>() {
        FeatureTag.Buildable,
        FeatureTag.Removable,
        FeatureTag.Building
      }
    };
    public static Feature Cattle = new Feature()
    {
      Index = 0,
      Title = "Cattle",
      Yields = new Dictionary<Resource, double>() { { Resources.Food, 2 } },
      Icon = ResourceLoader.Load("res://features/cattle.png") as Texture,
      Tags = new List<FeatureTag>() {
        FeatureTag.Buildable,
        FeatureTag.Animal
      }
    };
  }
}
