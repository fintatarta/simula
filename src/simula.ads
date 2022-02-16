with Ada.Synchronous_Task_Control;
with Ada.Containers.Ordered_Sets;
with Ada.Containers.Vectors;

package Simula is
   type Time is new Float range 0.0 .. Float'Last;

   type Interval is new Float range 0.0 .. Float'Last;

   type Simulation_Status is private;

   function Current_Time (Status : Simulation_Status) return Time;

   type Suspension_Object is private;

   procedure Sleep (On            : Suspension_Object;
                    Sleeping_Time : Interval);

   type Process_Body is interface;

   type Process_Body_Access is access all Process_Body'Class;

   procedure Initialize (P : in out Process_Body)
   is abstract;

   procedure Run (P      : in out Process_Body;
                  Status : Simulation_Status;
                  Holder : Suspension_Object)
   is abstract;

   type Process (<>) is limited private;

   type Process_Access is access Process;

   function Create (Main : Process_Body_Access) return Process_Access;

   type Simulation_Engine (<>) is tagged limited private;

   procedure Register (Engine : in out Simulation_Engine;
                       P      : Process_Access);

   procedure Simulate (Engine  : in out Simulation_Engine;
                       Stop_At : Time);
private
   type Process_Status is (Ready, Running, Stopped);

   protected type Suspension_Obj is
      procedure Hold (T : Interval);
      procedure Run;

      entry Wait_Process_Hold (T : out Interval);
      entry Wait_Ready;
   private
      State         : Process_Status;
      Sleeping_Time : Interval;
   end Suspension_Obj;

   type Suspension_Object is access Suspension_Obj;

   type Simulation_Engine_Access is access Simulation_Engine;

   task type Process_Engine (My_Body : Process_Body_Access);

   type Process (My_Body : Process_Body_Access) is  tagged limited
      record
         T      : Process_Engine (My_Body);
         Wait   : Suspension_Object;
         Engine : Simulation_Engine_Access;
      end record;

   type Simulation_Status_Holder is
      record
         Now : Time;
      end record;

   type Simulation_Status is access Simulation_Status_Holder;


   type Wake_Up_Event is
      record
         Who          : Process_Access;
         Wake_Up_Time : Time;
      end record;


   function "<" (X, Y : Wake_Up_Event) return Boolean
   is (X.Wake_Up_Time < Y.Wake_Up_Time);

   package Event_Queues is
     new Ada.Containers.Ordered_Sets (Wake_Up_Event);

   package Process_Vectors is
     new Ada.Containers.Vectors (Index_Type   => Positive,
                                 Element_Type => Process_Access);

   type Simulation_Engine_Data is tagged
      record
         Events    : Event_Queues.Set;
         Processes : Process_Vectors.Vector;
         Status    : Simulation_Status;
      end record;

   type Engine_Data_Access is access Simulation_Engine_Data;

   task type Simulation_Worker (Data : Engine_Data_Access)
   is
      entry Run (Stop_At : Time);
   end Simulation_Worker;

   type Simulation_Engine (Data : Engine_Data_Access)  is tagged limited
      record
         Worker : Simulation_Worker (Data);
      end record;
end Simula;
