using Godot;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolyRoyal
{
  public class Tile 
  {

    public Vector2 Position { get; set; }

    public TileType Type { get; set; }

    public IList<Feature> Features { get; set; }

    public Tile(Vector2 pos, TileType tileType, IList<Feature> features)
    {
      Position = pos;
      Type = tileType;
      Features = features;
    }

    public int GetSlots()
    {
      int slots = 1;
      foreach(Feature f in Features)
      {
        slots += f.Slots;
      }
      return slots;
    }

  }
}
