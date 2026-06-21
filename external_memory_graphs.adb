-- Version: 0.01
-- Initial version of External_Memory_Graphs implementation

pragma SPARK_Mode (On);

package body External_Memory_Graphs is

   procedure Initialize_Block (Block : out IO_Block) is
   begin
      -- Initialize to a safe default state
      Block.Edges := (others => (U => 1, V => 1, Weight => 0));
      Block.Count := 0;
   end Initialize_Block;

   procedure Append_Edge (Block    : in out IO_Block;
                          New_Edge : in Edge;
                          Success  : out Boolean) is
   begin
      -- Strict adherence to block capacity B
      if Block.Count < Max_Edges_Per_Block then
         Block.Count := Block.Count + 1;
         Block.Edges (Block.Count) := New_Edge;
         Success := True;
      else
         -- Block is full, requires an I/O write operation to disk
         Success := False;
      end if;
   end Append_Edge;

end External_Memory_Graphs;
