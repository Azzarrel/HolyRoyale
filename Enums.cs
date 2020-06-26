using Godot;
using Godot.Collections;
using System;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolyRoyal
{
  enum Profession
  {
    Hunter, // (Food, Leather)
    Gatherer, // (Early Game Profession, Food on empty Tiles)
    Farmer, // (Food/ Leather/ Wool/ Luxuries)
    Ranger, // (can create ‘game’ Resource, increases Production for neighbouring Forest Tiles)
    Fishermen, // (Food, Luxuries)
    Shepard, // (can be placed on empty meadows, increases yield for wool in neighbouring Pastures)
    Lumberjack, // (Resources)
    Craftsman, // (Resources => Materials)
    Blacksmith, // (Ore, Materials => Weapons, Armor, Materials)
    Bowmaker, // (Materials => Projectiles)
    Engineer, // (Projectiles => Siege Weapons/Materials => Labour/Science)
    Builder, // (Materials => Labour)
    Merchant, // (Gold/Gold based on Trade Routes through this city)
    Mason, // (Materials)
    Miner, // (Materials/Ore/Gold/ Luxuries)
    Noble, //(In Palace, Stability, Happiness)
    Envoy, // (Stability/ Needed for Diplomacy)
    Magistrate, // (Happiness [Suppression]/  Stability/ Culture)
    Artist, // (Musician/Playwright/Poet) (Culture/ Happiness)
    Wizard, // (Faith/Glory/Influence/Science/Tombs/[‘Mage Weapons]’)
    Priest, // (Faith, Happiness, Stability)
    Explorer //(Faster Land Development, +1 Vision)
  }
}
