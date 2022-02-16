pragma Ada_2012;
package body Simula is

   ------------------
   -- Current_Time --
   ------------------

   function Current_Time (Status : Simulation_Status) return Time
   is (Status.Now);

   ----------
   -- Hold --
   ----------

   procedure Hold (P : in out Process; T : Interval) is
   begin
      P.Wait.Hold (T);
      P.Wait.Wait_Ready;
   end Hold;

   --------------
   -- Register --
   --------------

   procedure Register (Engine : in out Simulation_Engine; P : Process_Access)
   is
   begin
      pragma Compile_Time_Warning (Standard.True, "Register unimplemented");
      raise Program_Error with "Unimplemented procedure Register";
   end Register;

   --------------
   -- Simulate --
   --------------

   procedure Simulate (Engine : in out Simulation_Engine; Stop_At : Time) is
   begin
      pragma Compile_Time_Warning (Standard.True, "Simulate unimplemented");
      raise Program_Error with "Unimplemented procedure Simulate";
   end Simulate;

   --------------------
   -- Process_Engine --
   --------------------

   task body Process_Engine is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "Process_Engine unimplemented");
      raise Program_Error with "Unimplemented task Process_Engine";
   end Process_Engine;

   protected body Suspension_Object is
      entry Wait_Process_Hold (Sleep_For : out Interval) when State = Stopped
      is
      begin
         Sleep_For := Sleeping_Time;
      end Wait_Process_Hold;

      entry Wait_Ready when State = Ready
      is
      begin
         State := Running;
      end Wait_Ready;

      procedure Hold (T : Interval)
      is
      begin
         Sleeping_Time := T;
         State := Stopped;
      end Hold;

      procedure Run is
      begin
         State := Ready;
      end Run;
   end Suspension_Object;

end Simula;
