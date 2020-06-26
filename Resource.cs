using Godot;
using System.Collections.Generic;

namespace HolyRoyal
{
  public class Resource
  {
    public Texture Icon { get; set; }
    public Color Color { get; set; }
    internal Resource()
    {
      Resources.List.Add(this);
    }
  }

  public static class Resources
  {
    public static List<Resource> List = new List<Resource>();

    public static Resource Food = new Resource()
    {
      Color = Colors.LawnGreen,
      Icon = ResourceLoader.Load("res://apple.png") as Texture
    };
    public static Resource Gold = new Resource()
    {
      Color = Colors.Gold,
      Icon = ResourceLoader.Load("res://gold.png") as Texture
    };
    public static Resource Raw_Material = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Materials = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Mana = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Faith = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Science = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Weapons = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Amunition = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Magical_Weapons = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Ore = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Armor = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Housing = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Culture = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Glory = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Influence = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Wool = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
    public static Resource Leather = new Resource()
    {
      Color = Colors.Black,
      Icon = null
    };
  }
}
