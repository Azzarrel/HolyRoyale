using Godot;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolyRoyal
{
  public class WorldMap : Node2D
  {

    int m_WorldSeed = 1337;
    Vector2 m_Size = new Vector2(100, 100);

    public IList Units { get; set; }
    public IList Features { get; set; }
    public IList Cities { get; set; }
    public TileMap TileMap { get; set; }

    public WorldMap(TileMap map)
    {
      Units = new List<City>();
      Features = new List<City>();
      Cities = new List<City>();
      TileMap = map;
    }

    public override void _Ready()
    {
      Populate();
      var c = new City();
      Cities.Add(c);
    }

    public void Populate()
    {
      var noise = new OpenSimplexNoise();
      noise.Seed = m_WorldSeed;
      noise.Octaves = 4;
      noise.Period = 20;
      noise.Persistence = 0.8f;

      for (int x = 0; x <= m_Size.x; x++)
      {
        for (int y = 0; y <= m_Size.y; y++)
        {
          if (noise.GetNoise2d(x, y) > 0)
            TileMap.SetCell(x, y, 1);

          else
            TileMap.SetCell(x, y, 0);
        }
      }
    }

    public void MoveUnit(string unit, Vector2 from, Vector2 to)
    {
      if(from != null && to != null)
      {

      }
    }

    public void GetFeatures(Vector2 pos)
    {

    }



  }
}
