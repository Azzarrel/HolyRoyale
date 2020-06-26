using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolyRoyal
{


  public class Feature : Node2D
  {


    public Feature()
    {
    }

    public Dictionary<Resource, double> Yields { get; set; }

    public int Slots { get; set; }
  }
}
