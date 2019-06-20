using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Brilliant
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                var res =  QuantumMain.Run(qsim,0,0).Result; //dot Result (no forget)
                var (message1, message2) = res;
                System.Console.WriteLine(
                    $"message1: {message1,-4}, message2: {message2,-4}");
            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}