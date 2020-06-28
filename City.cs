using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolyRoyal
{
    public class City : Node2D
    {

    public static Dictionary<Resource, double> BaseYields = new Dictionary<Resource, double>
    {
      { Resources.Food, 2 },
      { Resources.Gold, 2 },
      { Resources.Materials, 2 },
      { Resources.Housing, 2 }
    };

    public static Dictionary<Resource, double> ResourceCap = new Dictionary<Resource, double>
    {
      { Resources.Food, 100 },
      { Resources.Gold, 100 },
      { Resources.Materials, 100 },
      { Resources.Housing, 0 }
    };


    public IList<Tile> TilesWithProgress { get; set; }
    public IList<Citizen> Citizens { get; set; }

    public Dictionary<Citizen, Tile> CitizensOnTile { get; set; }

    public Dictionary<Resource, double> Storage { get; set; }

    public City()
    {
      Citizens = new List<Citizen>();
      Storage = new Dictionary<Resource, double>();
    }

    public override void _Ready()
    {
      var map = GetNode<TileMap>("/root/root/WorldMap/TileMap").MapToWorld(new Vector2(5, 5));
      GetNode<TurnManager>("/root/root/TurnManager").Connect("EndTurnSignal", this, "OnEndTurn");
      GetNode<Border>("Border").AddTile(new Vector2(5, 5) + new Vector2(0, 0));
      GetNode<Border>("Border").UpdateBorder();
    }

    public Dictionary<Resource, double> GetYields()
    {
      var total = new Dictionary<Resource, double>(BaseYields);
      foreach (Citizen c in Citizens)
      {
        foreach(KeyValuePair<Resource, double> yield in c.GetYield())
        {
          if (!total.ContainsKey(yield.Key))
          {
            total.Add(yield.Key, 0.0);
          }
          total[yield.Key] += total[yield.Key];
        }
      }
      return total;
     }
    
    public void Accumulate()
    {
      foreach(KeyValuePair<Resource, double> yield in GetYields())
      {
        if (!Storage.ContainsKey(yield.Key))
        {
          Storage.Add(yield.Key, 0.0);
        }
        Storage[yield.Key] += Storage[yield.Key];
      }
    }
    
    public void Consume()
    {

    }

    public void Grow()
    {
      GrowPopulation();
      ProgressBuilding();
    }

    public void GrowPopulation()
    {
      if(Storage[Resources.Food] >= 10 &&  Storage[Resources.Housing] > 0)
      {
        Citizen c = GD.Load<PackedScene>("res://Citizen.tscn").Instance() as Citizen;
        Button button = new Button();
        button.MarginLeft = 24;
        button.MarginRight = 40;
        button.MarginTop = 24;
        button.MarginBottom = 40;
        button.MouseDefaultCursorShape = Control.CursorShape.PointingHand;
        button.Set("custom_styles/normal", new StyleBoxFlat());
        ((StyleBoxFlat)button.Get("custom_styles/normal")).BgColor = new Color(0, 0, 0, 0);
        button.Connect("pressed", button, "place_citizen", new Godot.Collections.Array( new List<Citizen>{ c } ) );
        c.AddChild(button);

        Storage[Resources.Food] -= 10;
        AddChild(c);
        Citizens.Add(c);
      }
    }

    public void ProgressBuilding()
    {
      foreach(Tile t in TilesWithProgress)
      {
        foreach(KeyValuePair<Citizen, Tile> c in CitizensOnTile)
        {

        }
      }
    }

    public void OnSelect()
    {
      GetNode<Border>("Border").SetAlpha(1);
      foreach(Citizen c in Citizens)
      {
        c.Show();

      }

      GetNode<CityScreen>("/root/root/UI/CityScreen").SetCity(this);
      GetNode<CityScreen>("/root/root/UI/CityScreen").Show();
    }

    public void PlaceCitizen(Citizen citizen)
    {
      var border = GetNode<Border>("Border").Tiles;
      border.Erase(this.Position);


    }


  }
}
