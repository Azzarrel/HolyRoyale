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

    static int m_WorldSeed = 1337;
    static Vector2 m_Size = new Vector2(100, 100);

    public IList<Unit> Units { get; set; }
    public IList<Feature> Features { get; set; }
    public IList<City> Cities { get; set; }
    public IList<Tile> Tiles { get; set; }
    public TileMap TileMap { get; set; }

    public WorldMap()
    {
      Units = new List<Unit>();
      Features = new List<Feature>();
      Cities = new List<City>();
      Tiles = new List<Tile>();
    }

    public override void _Ready()
    {
      TileMap = GetNode<TileMap>("TileMap");
      Populate();
      var city = GetNode<City>("City");
      Cities.Add(city);
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
          {
            TileMap.SetCell(x, y, TileTypes.Plains.Index);
            Tiles.Add(new Tile(new Vector2(x, y), TileTypes.Plains, new List<Feature>()));
          }
          else
          {
            TileMap.SetCell(x, y, TileTypes.Desert.Index);
            Tiles.Add(new Tile(new Vector2(x, y), TileTypes.Desert, new List<Feature>()));
          }
        }
      }
    }

    public void MoveUnit(Unit unit, Vector2 to)
    {
      if(to != null)
      {
        unit.Position = to;
      }
    }

    public IList<Feature> GetFeatures(Vector2 pos)
    {
      return Features.Where(f => f.Position == pos).ToList();
    }


    public Dictionary<Resource, double> GetYield(Vector2 position)
    {
      
      Tile tile = GetTile(position);
      Dictionary<Resource, double> result = new Dictionary<Resource, double>(tile.Type.Yields);
      foreach (Feature feature in tile.Features)
      {
        foreach (KeyValuePair<Resource, double> yield in feature.Yields)

        {
          if (!result.ContainsKey(yield.Key))
          {
            result.Add(yield.Key, 0.0);
          }
          result[yield.Key] += feature.Yields[yield.Key];
        }
      }
      
      return result;
    }

    public Tile GetTile(Vector2 position)
    {
      return Tiles.FirstOrDefault(t => t.Position == position);
    }



    public int GetSlots(Vector2 position)
    {
      return GetTile(position).GetSlots();
    }

    public void CreateFeature(FeatureTag featureTag, Vector2 position )
    {
      var tile = GetTile(position);
      var node = GD.Load<PackedScene>("res://Feature.tscn");
      Feature feature = node.Instance() as Feature;
      feature.Position = GetNode<TileMap>("TileMap").MapToWorld(position) + new Vector2(32, 32);
      Features.Add(feature);
      AddChild(feature);

    }

    public override void _UnhandledInput(InputEvent input)
    {
      base._UnhandledInput(input);

    }

  }
}
