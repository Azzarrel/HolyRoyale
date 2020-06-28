
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolyRoyal
{
  public class TileType
  {
    public Dictionary<Resource, double> Yields { get; set; }
    public int Index { get; set; }
    internal TileType()
    {
      TileTypes.List.Add(this);
    }
  }

  public static class TileTypes
  {
    public static List<TileType> List = new List<TileType>();
    public static TileType Desert = new TileType()
    {
      Yields = new Dictionary<Resource, double>() { { Resources.Gold, 1.0d } },
      Index = 0
    };
    public static TileType Plains = new TileType()
    {
      Yields = new Dictionary<Resource, double>() { { Resources.Food, 3.0d } },
      Index = 1
    };
    public static TileType Water = new TileType()
    {
      Yields = new Dictionary<Resource, double>() { { Resources.Glory, 3.0d } },
      Index = 3
    };
  }
}
