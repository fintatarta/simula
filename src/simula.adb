pragma Ada_2012;
package body Simula is

   ------------------
   -- Current_Time --
   ------------------

   function Current_Time (Status : Simulation_Status) return Time
   is (Status.Now);

   -----------
   -- Sleep --
   -----------

   procedure Sleep (On            : Suspension_Object;
                    Sleeping_Time : Interval) is
   begin
      pragma Compile_Time_Warning (Standard.True, "Sleep unimplemented");
      raise Program_Error with "Unimplemented procedure Sleep";
   end Sleep;

   ------------
   -- Create --
   ------------

   function Create (Main : Process_Body_Access) return Process_Access is
   begin
      return new Process'(My_Body => Main,
                          T       => <>,
                          Wait    => new Suspension_Obj,
                          Engine  => <>);
   end Create;

   --------------
   -- Register --
   --------------

   procedure Register (Engine : in out Simulation_Engine; P : Process_Access)
   is
   begin
      Engine.Data.Processes.Append (P);
   end Register;

   task body Simulation_Worker is
      Stop_Time : Time;
   begin
      accept Run (Stop_At : Time) do
         Stop_Time := Stop_At;
      end Run;

      for P of  Data.Processes loop
         declare
            Sus : Suspension_Object := new Suspension_Obj;
         begin
            P.My_Body.Run (Data.Status, Sus);
         end;
      end loop;
   end Simulation_Worker;
   --------------
   -- Simulate --
   --------------

   procedure Simulate (Engine : in out Simulation_Engine; Stop_At : Time) is
   begin
      Engine.Worker.Run (Stop_At);
   end Simulate;

   --------------------
   -- Suspension_Obj --
   --------------------

   protected body Suspension_Obj is

      ----------
      -- Hold --
      ----------

      procedure Hold (T : Interval) is
      begin
         pragma Compile_Time_Warning (Standard.True, "Hold unimplemented");
         raise Program_Error with "Unimplemented procedure Hold";
      end Hold;

      ---------
      -- Run --
      ---------

      procedure Run is
      begin
         pragma Compile_Time_Warning (Standard.True, "Run unimplemented");
         raise Program_Error with "Unimplemented procedure Run";
      end Run;

      -----------------------
      -- Wait_Process_Hold --
      -----------------------

      entry Wait_Process_Hold (T : out Interval) when Standard.True is
      begin
         pragma Compile_Time_Warning
           (Standard.True, "Wait_Process_Hold unimplemented");
         raise Program_Error with "Unimplemented entry Wait_Process_Hold";
      end Wait_Process_Hold;

      ----------------
      -- Wait_Ready --
      ----------------

      entry Wait_Ready when Standard.True is
      begin
         pragma Compile_Time_Warning
           (Standard.True, "Wait_Ready unimplemented");
         raise Program_Error with "Unimplemented entry Wait_Ready";
      end Wait_Ready;

   end Suspension_Obj;

   --------------------
   -- Process_Engine --
   --------------------

   task body Process_Engine is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "Process_Engine unimplemented");
      raise Program_Error with "Unimplemented task Process_Engine";
   end Process_Engine;

end Simula;
